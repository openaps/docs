# Collect your data and get prepared

Before getting started, we ask that you store at least 30 days of CGM data.  Nightscout is an excellent tool to capture your CGM history, as well as log your carbs and boluses.  For instructions on setting up your own Nightscout site (or updating your existing one for OpenAPS use), see [here](./nightscout-setup.html).  By logging and collecting a recent history of your insulin+BG patterns, you can also take advantage of the Autotune feature which uses Nightscout databases.

If you aren't using Nightscout, you can upload your Dexcom G4 receiver to Dexcom Studio or if you use Dexcom G5 the data is in the cloud at Dexcom Clarity.  If you use a Medtronic CGM, upload your CGM data to CareLink.  If you use an Animas Vibe, upload your data to Tidepool or Diasend.  We suggest you get in the habit of doing this regularly so that you have ongoing data to show trends in your overall estimated average glucose (eAG, a good indicator in trends in A1c) and variations in your "time in range."

Later in these docs is a link to donate your data to a project called [OpenHumans](../Give%20Back-Pay%20It%20Forward/data-commons-data-donation.html).  There is no requirement to share your data or participate in OpenHumans.  If you choose to, you can donate your data whether you are looping or not.  Individuals within the project who share their data do so willingly and you should do the same only if you feel comfortable. That being said, it is always a good idea to record your data before embarking on a new set of experiments. This will be helpful to understand the effects of the system as well as gain a better understanding of your response to different control strategies.

## Practice good CGM habits

A good quality CGM session is a critical part of successful looping.  If you're used to stretching your sensor sessions out until failure, you may want to reconsider this approach as you will have failed looping times, too.  One technique that has helped eliminate early sensor jumpiness in a session is to "presoak" a new sensor before the old one dies when you notice the old sensor is getting jumpy or loses calibration.  To read more about this presoak technique, check out this [blog post](https://diyps.org/2016/06/27/how-to-soak-a-new-cgm-sensor-for-better-first-day-bgs/).  In addition, be diligent about your sensor calibration habits.  Only calibrate on flat arrows and when BGs are steady.  Many loopers calibrate once or twice a day only; at bedtime (after dinner has finished digesting) and/or just before getting out of bed. A good guide to sensor calibration - which generally applies regardless of which sensor you have - can be found [here](https://forum.fudiabetes.org/t/how-to-calibrate-a-dexcom-g4-g5-cgm/2049/).

## Use your gear

Starting a DIY loop system like OpenAPS means you are probably switching pumps, and quite possibly using Nightscout for the first time. You may find, like many new users, that settings you thought you had dialed in before will need to be adjusted.  Good news, there are several tools and techiques to get you off to the right start.  They include:

* Use your Medtronic pump **BEFORE** you begin looping
* Practice good CGM habits
* Collect your carb, bolus, and BG history using Nightscout
* Use Autotune to analyze and fine-tune your pump settings

### Start Medtronic pump

Many of us have come from  Animas, OmniPods, Roche, or t:slim pumps in order to pump using old Medtronic pumps. The menus will be different and you need to get proficient with the pump's normal use before complicating things with looping. Become familiar with the reservoir changes and teach your T1D kid, if that's the person who will be using the pump.  Train care-givers on the new pump, as well. Assuming that you're already familiar with insulin pumping (and you should be before trying to loop) but new to these old Medtronic pumps, these "quick memu" guides will help:

* x12: https://www.medtronicdiabetes.com/sites/default/files/library/download-library/user-guides/x12_user_guide.pdf
* x15: https://www.medtronicdiabetes.com/sites/default/files/library/download-library/user-guides/x15_user_guide.pdf
* x22: https://www.medtronicdiabetes.com/sites/default/files/library/download-library/workbooks/x22_menu_map.pdf (aka "REAL-TIME")
* x23: https://www.medtronicdiabetes.com/sites/default/files/library/download-library/workbooks/x23_menu_map.pdf (aka "REAL-TIME REVEL™")
* x54: https://www.medtronic-diabetes.co.uk/sites/uk/medtronic-diabetes.co.uk/files/veo-x54_ifu_updated_26.04.2013.pdf (aka "Veo™")

**You should definitely test your basals, ISFs, carb ratios, and DIA all over again now that you've switched pumps and infusion sets. If those settings aren't correct, looping isn't a good idea.**

#### Pump settings

There are a couple areas in the pump that will need to be set specifically in order to allow OpenAPS to loop.  Since you are going to be looping soon, you might as well set them correctly in your pump now:

* Set the Temp Basal type to `units per hour` not `%` type.

* Set the carb ratios to grams, not exchange units.

* Set the max basal rate to a reasonable value (typically no more than 3-4 times your regular basal).

* Set basal profile, carb ratios, and ISF values.

* ISFs over 250 mg/dl per unit will need a special step in loop setup (TODO: add link), even though the pump currently will allow you to set them higher.  Just remember later, you will need to run a couple extra commands when you setup your loop.

* If you have periods in the day where your pump normally has basal settings of zero - your loop will not work! You can resolve this by setting the lowest possible basal setting your pump will permit. OpenAPS will then issue temp basals of zero, as needed.

#### Easy Bolus Button

Setting up the Easy Bolus feature for your pump now (and practicing it) may help you avoid a small, annoying pump error later.  If you are going to use the (super advanced, not for beginners) SMB (super microbolus) feature, then you need to be aware of the potential for pump error due to remote bolus commands. When the pump is engaged to bolus with a remote bolus command from the rig and another bolus is initiated from the pump manually, the pump will error out with an A52 error. The pump will not deliver the bolus, the reservoir will rewind and the pump time needs to be reset.  Put simply, two bolus commands coming in at once cause the pump to error and rewind.

One way to minimize this error is by checking the pump before giving a bolus. Check to see if the rig is giving a SMB by using the OpenAPS pill in Nightscout, checking the pump-loop log in Papertrail, or logging into the rig and looking at the pump loop. If the rig is actively giving a SMB, then try to time your bolus wizard use to be in the 5 minutes between SMBs (SMBs are only enacted every 5 minutes at most). These steps might be a little too complex for young kids or school nurses, depending on the situation.  If this error happens frequently, you may need to consider turning off SMBs or try using the Easy Bolus button.

The Easy Bolus button allows you to quickly use the arrow buttons on your pump to give a set increment of insulin.  For example, if you setup your Easy Bolus button to have 0.5 unit increments, every click of the `up arrow` on the pump will increment a bolus of 0.5 units.  Push the button 4 times and you are setting up a 2.0 unit bolus.  You still have to click the `ACT` button twice to confirm and start the delivery of the bolus.  Since the button presses are usually pretty quick, there's less likelihood of radio communication interference with a rig's SMB command.  You can use IFTTT buttons to enter the carbs in your Nightscout site (or use Care Portal in Nightscout directly).  For example, having IFTTT buttons for 5, 10, and 20g carb entries (or whatever your common meal amounts are) can make entering in food pretty easy. The Easy Bolus method requires the ability to roughly estimate your meal bolus (e.g., total carbs divided by carb ratio).  As long as you are close, the loop should be able to make up any amount of bolus that was slightly over/under done by using the Easy Bolus button.

#### Extended and Dual Wave substitute

Due to the way Medtronic pumps operate, temp basals can only be set when there is no bolus running, including extended (square) and dual wave boluses.  If you're used to extended or dual wave boluses for carb heavy meals (e.g., pizza), which may still be the optimal approach for you, OpenAPS will not be able to provide temp basals during the extended bolus.  You won't be looping during those types of boluses.

But, you don't need the square/dual wave boluses anymore, as OpenAPS will help simulate the longer tail insulin needed if you've entered carbs into the system. Also, many loopers have found they can convert to a split bolus strategy to effectively deal with the same meals.  There is a carb+insulin+BG simulator called [Glucodyn](http://perceptus.org) that can be used to model a split bolus strategy for those meals.  By setting different bolus times and bolus amounts, the model allows the user to slide adjustments to minimize early-meal lows as well as late meal rises.  For example, you may find that a 20 minute pre-bolus of 50% of the carbs and a later bolus for the remaining 50% will work well, with looping helping to make up the difference that an extended bolus used to provide.  You can practice the transition to split bolusing even before you get your loop running.

Some of the super advanced features you'll learn about later - Unannounced Meals and Supermicrobolus (UAM/SMBs) - also help smooth the transition from extended bolusing.  Some users have found that entering in carbs alone can be effective, especially in helping later BG rises from slow-absorping carbs.  Once you get your loop running, and are ready for the advanced features, you may be interested in playing with the various techniques available for heavy, slow carb meals.

### Autotune

You've been logging and recording your carbs and boluses in Nightscout, right?  You have your CGM data flowing into Nightscout too?  Great...now autotune can give you a headstart to fine-tuning your basals and ISF. There are some restrictions on autotune still (only a single daily carb ratio and single daily ISF), but there are tips on the [autotune page](http://openaps.readthedocs.io/en/latest/docs/Customize-Iterate/autotune.html) for how to deal with multiple values. You can run autotune before you get your loop setup...it doesn't have to run on a rig.

How important are good basals and ISFs? You mean you weren't convinced already by the amount of work put into autotune itself? Well, autotune is a required step in order to enable the most advanced features (SMB and UAM). The new version will check to see if you have an autotune directory in your rig before the loop will be allowed to actually enact any SMBs (no matter what your preferences say). To fulfill this requirement you can do one of the following which will create an autotune directory where it needs to be:

* enable autotune during your OpenAPS setup script and autotune will run automatically as part of your loop.
* run autotune as a one-off (single run) on your rig using the directions given in the link above

Regardless of if you want to use advanced features later, we highly recommend running autotune as part of the rig nightly, or as a one-off and periodically checking the output to see if the settings on the pump that you are using reflect what the data says your body really needs.
