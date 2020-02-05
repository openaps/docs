# Entering carbs & doing boluses

How do you enter carbs & do boluses with OpenAPS? You have a variety of ways to do things.

## Doing boluses

Boluses always have to be set on the pump for OpenAPS to take them into consideration. For safety reasons, insulin added to Nightscout NOT via the pump - for instance, logging an event when using an insulin pen - will not be taken into account. (If you are briefly away from your pump and using injections, the simplest solution to keep OpenAPS up to date is to bolus into air!)

* **Easy bolus button**: Previously before OpenAPS, you probably used the [easy bolus button](<../While You Wait For Gear/collect-data-and-prepare#easy-bolus-button>) to add up a bolus in increments. (E.g. if your pump had increments of 0.5u, you could quickly dial up to a bolus by pressing the up button as many times as needed; hitting enter to confirm it; hitting enter again to deliver the bolus.)

* **Bolus wizard**: Or, you may have used the bolus wizard, sometimes with BG or carb entry, or just as a bolus.

**In OpenAPS, you can still use those same methods for delivering manual doses of insulin (boluses).**

## Entering carbs into OpenAPS

Before OpenAPS, you may or may not have entered carbs into your pump. With OpenAPS, most people *do* want the rig to know about carbs. 

Carbs can be either entered on the pump (for example, using Bolus Wizard) or into Nightscout (carb entries in Nightscout can either be made directly using the Care Portal) or via IFTTT or XDrip.
You have a variety of ways to enter them, depending on whether your rig is **online** or **offline**.

Look at this image for the big picture:

![Different methods for entering carbs](../Images/Carb_data_to_rig.jpg)

### Offline carb entry

* You can still use the bolus wizard to enter carbs, although a non-zero amount of bolus must be delivered in order for OpenAPS to record the carbs. If you adjust the bolus recommended by the bolus wizard down to zero and deliver the zero units (as you might ordinarily do if you ate carbs in order to treat a low), the pump may (depending on your pump version) fail to record a bolus wizard record in pumphistory, causing OpenAPS to ignore the carbs as if you hadn't entered them. In that situation, consider delivering the smallest unit of bolus possible (like 0.05u or 0.1u) so that OpenAPS will record the carbs entered into the bolus wizard.
* Some pumps can use the ['meal marker' feature](<../Customize-Iterate/offline-looping-and-monitoring#entering-carbs-while-offline>).
* See section on [extended and dual wave substitutes](<../While You Wait For Gear/collect-data-and-prepare#extended-and-dual-wave-substitute>) for information on how extended boluses are handled in OpenAPS.

**SAFETY WARNING ABOUT BOLUS WIZARD:** If the pump has a target range high end set lower than the BG input into the Bolus Wizard, the Bolus Wizard will add insulin to cover the carbs as well as bring BG down to the high end. E.g. if your high end is 110 and you enter a 160 BG and 45g of carbs in the Bolus Wizard, the Bolus Wizard will dose 1U to bring BG to 110 and 3U for carbs (assuming 50 (mg/dL)/U and 15g/U factors). The rig will likely have already dosed insulin to bring your BG to your low target, and you are potentially "double dosing". In these scenarios, you will have too much insulin onboard and can experience a severe low. If you use the Bolus Wizard, ensure the high end of the BG target range is a high number such as 250 mg/dL. OpenAPS default behavior (`wide_bg_target_range` preference) is to only use the target range lower end. Setting the high end does not impact the OpenAPS algorithms.

### Online carb entry

If your rig is online, you have a variety of ways to enter carbs online.

* Nightscout Care Portal
* AndroidAPS NS Client ([Download the app-nsclient-release APK from here](https://github.com/MilosKozak/AndroidAPS/releases).)
* Many options for using IFTTT to get carbs into Nightscout Care portal. ([See the IFTTT page here for instructions](<../Customize-Iterate/ifttt-integration>).)
  * Pebble or Apple watch
  * Google Calendar
  * Siri, Alexa, Google, etc. 
* Via an HTTPS POST to the treatments API, for example using the iOS Shortcuts app
* Android users: you can use the Care portal option in [NSClient app found here](https://github.com/nightscout/NSClient-Android/releases).
* via [xDrip](https://github.com/NightscoutFoundation/xDrip),
* via [CarbDialer (iOS App)](https://apps.apple.com/us/app/carbdialer/id1315809661).
  
