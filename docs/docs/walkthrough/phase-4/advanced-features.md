# Advanced features

Once you have several days or weeks of looping during the day and night, you may then want to consider some of the in-development additional features. See below for a high-level overview; and then see subsequent pages for details about setting these up. These are NOT turned on by default, and require manual configuration and additional work to use them.

## Advanced Meal-Assist (or "AMA")

If you choose to enable the optional advanced meal-assist feature, then after you give yourself a meal bolus, the system can high-temp more quickly after a meal bolus IF you enter carbs reliably. So before considering meal-assist, you must be willing to enter carbs reliably, either through the pump's bolus wizard, or through the Nightscout Care Portal. If you don't want to do that, this feature won't be usable.  By default, AMA is turned off and you need to add some items to your reports to get it working. With AMA enabled, bolus snooze has been shorted to DIA/3 or DIA/4 as opposed to a normal Bolus Snooze of DIA/2.

Like all features and steps, you'll want to carefully enable, test, and observe the outcomes of this feature. To turn this feature on, run the setup script from phase 2 and choose advanced features. 

With AMA, you will have 3 purple line predictions in Nightscout. (Unless you have NO carbs onboard, then you will have only one purple line.)

* Top line == based on current carb absorption and most accurate right after eating carbs

* Middle line == assumes 10 mg/dL/5m carb absorption and most accurate the rest of the time

* Bottom line == based on insulin only


## Auto-sensitivity mode

Wouldn't it be great if the system knew when you were running sensitive or resistant? That's what we thought, so we created "auto-sensitivity mode". If you explicitly configure this additional feature (again by enabling it through advanced features in setup script), it will allow the system to analyze historical data on the go and make adjustments if it recognizes that you are reacting more sensitively (or conversely, more resistant) to insulin than usual. It will then make micro adjustments to your basals.

When you watch your loop run and Autosens is going to be detected, you might see something like this:

`-+>>>>>>>>>>>>+++->->+++>++>>+>>>>>>>>++-+>>>>>>>-+++-+--+>>>>>>>>>>>>>>>>>>>>>>>>>++-++++++--++>>>++>>++-++->++-+++++++>+>>>>>>>>>>>>>>>>>++-+-+-+--++-+--+++>>>>>>++---++----+---++-+++++>>>++------>>>++---->>+++++--+++-++++++++--+--+------++++++++++>>>>++--+->>>>>>>>>>++++-+-+---++++ 34% of non-meal deviations negative (target 45%-50%)
Excess insulin resistance detected: ISF adjusted from 100 to 73.52941176470588`

Here's what each symbol above means:

 ">" : deviation from BGI was high enough that we assume carbs were being absorbed, and disregard it for autosens purposes

 "+" : deviation was above what was expected

 "-" : deviation was below what was expected

 "=" : BGI is doing what we expect

## Battery monitoring

Because running OpenAPS requires frequent communication with your pump, your pump battery tends to drain more quickly than you'd experience when not looping. Some users have had good experiences with Energizer Ultimate Lithium AAA batteries (getting ~1.5weeks) rather than alkaline batteries (getting ~2-3 days). Regardless of whether you use alkaline or lithium, you may want to consider a Nightscout alarm to alert you to when the battery is running low. You can do this by setting (in your Nightscout config vars) `PUMP_WARN_BATT_V` to 1.39 (if using lithium batteries, as is most common) and adding `battery` to your `PUMP_FIELDS` so that voltage is displayed on your Nightscout site.

The 1.39 voltage warning will give you many hours (reportedly ~8+) heads up that you will need to change your battery. If you don't change the battery in time and end up with a "low battery" warning on the pump, the pump will still function, but RF communications will be turned off and you will not be able to loop until you put a new battery in.
