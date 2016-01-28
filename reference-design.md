(Last updated Jan 27, 2016)

# OpenAPS Reference Design

The Open Artificial Pancreas System (OpenAPS) is a simplified Artificial Pancreas System (APS) designed to automatically adjust an insulin pump’s basal insulin delivery to keep blood glucose (BG) in a safe range overnight and between meals. It does this by communicating with an insulin pump to obtain details of all recent insulin dosing (basal and boluses), by communicating with a Continuous Glucose Monitor (CGM) to obtain current and recent BG estimates, and by issuing commands to the insulin pump to adjust temporary basal rates as needed.

OpenAPS differs from other APS systems currently in clinical trials in two significant ways.

    First, it is designed to use existing approved medical devices, commodity hardware, and open source software.

    Secondly, it is designed primarily for safety, simplicity, and interoperability with existing treatment approaches as well as existing devices.

By taking this approach, we believe that OpenAPS can be demonstrated to be both safer and more effective than current state-of-the-art standalone insulin pump therapy, and that this can be demonstrated far more easily than for the completely novel therapy approach employed by the full APS systems that have been in clinical trials for years and are still years away from FDA approval.

OpenAPS is designed to work with interoperable insulin pumps and CGMs from any manufacturer. Initial prototype implementations use Medtronic insulin pumps with either Dexcom or Medtronic CGMs, but the same design will also work with insulin pumps from any manufacturer who provides a way to issue temporary basal commands to the pump, and with any CGMs whose data can be retrieved in real time. If an OpenAPS reference design and implementation can one day be FDA approved, they will also be made available to any medical device manufacturer who wishes to create their own implementation with their own devices and/or the devices of any of their partners.

## Design Constraints for OpenAPS

1. In order to accomplish these goals, the first design constraint of OpenAPS is that OpenAPS cannot issue insulin boluses. This is a key safety feature, because insulin pumps, while they have limits on the maximum size of bolus they will administer, have effectively no limit on how frequently boluses may be administered. (Some pumps implement the maximum bolus size as the maximum amount of insulin that can be bolused over a certain period of time, but as the maximum bolus amount is generally set very high by default, this is insufficient to prevent severe hypoglycemia if the full bolus amount is administered inappropriately.) As a result, any system that is capable of issuing bolus commands would be capable of administering, if it erroneously issued bolus commands repeatedly, a potentially lethal quantity of insulin. To completely avoid this issue, OpenAPS instead relies solely on temporary basal commands. Repeatedly reissuing the same temporary basal command does not change the rate at which the pump infuses insulin; it simply extends the temporary basal rate slightly. In addition, insulin pumps are configured with a maximum allowed temporary basal rate, and will simply ignore any commands that instruct the pump to use a higher rate than allowed.
2. This maximum allowed temporary basal rate is the second design constraint: OpenAPS is designed to be incapable of administering insulin any faster than can be easily counteracted with fast-acting carbohydrates. This means that OpenAPS cannot be used to substitute for mealtime insulin boluses, but more importantly it means that, even if OpenAPS were to malfunction in the worst possible way, the patient can completely prevent any adverse outcome by simply consuming additional carbs as needed, as they already have to do with standard diabetes treatment every day or two for any number of other reasons.
3. The third design constraint is also related to the use of maximum temporary basal rates: because any adjustments to insulin dosing are performed by issuing 30-minute temporary basal rate adjustments, OpenAPS does not place undue, excess reliance on any single glucose measurement. Because new CGM measurements are received every 5 minutes, OpenAPS can continually recalculate the temporary basal rate required to bring BG back to the target range. If the CGM provides erroneous data, such as from a dying sensor or a compression event (where the patient is lying directly on the sensor and restricting blood flow), OpenAPS will respond by initiating a temporary basal rate. If 5, 10, or 15 minutes later the new data from the CGM indicates that the temporary basal rate it set is no longer appropriate, OpenAPS can simply cancel the temporary basal and return to the normally scheduled basal rate, or set a different temporary basal if necessary.
4. The fourth design constraint is that OpenAPS must be completely fault-tolerant. Because of the inherent unreliability of RF communication between the insulin pump, OpenAPS, and the CGM sensor, OpenAPS must assume that at any moment it will lose communication. To deal with this, OpenAPS algorithms are designed to set temporary basal rates such that running the temporary basal to completion and then resuming normally scheduled basal is the safest thing to do given what it knows at the time.   If new information indicates that finishing the current temporary basal would result in an overcorrection in either direction, OpenAPS will immediately cancel the temporary basal or replace it with a more appropriate one.
5. OpenAPS is designed to rely, as much as possible, on the same parameters and dosing algorithms used by the patient (at the instruction of their diabetes care team) in deciding the appropriate rate of insulin in any situation. This means using the basal rates, insulin sensitivity factor (ISF, also known as correction factor), duration of insulin action (DIA, also known as insulin lifetime), and optionally the insulin to carb (IC) ratio the patient is already using to drive their existing pump therapy. It also means using the exact same simple calculations the pump’s bolus calculator (or the patient) already use in calculating correction boluses. OpenAPS does not have any complicated machine learning algorithms, 17-parameter insulin response models, or differential equations. As such, OpenAPS system is open and transparent in how it works, and understandable not just by experts, but also by clinicians and end users (patients).
6. OpenAPS is designed to simply and safely fall back to the patient’s pre-programmed basal therapy whenever it receives conflicting information about what the appropriate course of action is (or when required information is missing). For example, if BG is predicted to eventually go low but is actually rising at the moment, OpenAPS will cancel any temporary basals and wait to see whether BG continues rising or begins to fall, and only then begin issuing the appropriate temporary basal commands. Additionally, OpenAPS further ensures safety by falling back to “low glucose suspend” behavior when current BG is below a configured threshold and not currently rising. This ensures that insulin infusion is completely suspended while BG remains low for any reason, until it starts to recover, which maximizes the patient’s ability to recover from hypoglycemia.
7. OpenAPS generally defers to the patient when they choose to issue their own boluses, either for corrections or for meals. In such a situation, OpenAPS makes an estimate of how long the (bolus-wizard inputted or assumed) meal is expected to take to digest (or how long the BG excursion is expected to continue, if it’s something other than a meal). It then continues to monitor BG, but avoids issuing any temporary basal rates until that is clearly required again.
8. OpenAPS is designed to operate completely autonomously, without requiring any interaction from the patient, and to upload CGM and pump data in real time whenever Internet connectivity is available. The patient simply continues to use the pump per their usual therapy, and OpenAPS simply works in the background to temporarily override the underlying basal rates so that the patient rarely has to take corrective action for hyper- or hypoglycemia. The uploaded data can be made available to the patient and their caregivers / loved ones, allowing them to keep an eye on their BGs, and make sure OpenAPS is continuing to work properly, at all times. As demonstrated by the >15,000 members of the CGM in the Cloud Facebook group and the >3,000 active users of Nightscout, this kind of remote visibility for BGs is life-changing for people with type 1 diabetes, and will be even more so when coupled with OpenAPS technology. This data upload also allows for the development of real-time and retrospective reporting tools to help the clinical care team optimize the patient’s long-term diabetes care, which has the promise to revolutionize the clinical treatment of type 1 diabetes.

## OpenAPS Design Details
### Hardware

OpenAPS consists of:

    a centralized controller operating on commodity hardware (such as an Android phone or Raspberry Pi mini-computer) that has USB and wireless communication abilities,
    a USB or Bluetooth connection capable of reading from a Continuous Glucose Monitor (CGM),
    a wireless connection capable of reading from and issuing temporary basal commands to an insulin pump, and
    (Optional) a wireless Internet connection (i.e. cellular data or Wi-Fi) capable of uploading BG, pump, and operational data.

### Medical device communication

OpenAPS periodically (i.e. every 5 minutes) reads new data from the CGM as it becomes available. In order to take action, OpenAPS needs at least a current CGM reading (received within the last 10-15 minutes), and a previous CGM reading (5-10 minutes before that).

OpenAPS periodically (every few minutes) queries the insulin pump for current settings and recent activity, such as current (scheduled or temporary) and maximum basal rates, recent boluses, IOB (if available), ISF, DIA, IC ratio, BG target/range, etc. (If appropriate, settings such as max basal rate, ISF, DIA, IC ratio, BG targets, etc. can be queried less frequently.) If that query is successful, OpenAPS updates its bolus wizard calculations (detailed below) and determines whether any action is required (canceling or issuing a temporary basal).

If action is required, OpenAPS issues the appropriate temporary basal command to the pump, confirms that it was received and acknowledged by the pump, and then performs another query for recent activity to make sure the new temporary basal successfully took effect.

### Algorithms
#### Basic overnight operation

OpenAPS uses the pump’s bolus and temporary basal history, combined with the pump’s DIA and published IOB curves, to calculate current net IOB. (Currently, pumps only include boluses when calculating IOB: a more correct and useful IOB calculation includes the net impact of temporary basals vs. normally scheduled basal rates.) If no boluses have been administered recently (see “Bolus Snooze” below), OpenAPS can then use the current CGM glucose reading to calculate an eventual BG estimate using simple bolus calculator math: current BG – (ISF * IOB) = eventual BG.

If current BG is below a configured threshold (defaulting to 30mg/dL below the target range), OpenAPS enters low glucose suspend mode, and simply continues to issue 30-minute temp basals to zero as long as BG is not rising. Otherwise, OpenAPS determines whether the eventual BG is projected to be above or below the target range, and makes note of whether the CGM glucose readings are currently rising or falling more than expected. It then decides on the appropriate course of action as follows:

    if BG is rising but eventual BG is below target, cancel any temp basals.
    else, if BG is falling but eventual BG is above target, cancel any temp basals.
    else, if eventual BG is above target:
        calculate 30m temp required to get eventual BG down to target
        if required temp is > existing basal, issue the new high temp basal
        else, if BG is below target:
            calculate 30m temp required to get projected BG up to target
            if required temp is < existing basal, issue the new low temp basal
                if >30m @ 0 required, extend zero temp to 30m

The maximum temp basal rate is set on the pump, but for safety purposes OpenAPS will set a lower maximum temp basal rate if necessary, as the minimum of:

    The pump’s maximum temp basal rate
    3x the maximum daily scheduled basal rate
    4x the current scheduled basal rate

This helps ensure that the patient will always be able to recover from any excessive insulin delivered by OpenAPS simply by eating fast-acting carbs.

#### Adjusting for unexpected BG deviation

The algorithm above is sufficient for a simple and safe OpenAPS implementation, and has been successfully tested by several users over several months of combined use. However, in situations where BG is rising or falling unexpectedly, or remaining stubbornly high, we discovered that it is also useful to take into account how much the Blood Glucose rise/fall rate is deviating from what would be expected based on insulin activity. This allows more advanced OpenAPS implementations to respond more quickly when BG starts to rise or fall more than expected, and allows it to continue high temp basals when BG is stubbornly high and mostly flat (falling far less than expected).

To calculate this deviation, OpenAPS first calculates a term we call “BG Impact” or BGI. BGI is simply the expected effect of the net IOB, calculated by multiplying the current insulin activity times the ISF (see example below). the current insulin activity (first derivative of IOB) * insulin sensitivity. When expressed in units of mg/dL/5m, this represents the degree to which BG “should” be rising or falling, and can be directly compared to the delta between the current and last CGM reading, or an average delta over the last 15m or so. To calculate the deviation, OpenAPS does exactly this comparison, between the 15m average delta in CGM readings and the predicted BGI. 

**The following example uses straight linear math for the purposes of simplicity in explanation.  In reality, the AP algorithm assumes that insulin effectiveness starts off flat, over time builds in efficacy, and eventually tapers off in its usefulness. ** 
Example: take the scenario of correcting a BG of 200 (where ISF is 1u per 100 mg/dL, DIA is 4 hours, and target BG is 100).
1. 1u insulin is given to bring BG to 100
2. There are 48 5-minute segments in 4 hours
3. 1u/48 = .021 (This is the current insulin activity, or how much net IOB is 'used' in a 5-minute period)
4. Thus we expect the BG to drop -2.1 mg/dL every 5 minutes (.021 * 100 mg/dL), so the BGI is -2.1 mg/dL/5m
5. Multiplying this by the ISF (.021 * 100 mg/dL), gives us the BGI of -2.1 mg/dL/5m (the expected BG decrease over 5 minutes)

OpenAPS then applies that deviation as an adjustment to the eventual BG prediction. This is based on the simple assumption that if BG is rising or falling more than expected over the last 15 minutes, that trend is likely to continue over the next 15-30 minutes, and the magnitude of the projected deviation is approximately equal to what was seen over the last 15 minutes. In future OpenAPS implementations it may be possible to come up with better predictive algorithms of this sort, but this simple algorithm has worked quite well over many months of real-life use so far.

In addition to adjusting the eventual BG predictions, the BGI calculation above is also used in advanced OpenAPS implementations to allow a high temp basal to continue running if BG is dropping slower than expected (less than ½ of BGI), and similarly to set low temp basals if BG is rising slower than expected or falling more quickly than expected.

#### Bolus snooze

By adjusting for BG deviations as described above, advanced OpenAPS implementations can avoid issuing low temp basals when BG is rising or remaining high after a meal, even without being informed about the fact that a meal has been consumed, or being provided a carbohydrate count. However, it is also useful for OpenAPS to avoid issuing low temp basals that counteract a meal bolus or prebolus when BG has not yet started to rise. To accomplish this, advanced OpenAPS implementations apply a “bolus snooze”, which causes OpenAPS to effectively go “hands off” as soon as a user executes a bolus, and only take action again if/when BG drops below the low glucose suspend threshold, rises more than expected or fails to come down after the mealtime rise, or starts to drop faster than expected. As a result, users can simply bolus appropriately for their meal, and then OpenAPS will wait and take over basal adjustment as necessary to bring BGs back into range after any mealtime excursions.

The bolus snooze is currently implemented in advanced OpenAPS implementations by tracking bolus IOB (with an accelerated decay based on half the user’s normal DIA) separately from net IOB, and re-adding the BG impact of the bolus IOB (plus a small multiple) when deciding whether to set a low temporary basal. If the resulting “snooze BG” term is higher than the BG target, then OpenAPS will not set a low temporary basal, even if the eventual BG (based solely on net IOB) is much lower than target. This results in OpenAPS effectively widening the target BG range immediately after a bolus, and then gradually narrowing it over the next hour or two and gradually returning to normal behavior.

As most insulin pumps do not calculate net IOB, and use bolus-only IOB in the bolus calculator, it is necessary to take an additional precaution to help prevent the patient from manually administering an excessive bolus by following the bolus calculator. This is accomplished through a “maximum IOB” setting, which instructs OpenAPS to never set high temp basals that would allow the net IOB to exceed the bolus IOB by more than a user-configured amount. Unless configured otherwise by the user setting up OpenAPS implementation, this maximum IOB defaults to zero, which means that OpenAPS will act only as a predictive low glucose suspend system, and will high-temp after BG starts to recover if IOB is negative, but will not issue high temp basals if BG is high.

### Discussion

As a result of the principles, design constraints, and overall approach taken in designing and implementing OpenAPS, we believe that OpenAPS and similar designs represent the safest, fastest way to make Artificial Pancreas technology available to all type 1 diabetes patients, and do so at the most affordable price point possible.

In order to extend this vision from multiple DIY implementations to all T1D patients, we would ideally like to:

* Work with medical device manufacturers willing to interoperate with OpenAPS, initially on an IDE basis where necessary, and later by providing interoperable communication protocols to allow full interoperability between all of a patient’s devices.
* Work with clinical researchers to design and implement open clinical trials of the OpenAPS reference implementation.
* Work with regulatory agencies to determine and begin the process of obtaining approval for an Open APS reference design and implementation, which could then be implemented by any manufacturer or other appropriate entity that wants to do so.
* Work with visionary clinicians who would like to advance the state of the art of type 1 diabetes therapy, by setting up their patients with their own OpenAPS implementations, and working with us to design clinically useful reporting and alerting tools.  These would allow clinicians to be made aware of which patients need clinical follow-up, and allow them to engage with patients on the basis of full knowledge of their diabetes situation, and with actionable recommendations that will make a difference in the patient’s treatment.
