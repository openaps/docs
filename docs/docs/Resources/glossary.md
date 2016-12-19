# Glossary

<b>APS</b> - artificial pancreas system. Sometimes also referred to as "AP"

<b>CGM</b> - continuous glucose monitor, a temporary glucose sensor that is injected into your skin (the needle is removed) for 3-7 days and, with twice a day calibrations, provides BG readings approximately every 5 minutes.

<b>\#OpenAPS</b> - stands for Open A(rtificial) P(ancreas) S(ystem). It is an open-source movement to develop an artificial pancreas using commercial medical devices, a few pieces of inexpensive hardware, and freely-available software. A full description of the #OpenAPS project can be found at openaps.org. \#OpenAPS (with the hashtag) generally refers to the broad project and open source movement.

<b>OpenAPS</b> - refers to an example build of the system when used without a hashtag (\#)

<b>openaps</b> - the core suite of software tools under development by this community for use in an OpenAPS implementation

<b>BG</b> - Blood Glucose

<b>BGI</b> (BG Impact) - The degree to which BG "should" be rising or falling. OpenAPS calculates this value to determine the 'Eventual BG'. This value can be used to make other high/low basal decisions in advanced implementations of OpenAPS.

<b>Bolus</b> - extra insulin given by a pump, usually to correct for a high BG or for carbohydrates

<b>Basal</b> - baseline insulin level that is pre-programmed into your pump and mimics the insulin your pancreas would give throughout the day and night

<b>IOB</b> - Insulin On Board, or insulin active in your body. Note that most commercially available pumps calculate IOB based on bolus activity only.  Usually, but not always, Net IOB is what Nightscout displays as 'IOB'.

<b>Net IOB</b> - amount of insulin on board, taking into account any adjusted (higher or lower) basal rates as well as bolus activity. 

<b>Basal IOB</b> - difference (positive or negative) between amount of insulin on board delivered via basal rates, and the amount specified by the profile basal rate.

<b>Treatments IOB</b> - amount of insulin on board delivered via boluses. Reported by some pumps as 'active insulin'.

<b>DIA</b> - duration of insulin action, or how long the insulin is active in your body. (Ranges 3-6 hours typically)

<b>CR</b> - carb ratio, or carbohydrate ratio - the amount of carbohydrates for one unit of insulin. Example: 1 u of insulin for 10 carbs

<b>ISF</b> - insulin sensitivity factor - the amount of insulin that drops your BG by a certain amount. Example: 1 u of insulin for 40 mg/dL (2.2 mmol/L)

<b>NS, or Nightscout</b> - a cloud-based visualization and remote-monitoring tool. 

<b>OpenAPS Nightscout Status Messages</b> appear when the OpenAPS plugin is enabled.
  * <b>Looping ↻</b> - Success; Temp basal rate has been suggested.
  * <b>Enacted ⌁</b> - Success; Temp basal rate has been set.
  * <b>Not Enacted x</b> - Success; No action taken on suggested temp basal rate.
  * <b>Waiting ◉</b> - Timeout; No recent status received from OpenAPS.
  * <b>Unknown &#x26a0;</b> - Error or Timeout; OpenAPS has reported a failure, or has reported no status for many hours.

<b>Eventual BG</b> - BG after DIA hours (or maybe a bit sooner if most of your insulin was awhile ago), considering the current IOB and COB.

<b>Delta</b> - difference between the last two BG values. An asterick (*) is displayed in Nightscout when estimating due to missing BG values.

<b>Avg. Delta</b> - average BG delta between 5 min intervals.

<b>Exp. Delta</b> - expected BG delta right now, considering all OpenAPS inputs (IOB, COB, etc).

<b>RileyLink (RL)</b> - A custom designed Bluetooth Smart (BLE) to sub-1GHz module - it can be used to bridge any BLE capable smartphone to the world of sub-1GHz devices. This device is focused on talking to Medtronic insulin pumps and sensors.
