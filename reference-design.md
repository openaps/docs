(Last updated April 29, 2017)

# Principles of an Open Artificial Pancreas System (OpenAPS)

The Open Source Artificial Pancreas System (OpenAPS) is a safe but powerful, advanced but easily understandable, Artificial Pancreas System (APS) designed to automatically adjust an insulin pump’s insulin delivery to keep blood glucose (BG) in a safe range at all times. It does this by communicating with an insulin pump to obtain details of all recent insulin dosing (basal and boluses), by communicating with a Continuous Glucose Monitor (CGM) to obtain current and recent BG estimates, and by issuing commands to the insulin pump to adjust insulin dosing as needed.

OpenAPS differs from other APS currently in clinical trials in two significant ways.
    
    First, it is designed to use existing approved medical devices, commodity hardware, and open source software.
    
    Secondly, it is designed primarily for safety, understandability, and interoperability with existing treatment approaches and existing devices.

By taking this approach, OpenAPS has been demonstrated to be both safer and more effective than current state-of-the-art standalone insulin pump therapy, and more effective than the insulin-only hybrid closed loop and APS systems that have been in clinical trials for years and are just starting to receive FDA approval and come to market.

OpenAPS is designed to work with interoperable insulin pumps and CGMs from any manufacturer. Current implementations use older Medtronic or SOOIL (`DANA*R`, available in Europe) insulin pumps with either Dexcom or Medtronic CGMs. The same design would also work with insulin pumps from any manufacturer who provides a way to issue temporary basal commands to the pump, and with any CGMs whose data can be retrieved in real time.  Until and unless companies elect to provide such access, the open source community will continue reverse engineering additional insulin pumps wherever possible to make APS technology as widely available as possible until all individuals living with Type 1 Diabetes have the opportunity to sleep safely every night.

## Designing OpenAPS for maximum safety

OpenAPS is designed, first and foremost, for safety.  This means that, for every single decision it makes to dose insulin (or refrain from doing so), the OpenAPS dosing algorithm must ensure that the decision it makes is the safest one possible, given the information available at the time.  Because OpenAPS is running on external hardware and not as an algorithm built into an insulin pump, the safest way to do so is to set temporary basal rates such that running the temporary basal to completion and then resuming normally scheduled basal will maximize the user’s chance of keeping their blood sugar inside a safe target range, even without any further intervention on the part of OpenAPS or the user (via eating carbohydrates, for example). If new information indicates that finishing the current temporary basal would result in an overcorrection in either direction, OpenAPS will immediately cancel the temporary basal or make other adjustments to insulin dosing as needed.

While they have improved markedly over the last few years, CGM sensors are not perfect.  To safely dose insulin based on data from a CGM, OpenAPS does not place undue, excess reliance on any single glucose measurement. Because new CGM measurements are received every 5 minutes, OpenAPS can continually recalculate the insulin dosing adjustments required to bring BG back to the target range. If the CGM provides erroneous data, such as from a dying sensor or a compression event (where someone is lying directly on the sensor and restricting blood flow), OpenAPS will react conservatively by withholding or slightly increasing insulin dosing. If 5, 10, or 15 minutes later the new data from the CGM indicates that the temporary basal rate currently running is no longer appropriate, OpenAPS can simply cancel the temporary basal and return to the normally scheduled basal rate, or make other dosing adjustments if necessary.  By ensuring that all available information, including BG level and trend information and insulin dosing history, is used in determining all insulin dosing decisions, OpenAPS can safely mitigate high blood sugar levels while minimizing hypoglycemia risk.

In addition, OpenAPS is designed to simply and safely fall back to the patient’s pre-programmed basal therapy whenever it receives conflicting information about what the appropriate course of action is (or when required information is missing). For example, if BG is predicted to eventually go low but is actually rising at that moment, OpenAPS can cancel any temporary basals and wait to see whether BG continues rising or begins to fall, and only then begin issuing the appropriate temporary basal commands. Additionally, OpenAPS further ensures safety by falling back to traditional “low glucose suspend” behavior when current BG is below a configured threshold and falling or not rising fast enough. This ensures that insulin infusion is completely withheld while BG remains low for any reason, until it starts to recover, which maximizes the ability to recover from hypoglycemia.

Another key element of safety is ensuring that users know what to expect from the system, and can fully inspect what it is doing and why, and adapt it as needed to properly treat their own diabetes.  Therefore, OpenAPS is designed to rely, as much as possible, on the same parameters and dosing algorithms used by the patient (at the instruction of their diabetes care team) in deciding the appropriate rate of insulin in any situation. This means using the basal rates, insulin sensitivity factor (ISF, also known as correction factor), duration of insulin action (DIA, also known as insulin lifetime), and optionally the insulin to carb (IC) ratio the patient is already using to drive their existing pump therapy. It also means using the exact same simple insulin dosing calculations the pump’s bolus calculator (or the patient) already uses. OpenAPS does not have any complicated machine learning algorithms, 17-parameter insulin response models, or differential equations. As such, **OpenAPS system is open and transparent in how it works**, and understandable not just by experts, but also by clinicians and end users (patients).

## Safety design constraints in oref0, the original OpenAPS algorithm

The original OpenAPS algorithm, called oref0 (short for OpenAPS Reference Design Zero), was designed with several additional design constraints to ensure safety.  This ensured that, even though OpenAPS was a new and untested system still under active development, it would be safe to use without adding significant risk of dangerous blood sugar outcomes in the event of an interruption in communications, or even a bug or design flaw that resulted in repeatedly issuing the same command over and over.

While the oref0 software is far more mature than when it was first designed, we have found that these constraints also make the system extremely robust to incorrect pump settings (basals, ISF, DIA, and CR), bad CGM data, or other potential problems.  Therefore, we believe that for anyone building their first Artificial Pancreas System, these design constraints are still the safest, most conservative way to ensure that OpenAPS always makes living with diabetes safer than it would be without APS assistance.  Therefore, these design constraints will likely remain a core part of oref0 indefinitely, and oref0 will remain the system of choice for anyone building OpenAPS.  New users can continue using oref0 as long as they’d like, but should do so at least until they have demonstrated its safety to their own satisfaction.

1.	The first such oref0 design constraint is that **OpenAPS oref0 cannot issue insulin boluses**. This is a key safety feature, because insulin pumps, while they have limits on the maximum size of bolus they will administer, generally have no effective limit on how frequently boluses may be administered. As a result, any system that is capable of issuing bolus commands would be capable of administering, if it erroneously issued bolus commands repeatedly, a potentially lethal quantity of insulin. To completely avoid this issue, oref0 instead relies solely on temporary basal commands. Repeatedly reissuing the same temporary basal command does not change the rate at which the pump infuses insulin; it simply extends the temporary basal rate slightly. In addition, insulin pumps are configured with a maximum allowed temporary basal rate, and will simply ignore any commands that instruct the pump to use a higher rate than allowed.

2.	This **maximum allowed temporary basal rate** is the second design constraint: OpenAPS oref0 is designed to be incapable of administering insulin any faster than can be easily counteracted with fast-acting carbohydrates. This means that oref0 cannot be used to substitute for mealtime insulin boluses, but more importantly it means that, even if OpenAPS were to malfunction in the worst possible way, the patient can completely prevent any adverse outcome by simply consuming additional carbs as needed, as they already must do with standard diabetes treatment every day or two for any number of other reasons.

3.	OpenAPS oref0 generally **defers to the patient when they choose to issue their own boluses, either for corrections or for meals**. In such a situation, oref0 makes an estimate of how long the (bolus-wizard inputted or assumed) meal is expected to take to digest (or how long the BG excursion is expected to continue, if it’s something other than a meal). It then continues to monitor BG, but avoids issuing any temporary basal rates until that is clearly required again.

4.	**OpenAPS oref0 is designed to operate completely autonomously, without requiring any specific interaction from the patient**, and to upload CGM and pump data in real time whenever Internet connectivity is available for remote monitoring. The patient simply uses the pump per their usual therapy for mealtime dosing, and OpenAPS works in the background to temporarily override the underlying basal rates so that the patient rarely needs to take corrective action for hyper- or hypoglycemia. The uploaded data can be made available via remote monitoring for the patient and their caregivers / loved ones, allowing them to keep an eye on their BGs, and make sure OpenAPS is continuing to work properly, at all times. 

## OpenAPS Design Details

### Medical device communication

OpenAPS periodically (i.e. every 5 minutes) reads new data from the CGM as it becomes available. It also periodically (every few minutes) queries the insulin pump for current settings and recent activity, such as current (scheduled or temporary) and maximum basal rates, recent boluses, IOB (if available), ISF, DIA, carb ratio, BG target/range, etc. If that query is successful, OpenAPS updates its bolus wizard calculations (detailed below) and determines whether any action is required (canceling or issuing a temporary basal).

If action is required, OpenAPS issues the appropriate insulin dosing command to the pump, confirms that it was received and acknowledged by the pump, and then performs another query for recent activity to make sure any new temporary basal successfully took effect.

### Algorithms

#### Basic overnight operation (oref0)

OpenAPS uses the pump’s bolus and temporary basal history, combined with the pump’s DIA and published IOB curves, to calculate current net IOB (net insulin on board or active in the body). (Currently, pumps only include boluses when calculating IOB: a more correct and useful IOB calculation includes the net impact of temporary basals vs. normally scheduled basal rates.) If no boluses have been administered recently (see “Bolus Snooze” below), OpenAPS can then use the current CGM glucose reading to calculate an eventual BG estimate using simple bolus calculator math: current BG – (ISF * IOB) = eventual BG.

If current BG is below a configured threshold (defaulting to 30mg/dL below the target range), OpenAPS enters low glucose suspend mode, and simply continues to issue 30-minute temp basals to zero as long as BG is not rising. Otherwise, OpenAPS determines whether the eventual BG is projected to be above or below the target range, and makes note of whether the CGM glucose readings are currently rising or falling more than expected. It then decides on the appropriate course of action as follows:

```
    if BG is rising but eventual BG is below target, cancel any temp basals.
    else, if BG is falling but eventual BG is above target, cancel any temp basals.
    else, if eventual BG is above target:
        calculate 30m temp required to get eventual BG down to target
        if required temp is > existing basal, issue the new high temp basal
        else, if BG is below target:
            calculate 30m temp required to get projected BG up to target
            if required temp is < existing basal, issue the new low temp basal
                if >30m @ 0 required, extend zero temp to 30m
```

The maximum temp basal rate is set on the pump, but for safety purposes OpenAPS will set a lower maximum temp basal rate if necessary, as the minimum of:

```
The pump’s maximum temp basal rate
3x the maximum daily scheduled basal rate
4x the current scheduled basal rate
```

This helps ensure that the patient will always be able to recover from any excessive insulin simply by eating fast-acting carbs.

#### Adjusting for unexpected BG deviation

The algorithm above is sufficient for a simple and safe OpenAPS implementation, and has been successfully tested by hundreds of users over years of combined use. However, in situations where BG is rising or falling unexpectedly, or remaining stubbornly high, we discovered that it is also useful to take into account how much the Blood Glucose rise/fall rate is deviating from what would be expected based on insulin activity. This allows more advanced OpenAPS implementations to respond more quickly when BG starts to rise or fall more than expected, and allows it to continue high temp basals when BG is stubbornly high and mostly flat (falling far less than expected).

To calculate this deviation, OpenAPS first calculates a term we call “BG Impact” or BGI, which is simply the current insulin activity (first derivative of IOB) * insulin sensitivity. When expressed in units of mg/dL/5m, this represents the degree to which BG “should” be rising or falling, and can be directly compared to the delta between the current and last CGM reading, or an average delta over the last 15m or so. To calculate the deviation, OpenAPS does exactly this comparison, between the 15m average delta in CGM readings and the predicted BGI. It then applies that deviation as an adjustment to the eventual BG prediction. This is based on the simple assumption that if BG is rising or falling more than expected over the last 15 minutes, that trend is likely to continue over the next 15-30 minutes, and the magnitude of the projected deviation is approximately equal to what was seen over the last 15 minutes. In future OpenAPS implementations it may be possible to come up with better predictive algorithms of this sort, but this simple algorithm has worked quite well over many months of real-life use so far.

In addition to adjusting the eventual BG predictions, the BGI calculation above is also used in advanced OpenAPS implementations to allow a high temp basal to continue running if BG is dropping slower than expected (less than ½ of BGI), and similarly to set low temp basals if BG is rising slower than expected or falling more quickly than expected.

#### Bolus snooze

By adjusting for BG deviations as described above, OpenAPS can avoid issuing low temp basals when BG is rising or remaining high after a meal, even without being informed about the fact that a meal has been consumed, or being provided a carbohydrate count. However, it is also useful for OpenAPS to avoid issuing low temp basals that counteract a meal bolus or prebolus when BG has not yet started to rise. To accomplish this, OpenAPS applies a “bolus snooze”, which causes OpenAPS to effectively go “hands off” as soon as a user executes a bolus, and only take action again if/when BG drops below the low glucose suspend threshold, rises more than expected or fails to come down after the mealtime rise, or starts to drop faster than expected. As a result, users can simply bolus appropriately for their meal, and then OpenAPS will wait and take over basal adjustment as necessary to bring BGs back into range after any mealtime excursions.

The bolus snooze is currently implemented in advanced OpenAPS implementations by tracking bolus IOB (with an accelerated decay based on half the user’s normal DIA) separately from net IOB, and re-adding the BG impact of the bolus IOB (plus a small multiple) when deciding whether to set a low temporary basal. If the resulting “snooze BG” term is higher than the BG target, then OpenAPS will not set a low temporary basal, even if the eventual BG (based solely on net IOB) is much lower than target. This results in OpenAPS effectively widening the target BG range immediately after a bolus, and then gradually narrowing it over the next hour or two and gradually returning to normal behavior.

As most insulin pumps do not calculate net IOB, and use bolus-only IOB in the bolus calculator, it is necessary to take an additional precaution to help prevent the patient from manually administering an excessive bolus by following the bolus calculator. This is accomplished through a “maximum IOB” setting, which instructs OpenAPS to never set high temp basals that would allow the net IOB to exceed the bolus IOB by more than a user-configured amount. Unless configured otherwise by the user setting up OpenAPS implementation, this maximum net IOB defaults to zero, which means that OpenAPS will act only as a predictive low glucose suspend system, and will high-temp after BG starts to recover if IOB is negative, but will not issue high temp basals if BG is high.

#### Beyond oref0

Over the last two years, OpenAPS has evolved from an idea, and a bare-bones toolkit used only by its cofounders, into an open-source software package used by hundreds of individuals of all skill levels to build their own DIY closed loop artificial pancreas systems.  As this DIY community has steadily accrued over a million hours of experience using such systems in real-world situations, we have shared with each other what we’ve learned, and gradually made many improvements to the basic “fits-on-a-postcard” oref0 algorithm (described above) that still forms the core of all OpenAPS systems.

One notable improvement was the addition of the “Advanced Meal Assist” feature, commonly referred to inside the OpenAPS community as AMA.  AMA provides a highly adaptable algorithm for safely dosing insulin after meals, despite widely varying meal types, and the high variance in digestion speed between individuals. While AMA can deal very effectively with meal variations, it still requires the user to count and enter their carbs, and administer a meal bolus when the meal is eaten.  This is mostly due to the relatively slow speed of action of even “fast-acting” insulin, which takes over an hour to reach peak insulin activity, and therefore requires very careful dosing to preempt post-meal blood sugar spikes while avoiding hypoglycemia in the event that carbohydrate absorption slows or stops suddenly (for example, due to walking home from a restaurant).

Despite these limitations, AMA is apparently still the most advanced postprandial insulin dosing algorithm in widespread human use, so there has been a lot of interest in seeing whether it could be extended to further reduce the burden on patients using it, and more completely automate insulin dosing in all situations. 

### Introducing oref1 and supermicroboluses

To move in that direction, we have developed an extension of the oref0 AMA algorithm, which we are calling oref1.  The notable difference between the oref0 and oref1 algorithms is that oref1 makes use of small “supermicroboluses” (SMB) of insulin at mealtimes to more quickly (but safely) administer the insulin required to respond to blood sugar rises due to carb absorption.  

The microboluses administered by oref1 are called “super” because they use a miniature version of the “super bolus” technique to safely dose mealtime insulin more rapidly.  This SMB technique involves first setting a temp basal rate of zero (0) U/hr, of sufficient duration to ensure that BG levels will return to a safe range with no further action even if carb absorption slows suddenly (for example, due to post-meal activity or GI upset) or stops completely (for example due to an interrupted meal or a carb estimate that turns out to be too high). As with oref0, the oref1 algorithm continuously recalculates the insulin required every 5 minutes based on CGM data and previous dosing, which means that oref1 will continually issue new supermicroboluses every 5 minutes, increasing or reducing their size as needed as long as CGM data indicates that blood glucose levels are rising (or not falling) relative to what would be expected from insulin alone.  If BG levels start falling, there is generally already a long zero temp basal running, which means that excess IOB is quickly reduced as needed, until BG levels stabilize and more insulin is warranted.

#### Safety considerations introduced by oref1

Automatically administering boluses safely is of course the key challenge with such an algorithm, as we must find another way to avoid the issues highlighted in the oref0 design constraints.  In oref1, this is accomplished by using several new safety checks (as outlined here), and verifying all output, before the system can administer a SMB. 

At the core of the oref1 SMB safety checks is the concept that OpenAPS must verify, via multiple redundant methods, that it knows about all insulin that has been delivered by the pump, and that the pump is not currently in the process of delivering a bolus, before it can safely do so.  In addition, it must calculate the length of zero temp required to eventually bring BG levels back in range even with no further carb absorption, set that temporary basal rate if needed, and verify that the correct temporary basal rate is running for the proper duration before administering a SMB.

To verify that it knows about all recent insulin dosing and that no bolus is currently being administered, oref1 first checks the pump’s reservoir level, then performs a full query of the pump’s treatment history, calculates the required insulin dose (noting the reservoir level the pump should be at when the dose is administered) and then checks the pump’s bolusing status and reservoir level again immediately before dosing.  These checks guard against dosing based on a stale recommendation that might otherwise be administered more than once, or the possibility that one OpenAPS rig might administer a bolus just as another rig is about to do so.  In addition, all SMBs are limited to 1/3 of the insulin known to be required based on current information, such that even in the race condition where two rigs nearly simultaneously issue boluses, no more than 2/3 of the required insulin is delivered, and future SMBs can be adjusted to ensure that oref1 never delivers more insulin than it can safely withhold via a zero temp basal.

In some situations, a lack of BG or intermittent pump communications can prevent SMBs from being delivered promptly.  In such cases, oref1 attempts to fall back to oref0 + AMA behavior and set an appropriate high temp basal.  However, if it is unable to do so, manual boluses are sometimes required to finish dosing for the recently consumed meal and prevent BG from rising too high.  As a result, oref1’s SMB features are only enabled as long as carb impact is still present: after a few hours (after carbs all decay), all such features are disabled, and oref1-enabled OpenAPS instances return to oref0 behavior while the user is asleep or otherwise not engaging with the system.

In addition to these safety status checks, the oref1 algorithm’s design helps ensure safety.  As already noted, setting a long-duration temporary basal rate of zero while super-microbolusing provides good protection against hypoglycemia, and very strong protection against severe hypoglycemia, by ensuring that insulin delivery is zero when BG levels start to drop, even if the OpenAPS rig loses communication with the pump, and that such a suspension is long enough to eventually bring BG levels back up to the target range, even if no manual corrective action is taken (for example, during sleep).  Because of these design features, oref1 may even represent an improvement over oref0 w/ AMA in terms of avoiding post-meal hypoglycemia.

In real world testing, oref1 has thus far proven at least as safe as oref0 w/ AMA with regard to hypoglycemia, and better able to prevent post-meal hyperglycemia when SMBs are active. 

### Conclusion

Because of the principles, design constraints, and overall approach taken in designing and implementing OpenAPS, we believe that OpenAPS and similar designs represent the safest, fastest way to make Artificial Pancreas technology available today to people with type 1 diabetes.

To extend this vision to all T1D patients, we would ideally like to:
* Work with medical device manufacturers willing to interoperate with OpenAPS.
* We would like device manufacturers to provide interoperable communication protocols to allow full interoperability between all diabetes devices.
* Work with clinical researchers to design and implement open clinical trials in the open source diabetes community.
* Work with visionary clinicians who would like to advance the state of the art of type 1 diabetes therapy to design clinically useful reporting, alerting and management tools.

