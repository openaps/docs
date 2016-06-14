# Advanced features

Once you have several days or weeks of looping during the day and night, you may then want to consider some of the in-development additional features. See below for a high-level overview; and then see subsequent pages for details about setting these up. These are NOT turned on by default, and require manual configuration and additional work to use them.

## Meal-assist

If you choose to enable the optional meal-assist feature, then after you give yourself a meal bolus, the system can high-temp more quickly after a meal bolus IF you enter carbs reliably. So before considering meal-assist, you must be willing to enter carbs reliably, either through the pump's bolus wizard, or through the Nightscout Care Portal. If you don't want to do that, this feature won't be usable.

Like all features and steps, you'll want to carefully enable, test, and observe the outcomes of this feature.

`oref0 meal`
`usage:  [ 'node', '/usr/local/bin/oref0-meal' ] <pumphistory.json> <profile.json> <clock.json> [carbhistory.json]`
Requires inputs of pumphistory.json, profile.json and clock.json reports. Optionally the [carbhistory.json] is required from another source such as Nightscout if carbs are not entered into the pump directly. 
The output of this command `meal.json` gives three values - carbs, boluses, and mealCOB eg:
`{"carbs":40,"boluses":2.1,"mealCOB":30}`
carbs - carbs in grams
boluses - units of insulin bolused
mealCOB - decayed carbs with assumption of 30g of carbs absorbed per hour, which will be equal to or less than carbs. Used for informational purposes only.


## Auto-sensitivity mode

Wouldn't it be great if the system knew when you were running sensitive or resistant? That's what we thought, so we created "auto-sensitivity mode". If you explicitly configure this additional feature, it will allow the system to analyze historical data on the go and make adjustments if it recognizes that you are reacting more sensitivite (or conversely, more resistant) to insulin than usual. It will then make micro adjustments to your basals. 

## Battery monitoring

Because running OpenAPS requires frequent communication with your pump, your pump battery tends to drain more quickly than you'd experience when not looping. Some users have had good experiences with Energizer Ultimate Lithium AAA batteries (getting ~1.5weeks) rather than alkaline batteries (getting ~2-3 days). Regardless of whether you use alkaline or lithium, you may want to consider a Nightscout alarm to alert you to when the battery is running low. You can do this by setting (in your Nightscout config vars) `PUMP_WARN_BATT_V` to 1.39 (if using lithium batteries, as is most common) and adding `battery` to your `PUMP_FIELDS` so that voltage is displayed on your Nightscout site. 

The 1.39 voltage warning will give you many hours (reportedly ~8+) heads up that you will need to change your battery. If you don't change the battery in time and end up with a "low battery" warning on the pump, the pump will still function, but RF communications will be turned off and you will not be able to loop until you put a new battery in. 
