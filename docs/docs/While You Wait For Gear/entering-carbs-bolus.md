# Entering carbs & doing boluses

How do you enter carbs & do boluses with OpenAPS? You have a variety of ways to do things.

## Doing boluses

* **Easy bolus button**: Previously before OpenAPS, you probably used the [easy bolus button](http://openaps.readthedocs.io/en/latest/docs/While%20You%20Wait%20For%20Gear/collect-data-and-prepare.html#easy-bolus-button) to add up a bolus in increments. (E.g. if your pump had increments of 0.5u, you could quickly dial up to a bolus by pressing the up button as many times as needed; hitting enter to confirm it; hitting enter again to deliver the bolus.)

* **Bolus wizard**: Or, you may have used the bolus wizard, sometimes with BG or carb entry, or just as a bolus.

**In OpenAPS, you can still use those same methods for delivering manual doses of insulin (boluses).**

## Entering carbs into OpenAPS

Before OpenAPS, you may or may not have entered carbs into your pump. With OpenAPS, most people *do* want the rig to know about carbs. You have a variety of ways to enter them, depending on whether your rig is **online** or **offline**.

Look at this image for the big picture:

![Different methods for entering carbs](../Images/Carb_data_to_rig.jpg)

### Offline carb entry

* You can still use the bolus wizard to enter carbs, although it must be entered with the smallest unit of bolus (.1 or .05, depending on your pump). Otherwise, OpenAPS will ignore those carbs.
* Some pumps can use the ['meal marker' feature](http://openaps.readthedocs.io/en/latest/docs/Customize-Iterate/offline-looping-and-monitoring.html#entering-carbs-while-offline).

### Online carb entry

If your rig is online, you have a variety of ways to enter carbs online.

* Nightscout care portal
* Many options for using IFTTT to get carbs into Nightscout Care portal. ([See the IFTTT page here for instructions](http://openaps.readthedocs.io/en/latest/docs/Customize-Iterate/ifttt-integration.html).)
  * Pebble or Apple watch
  * Google Calendar
  * Siri, Alexa, Google, etc. 
