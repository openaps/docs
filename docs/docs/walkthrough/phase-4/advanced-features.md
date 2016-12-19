# Advanced features

Once you have several days or weeks of looping during the day and night, you may then want to consider some of the additional features. See below for a high-level overview; and then see subsequent pages for details about setting these up. These are NOT turned on by default, and require manual configuration and additional work to use them.

## Advanced Meal-Assist (or "AMA")

If you choose to enable the optional advanced meal-assist feature, then after you give yourself a meal bolus, the system can high-temp more quickly after a meal bolus IF you enter carbs reliably. So before considering meal-assist, you must be willing to enter carbs reliably, either through the pump's bolus wizard, or through the Nightscout Care Portal. If you don't want to do that, this feature won't be usable.

Like all features and steps, you'll want to carefully enable, test, and observe the outcomes of this feature. To turn this feature on, run the setup script from phase 2 and choose advanced features. 

With AMA, once you enable forecast display in your Nightscout configuration (see the Nightscout documentation for the correct variables to set) you will have 3 purple line predictions in Nightscout. (Unless you have NO carbs onboard, then you will have only one purple line.)

* Top line == based on current carb absorption and most accurate right after eating carbs

* Middle line == assumes 10 mg/dL/5m carb (0.6 mmol/L/5m) absorption and most accurate the rest of the time

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


## Eating Soon and Activity Mode (Temporary Targets)

Setting temporary targets is a great way to smoothly (safely) make adjustments using your closed loop instead of manually having to make as many adjustments. The two most frequent scenarios for temp targets are when you plan on eating or exercising, and you want to get all of your parameters (e.g., Insulin On Board - IOB) at an ideal value to keep BGs as flat as possible. Temporary or "temp" targets are ideal for when you want the loop to adjust to a different target level for a short period of time (temporarily) and don't want to hassle with changing targets in the pump (which is where OpenAPS normally pulls targets from). 

Let's take "Eating Soon Mode" as an example. You know you'll be eating lunch in an hour, so you set a temporary target of 80 mg/dL (4.4 mmol/L) over the next hour. Because your blood glucose will go lower, it's a good practice to make sure your sensor is reliable and check you blood glucose before setting the temporary target. Otherwise you may cause a hypo. If your OpenAPS rig is connected to the internet, it will pull the target from Nightscout and treat to the temporary target, rather than your usual closed loop target. The outcome of this means you'll have more IOB peaking closer to when you're eating, and that (along with your usual meal bolus) will help reduce the post-meal BG spike. There's some **really important background information** you should understand for this, so be sure and read through the DIYPS blog entries about it ([How to do "eating soon" mode](https://diyps.org/2015/03/26/how-to-do-eating-soon-mode-diyps-lessons-learned/) and [Picture this: How to do "eating soon" mode](https://diyps.org/2016/07/11/picture-this-how-to-do-eating-soon-mode/)).

"Activity Mode" sets temporary targets that are higher than your normal targets, so you will want to set these with knowledge of how different activity affects your BGs. You're doing essentially the same things as with Eating Soon Mode, but instead of setting a *lower* target to increase IOB, you're setting a *higher* target to provide a "cushion" to avoid a low that may occur as a result of the activity you're planning. With a higher target, if connected to the internet so your rig knows about it, it will only do temps with the temporary high target, to provide that 'cushion'. You may want to consider setting activity mode *prior* to activity, in order to reduce the peak net IOB you have on board when activity commences. (Example would be setting activity mode to 140 mg/dL (7.8 mmol/L) one hour before you go for a hard run after dinner, to help reduce the impact of any meal time insulin that would otherwise be peaking at the time. You may still have to do carbs or other strategies to fully prevent lows, but this is one approach to help - as is being aware of net IOB going into any type of activity.)

Once you have a good idea of how you would set those parameters for your system, you'll be ready to set some temprary targets. You can test this out manually by entering a temporary target using [Care Portal](http://www.nightscout.info/wiki/faqs-2/wifi-at-school/nightscout-care-portal) in Nightscout. You'll see your temporary target appear as a grey bar in Nightscout, spanning the length of the time frame you entered. You can also cancel the temporary targets via Care Portal. 

When you're ready to use this regularly, you can also configure IFTTT to trigger a temporary basal from your Pebble/Apple Watch, etc, or via an [Alexa skill](https://github.com/nightscout/cgm-remote-monitor#alexa-amazon-alexa). You'll find a breakdown of how to use IFTTT on the next page.


## Battery monitoring

Because running OpenAPS requires frequent communication with your pump, your pump battery tends to drain more quickly than you'd experience when not looping. Some users have had good experiences with Energizer Ultimate Lithium AAA batteries (getting ~1.5weeks) rather than alkaline batteries (getting ~2-3 days). Regardless of whether you use alkaline or lithium, you may want to consider a Nightscout alarm to alert you to when the battery is running low. You can do this by setting (in your Nightscout config vars) `PUMP_WARN_BATT_V` to 1.39 (if using lithium batteries, as is most common) and adding `battery` to your `PUMP_FIELDS` so that voltage is displayed on your Nightscout site.

The 1.39 voltage warning will give you many hours (reportedly ~8+) heads up that you will need to change your battery. If you don't change the battery in time and end up with a "low battery" warning on the pump, the pump will still function, but RF communications will be turned off and you will not be able to loop until you put a new battery in.
