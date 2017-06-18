# Practice and Collect

Starting a DIY loop system like OpenAPS means you are probably switching pumps, and quite possibly using Nightscout for the first time. You may find, like many new users, that settings you thought you had dialed in before will need to be adjusted.  Good news...there's several tools and techiques to get your off to the right start.  They include:

* Use your Medtronic pump **BEFORE** you begin looping
* Practice good CGM habits
* Collect your carb, bolus, and BG history using Nightscout
* Use Autotune to analysis and fine-tune your pump settings

## Use your pump

Many of us have come from Omnipods, Animas, or T-slim pumps in order to pump using old Medtronic pumps. The menus will be different and you need to get proficient with the pump's normal use before complicating things with looping. Become familiar with the reservoir changes and teach your t1d kid, if that's the person who will be using the pump.  Train care-givers on the new pump, as well.

**You should definitely test your basals, ISFs, carb ratios, and DIA all over again now that you've switched pumps and infusion sets. If those settings aren't correct, looping isn't a good idea.  Want some help on how to test those?  Link here (TODO: grab DIYAPS blog posts)**

#### Pump settings

There are a couple areas in the pump that will need to be set specifically in order to allow OpenAPS to loop.  Since you are going to be looping soon, might as well set them correctly in your pump now:

* Set the Temp Basal type to `units per hour` not `%` type.

* Set the carb ratios to grams, not exchange units

* Set the max temp basal rate to a reasonable value (typically no more than 3-4 times your regular basal)

* Set basal profile, carb ratios, and ISF values

* ISFs over 250 mg/dl per unit will need a special step in loop setup (TODO: add link), even though the pump currently will allow you to set them higher.  Just remember later, you will need to run a couple extra commands when you setup your loop.

#### Easy Bolus Button

Setting up the Easy Bolus feature for your pump now (and practicing it) may help you avoid a small, annoying pump error later.  If you are going to use the SMB (super microbolus) feature of oref0, then you need to be aware of the potential for pump error due to remote bolus commands. When the pump is engaged to bolus with a remote bolus command from the rig and another bolus is initiated from the pump manually, the pump will error out with an A52 error. The pump will not deliver the bolus, the reservoir will rewind and the pump time needs to be reset.  Put simply, two bolus commands coming in at once cause the pump to error and rewind.

One way to minimize this error is by checking the pump before giving a bolus. Check to see if the rig is giving a SMB through using the OpenAPS pill in Nightscout, checking the pump-loop log in Papertrail, or logging into the rig and looking at the pump loop. If the rig is actively giving a SMB, then try to time your bolus wizard use to be in the 5 minutes between SMBs (SMBs are only enacted every 5 minutes at most). These steps might be a little too complex for young kids or school nurses, depending on the situation.  If this error happens frequently, you may need to consider turning off SMBs or try using the Easy Bolus button.

The Easy Bolus button allows you to quickly use the arrow buttons on your pump to give a set increment of insulin.  For example, if you setup your Easy Bolus button to have 0.5 unit increments, every click of the `up arrow` on the pump will increment a bolus of 0.5 units...push button 4 times and you are setting up a 2.0 unit bolus.  You still have to click the `ACT` button twice to confirm and start the delivery of the bolus.  Since the button presses are usually pretty quick, there's less likelihood of radio communication interference with a rig's SMB command.  You can use IFTTT buttons to enter the carbs in your Nightscout site (or use careportal in Nightscout directly).  For example, having IFTTT buttons for 5, 10, and 20g carb entries (or whatever your common meal amounts are) can make entering in food pretty easy. So, the Easy Bolus method requires the ability to roughly estimate your meal bolus (e.g., total carbs divided by carb ratio)...but so long as you are close, the loop should be able to make up any amount of bolus that was slightly over/under done by using the Easy Bolus button.

## Practice good CGM habits

A good quality CGM session is a critical part of successful looping.  If you're used to stretching your sensor sessions out until failure...you may want to reconsider this approach as you will have failed looping times, too.  One technique that has helped eliminate early sensor jumpiness in a session is to "presoak" a new sensor before the old one dies when you notice the old sensor is getting jumpy or loses calibration.  To read more about this presoak technique, check out this [blog post](https://diyps.org/2016/06/27/how-to-soak-a-new-cgm-sensor-for-better-first-day-bgs/).  As well, be diligent about your sensor calibration habits.  Only calibrate on flat arrows and when BGs are steady.  Many loopers calibrate once or twice a day only; at bedtime (after dinner has finished digesting) and/or just before getting out of bed.

## Collect your data

Before getting started, we ask that you store at least 30 days of CGM data.  Nightscout is an excellent tool to capture your CGM history, as well as log your carbs and boluses.  For instructions on setting up your own Nightscout site (or updating your existing one for OpenAPS use), see [here](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-1/nightscout-setup.html).  By logging and collecting a recent history of your insulin+BG patterns, you can also take advantage of the Autotune feature which uses Nightscout databases.

If you aren't using Nightscout, you can upload your Dexcom G4 receiver to Dexcom Studio or if you use Dexcom G5 the data is in the cloud at Dexcom Clarity, if you use a Medtronic CGM, upload your CGM data to CareLink.  If you use an Animas Vibe, upload your data to Tidepool or Diasend.  We suggest you get in the habit of doing this regularly so that you have ongoing data to show trends in your overall estimated average glucose (eAG, a good indicator in trends in A1c) and variations in your "time in range."

Later in these docs is a link to donate your data to a project called [OpenHumans](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-4/data-commons-data-donation.html).  There is no requirement to share your data or participate in the OpenHumans.  If you choose to, you can donate your data whether you are looping or not.  Individuals within the project who share their data do so at will and you should do the same only if you feel comfortable. That being said, it is always a good idea to record your data before embarking on a new set of experiments. This will be helpful to understand the effects of the system as well as gain a better understanding of your response to different control strategies.

## Autotune

You've been logging and recording your carbs and boluses in Nightscout, right?  You have your CGM data flowing into Nightscout too?  Great...now autotune can give you a headstart to fine-tuning your basals and ISF. There are some restrictions on autotune still (only a single daily carb ratio and single daily ISF), but there are tips on the [autotune page](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-4/autotune.html) for how to deal with multiple values. You can run autotune before you get your loop setup...it doesn't have to run on a rig.

How important are good basals and ISFs? You mean you weren't convinced already by the amount of work put into autotune itself? Well, autotune (soon will be) a required step in order to enable SMBs in the new version of oref0. The new version will check to see if you have an autotune directory in your rig before the loop will be allowed to actually enact any SMBs (no matter what your preferences say). To fulfill this requirement you can do one of the following which will create an autotune directory where it needs to be:

* enable autotune during your OpenAPS setup script and autotune will run automatically as part of your loop.
* run autotune as a one-off (single run) on your rig using the directions given in the link above
* create an empty autotune directory to trick the system...but why would you want to do that? If you choose to do that, you do so at your own risk and are acknowledging that you are confident in your pump settings.

