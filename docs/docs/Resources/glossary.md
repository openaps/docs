# Glossary


## AP and OpenAPS high-level terminology 

<b>APS or AP</b> - artificial pancreas system. A term for a closed-loop automated insulin delivery system in which temporary basal adjustments are used to maintain BG levels at a user-specified target range.  

<b>Basal</b> - baseline insulin level that is pre-programmed into your pump and mimics the insulin your pancreas would give throughout the day and night

<b>Basal IOB</b> - difference (positive or negative) between amount of insulin on board delivered via basal rates (including any temporary basal rates), and the amount specified by your standard profile basal rate.

<b>BG</b> - Blood Glucose

<b>BGI</b> (BG Impact) - The degree to which BG "should" be rising or falling. OpenAPS calculates this value to determine the 'Eventual BG'. This value can be used to make other high/low basal decisions in advanced implementations of OpenAPS.

<b>Bolus</b> - extra insulin given by a pump, usually to correct for a high BG or for carbohydrates

<b>CGM</b> - continuous glucose monitor, a temporary glucose sensor that is injected into your skin (the needle is removed) for 3-7 days and, with twice a day calibrations, provides BG readings approximately every 5 minutes.

<b>closed-loop</b> - closed-loop systems make automatic adjustments to basal delivery, without needing user-approval, based on an algorithm.

<b>COB</b> - Carbs-on-board 

<b>CR</b> - carb ratio, or carbohydrate ratio - the amount of carbohydrates that are covered by one unit of insulin. Example: 1 u of insulin for 10 carbs.

<b>DIA</b> - duration of insulin action, or how long the insulin is active in your body (Ranges 3-6 hours typically).

<b>IOB</b> - Insulin On Board, or insulin active in your body. Note that most commercially available pumps calculate IOB based on bolus activity only.  Usually, but not always, Net IOB is what Nightscout displays as 'IOB'.  While what's displayed in your NS IOB pill may match what IOB is in your current loop, it's probably a good practice to not rely on this pill alone for determining IOB.

<b>ISF</b> - insulin sensitivity factor - the expected decrease in BG as a result of one unit of insulin. 
Example: 1 u of insulin for 40 mg/dL (2.2 mmol/L)

<b>Net IOB</b> - amount of insulin on board, taking into account any adjusted (higher or lower) basal rates (see Basal IOB above) plus bolus activity. 

<b>NS, or Nightscout</b> - a cloud-based visualization and remote-monitoring tool. 

<b>OpenAPS</b> - refers to an example build of the system when used without a hashtag (\#)

<b>openaps</b> - the core suite of software tools under development by this community for use in an OpenAPS implementation

<b>\#OpenAPS</b> - stands for Open A(rtificial) P(ancreas) S(ystem). It is an open-source movement to develop an artificial pancreas using commercial medical devices, a few pieces of inexpensive hardware, and freely-available software. A full description of the #OpenAPS project can be found at openaps.org. \#OpenAPS (with the hashtag) generally refers to the broad project and open source movement.

<b>open-loop</b> - open-loop systems will suggest recommended adjustments to basal delivery, but will require specific user-approval prior to implementing.

<b>oref0</b> - "reference design implementation version 0" of the OpenAPS reference design. Aka, the key algorithm behind OpenAPS.

<b>Treatments IOB</b> - amount of insulin on board delivered via boluses. Reported by some pumps as 'active insulin'.

## OpenAPS-specific terminology 

<b>OpenAPS Nightscout Status Messages</b> appear when the OpenAPS plugin is enabled.
  * <b>Looping ↻</b> - Success; Temp basal rate has been suggested.
  * <b>Enacted ⌁</b> - Success; Temp basal rate has been set.
  * <b>Not Enacted x</b> - Success; No action taken on suggested temp basal rate.
  * <b>Waiting ◉</b> - Timeout; No recent status received from OpenAPS.
  * <b>Unknown &#x26a0;</b> - Error or Timeout; OpenAPS has reported a failure, or has reported no status for many hours.

<b>Avg. Delta</b> - average BG delta between 5 min intervals.

<b>Delta</b> - difference between the last two BG values. An asterick (*) is displayed in Nightscout when estimating due to missing BG values.

<b>Eventual BG</b> - BG after DIA hours (or maybe a bit sooner if most of your insulin was awhile ago), considering the current IOB and COB.

<b>Exp. Delta</b> - expected BG delta right now, considering all OpenAPS inputs (IOB, COB, etc).

<b>predBGs</b> - predicted blood sugars over next N many minutes based on openAPS logic, in 5 minute increments

<b>snoozeBG</b> - predicted value of blood glucose adjusted for bolussnooze IOB. SnoozeBG will never exceed EventualBG.


