# oref1 (super advanced features)

NOTE OF CAUTION:
* oref1 is different than oref0, the baseline "traditional" OpenAPS implementation that only uses temporary basal rates.
* As of June 1, oref1-related features are still being tested in the "dev" branch. 

## Only run oref1 with the following caveats in mind: 

* Remember that you are choosing to test a still-in-development future. Do so at your own risk & with due diligence to keep yourself safe.
* You should have run oref0 for more than two weeks, and be very aware of all the types of situations in which your rig might fail
* **We are making a STRONG recommendation that you also have run autotune prior to enabling SMB.** Why? Because if you have wonky ISF settings, for example, you may be more likely to go low or high with SMB. It will help a lot to have run autotune and be aware if the algorithm is recommending changes to ISF, basal, and/or carb ratio. You are not required to run autotune automatically/nightly as part of your loop with SMB; but you should at least run it manually and get an idea for how confident you are in your settings being right or not; and keep that in mind when evaluating SMB outcomes for yourself.
* You should have basals of > 0.5 U/hr. (SMB is *not* advisable for those with very small basals; since .1U is the smallest increment that can be bolused by SMB.  We are also adding a basal check to diable SMB when basals are < 0.3 U/hr.)
* Read the following:
  * A. The updated reference design ([https://openaps.org/reference-design/](https://openaps.org/reference-design/)) that explains the differences between oref0 and oref1
  * B. The following two posts for background on oref1:
    * [https://diyps.org/2017/04/30/introducing-oref1-and-super-microboluses-smb-and-what-it-means-compared-to-oref0-the-original-openaps-algorithm/](https://diyps.org/2017/04/30/introducing-oref1-and-super-microboluses-smb-and-what-it-means-compared-to-oref0-the-original-openaps-algorithm/)
    *  [https://diyps.org/2017/05/08/choose-one-what-would-you-give-up-if-you-could-with-openaps-maybe-you-can-oref1-includes-unannounced-meals-or-uam/](https://diyps.org/2017/05/08/choose-one-what-would-you-give-up-if-you-could-with-openaps-maybe-you-can-oref1-includes-unannounced-meals-or-uam/)
* Make sure you understand what SMB & UAM stand for (**read the above posts, we know you skipped them**!)
* Plan to have a learning curve. You will interact with oref1 differently when on SMB and UAM than how you were interacting with oref0. In particular: **do not do correction boluses**; use temp targets to give the rig a "nudge". You are very likely to overshoot if you try to do things manually on top of what SMB has already done!
* SMB may not be for everyone. Like everything else, plan to test it, fall back to previous methods of diabetes treatment if needed, and give yourself a time period for deciding whether or not it works well for you. 

## Understanding SMB

SMB, like all things in OpenAPS, is designed with safety in mind. (Did you skip reading the updated reference design? Go read that first!) SMB is designed to give you reasonably SAFE amounts of bolus needed upfront and use reduced temporary basal rates to safely balance out the peak insulin timing. You are likely to see many long low or zero temps (upwards of 120 minutes long) with SMB turned on, while oref1 is administering SMBs or waiting until it's safe to do so. 

Single SMB amounts are limited by several factors.  The largest a single SMB bolus can be is the SMALLEST value of:

* 30 minutes of the current regular basal rate, or
* 1/3 of the Insulin Required amount, or
* the remaining portion of your maxIOB setting in preferences

(History of SMB development: https://github.com/openaps/oref0/issues/262)

## Understanding UAM 

UAM will be triggered if the preference is toggled on and there is carb activity detected based on positive deviations. 

(History of UAM development: https://github.com/openaps/oref0/issues/297)

## How to turn on SMB/UAM

1. As of May 16, 2017, SMB/UAM and other oref1 features are in the dev branch of OpenAPS. You should be comfortable updating your rig to the dev branch.

2. To test SMB, you'll need to run oref0-setup with a "microbolus" enable flag to configure it to use SMB in oref0-pump-loop, and also enable the appropriate enableSMB settings in preferences.json. I would enable them one at a time, in your preferred order, and then closely observe the behavior (via both Nightscout and pump-loop.log) in the enabled situation. In addition to testing it in "normal" situations, pay special attention to how it behaves in more extreme situations, such as with rescue carbs (announced or not), post-meal activity, etc.

**(If you cannot read the code to figure out how to interpret the first sentence in number 2; you may not be ready for SMB.)** 

There are multiple preference toggles for SMB/UAM. Check out the [preferences page](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/beyond-low-glucose-suspend.html) for more details on all the settings, but the short version is:

* enableSMB_with_bolus means SMB will be enabled DIA hours after a manual bolus
* enableSMB_with_COB means SMB will be enabled when you've entered carbs
* enableSMB_with_temptarget means SMB will be enabled with eating soon or lower temp targets. For example, if your target is usually 100mg/dL, a temp target of 99 (or 80, the typical eating soon target) will enable SMB. Conversely, a higher temp target (101 if your target is 100) will disable SMB.

3. Another optional feature that might help your SMB (or AMA) deal with entered meal carbs is to set an appropriate "remainingCarbsCap". That should be set to no larger than a typical large meal, and no larger than the number of carbs you'd typically be able to absorb over 4 hours. There is a hard-coded maximum of 90 grams, so don't bother setting anything higher than that. If remainingCarbsCap is set to something above zero, then in situations where carbs have been entered but carb absorption has not yet begun, oref1 will assume that 2/3 of those carbs will be absorbed evenly over the next 4 hours. As a result, oref1 can begin SMB'ing (or AMA high-temping) more so than it otherwise would immediately after entering carbs. If carbs are entered early, this can also act more aggressively than "eating soon", based on trusting that you really will eat (most of) the entered carbs at some point before all the insulin kicks in. 

In other words: If it is set to zero, the SMB will be "less aggressive" than if it is set to a non-zero number approximating a large meal. A non-zero number allows the algorithm to deliver insulin earlier even if not seeing a rise in the CGM value. The higher the value the more aggressive it will be. 

4. To test UAM, you'll need to enableUAM in preferences.json. UAM can be enabled without SMB, but it won't be very effective without enableSMB_with_bolus. You'll probably also want to make sure your nightscout is updated to the latest version to make sure that you can take advantage of UAM prediction lines. To test UAM, you'll first want to be familiar with SMB's "normal" behavior, and then test, with a small meal, giving an up-front bolus (of more than 30m worth of basal, so it can be distinguished from an SMB) and not entering carbs. You'll probably also want to do an "eating soon mode" temporary target or bolus beforehand. You can then observe, by watching the NS purple line predictions and the pump-loop.log, whether your OpenAPS rig is SMB'ing appropriately when it starts to see UAM carb impact.

## Troubleshooting

1. Make sure you read the above, especially the "only enable oref1 if..." section. SMB will behave differently than oref0 would. Watch carefully, and use your common sense and do what's right for you & your diabetes. 
2. Common errors include:
* Not including the enable flag and just changing preferences. You should see "Starting supermicrobolus pump-loop at..." in pump-loop.log if you have successfully enabled everything.
* Pump clock being >1 minute off. This means 60 seconds. Not 61 seconds; 68 seconds; 90 seconds. Needs to be less than 60 seconds apart. `"Checking pump clock: "2017-05-16T15:46:32-04:00" is within 1m of current time: Tue May 16 15:47:40 EDT 2017` is an example of a >60 second gap that needs fixing before it will work properly. We are adding code to automatically attempt to fix this, but until that is merged you'll need to do so manually.

## Pushover, SMB, and OpenAPS

_This is for OpenAPS-specific pushovers related to oref1 features about insulin required (insulinReq) and carbs required (carbsReq). Pushover is a way to easily send messages to your phone from another device with simple messages. If you have Pushover set up for Nightscout, you still need to tell your OpenAPS rig your Pushover information to get these rig-driven alerts._

If enabled (under advanced features in oref0-setup.sh), and you have oref1 enabled, you can get Pushover alerts in the following situations:

* When OpenAPS thinks carbs are needed to bring eventual BG up, and a 30m low temp won't be enough to do it

![Pushover example of carbs needed](../../Images/Pushover_carbs_needed.PNG)

* When SMB is active and hitting maxBolus.  This is intended to alert you when SMB is going "all out", and will tell you the total amount of insulin OpenAPS thinks you require (insulinReq) if current BG trends continue. **DO NOT just blindly bolus for the amount of insulinReq.** You will also see that the pushover alert lists the amount it is attempting to SMB. You should use this notification as a reminder to tell the rig about anything you know it doesn't (like "oh yea, I want to enter my carbs for this meal", or "oh, hold on, I need an activity mode, becuase I'm gonna go for a walk in a few minutes").  You can also decide if a manual meal bolus is appropriate, or if you'd like to manually bolus part of the insulinReq. **If you're just using insulinReq and not doing a normal meal bolus, you should NOT do the full insulinReq as a manual bolus**, as oref1 is already attempting to deliver part of it as a SMB.  SMB is designed to administer the insulinReq a little at a time, in order to be able to safely react if the BG rise slows or stops, so in cases where you might otherwise consider a correction bolus, it'll often be best to not do anything at all and let SMB safely handle the increased need for insulin.  If you do choose to do a small manual correction bolus for a portion of the insulinReq, be sure to subtract out the SMB oref1 is already delivering, and round down for safety.

![(Pushover example of insulinReq](../../Images/Pushover_insulinReq_SMB.PNG)

Cautions:
1. You are likely to cause yourself a low if you manually administer too much insulin. Be very careful about doing manual boluses based on Pushover alerts; see above about not doubling up on a microbolus that's just been delivered.
2. If the rig attempts to deliver a microbolus AND you have the bolus wizard menu open, it may cause the pump to error (and maybe reset). **Recommendation**: If you are getting Pushover alerts and decide to manually bolus in addition to the SMBs, you may want to use the "easy bolus" (up button arrow) method for bolusing, which is less likely to cause the pump to receive this error. When using the easy bolus, you may not be able to deliver the easy bolus if the rig has sent an SMB underneath.  In that case, you'll have to hit escape, wait for the SMB to finish delivering, and then perform your manual bolus (adjusting for the insulin just delivered). 

### If you are new to Pushover:

Pushover is a way to easily send messages to your phone from another device with simple messages. (kind of like getting a text message from your OpenAPS rig), but to use this you must first have Pushover installed on your iPhone or Android (download from your OS's store).

 - Log into https://pushover.net/. From this page you will see your User Key. 
 - At the bottom of the page you will see "Your Applications   (Create an Application/API Token)". You must first create an API Token:
 - Click on the link provided. You must supply a Name for your application, such as "OpenAPS", and change the type to _Script_ 
 - Then Check the box _"By checking this box, you agree that you have read our Terms of Service and our Guide to Being Friendly to our API"_
- This will give you a pushover token.

To put these in your setup you must add them to the oref0-setup.sh parameters, either by saying "Yes" to advanced features in the oref0-setup.sh script and entering the info there, or by running the following on the command line from your rig:

- `cd && ~/src/oref0/bin/oref0-setup.sh --pushover_token=yourpushovertolken --pushover_user=yourpushoverkey`

(_note you will still need to add the correct nomenclature for oref1 in order to use oref1 and pushover_)

