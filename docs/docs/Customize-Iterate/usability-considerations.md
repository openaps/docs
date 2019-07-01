# Usability Considerations

Now that you've closed the loop, you probably have a lot of new "first" experiences to deal with. Like much of this looping experience, you'll figure it out as you go along, and figure out what's right for you. But here are some ideas or tips to consider:

<details>
        <summary><b>Click here to expand a clickable list to see all tips on this page:</b></summary>

- [How do I enter carbs and boluses so OpenAPS can use them?](#how-do-i-enter-carbs-and-boluses-so-openaps-can-use-them-)
- [What do you do with the loop in airport security when you travel](#what-do-you-do-with-the-loop-in-airport-security-when-you-travel)
- [What do you do with your loop when you travel across timezones? How do you update devices for a time zone change?](#what-do-you-do-with-your-loop-when-you-travel-across-timezones--how-do-you-update-devices-for-a-time-zone-change-)
- [What do you do with the loop when you shower?](#what-do-you-do-with-the-loop-when-you-shower-)
- [What do you do when you change sites?](#what-do-you-do-when-you-change-sites-)
- [What do you do when you exercise?](#what-do-you-do-when-you-exercise-)
- [What do you do if you want to be off the pump for long periods during a day when you're really active?  Like for the beach or water park or sporting activity or similar?](#what-do-you-do-if-you-want-to-be-off-the-pump-for-long-periods-during-a-day-when-you-re-really-active---like-for-the-beach-or-water-park-or-sporting-activity-or-similar-)
- [What if I want to turn off the loop for a while?](#what-if-i-want-to-turn-off-the-loop-for-a-while-)
- [How do I open loop?](#how-do-i-open-loop-)
- [How can you make adjustments to insulin delivery while on the go? - Optimizing with Temporary Targets:](#how-can-you-make-adjustments-to-insulin-delivery-while-on-the-go----optimizing-with-temporary-targets-)
- [How do I improve the range of my Edison/Explorer Board?](#how-do-i-improve-the-range-of-my-edison-explorer-board-)
- [How do I switch between insulin types, or switch to Fiasp? What should I change?](#how-do-i-switch-between-insulin-types--or-switch-to-fiasp--what-should-i-change-)
- [Improving the battery life of your Raspberry Pi](#improving-the-battery-life-of-your-raspberry-pi)

</details>

## How do I enter carbs and boluses so OpenAPS can use them?
Boluses always have to be set on the pump for OpenAPS to take them into consideration. Carbs can be either entered in any of several ways: </br>
- on the pump (for example, using Bolus Wizard),
- into the Nightscout UI (using the Care Portal),
- via an HTTPS POST to the treatments API, for example using the iOS Shortcuts app,
- via [IFTTT](./ifttt-integration.html?highlight=IFTTT), 
- via [xDrip](https://github.com/NightscoutFoundation/xDrip),
- via [CarbDialer (iOS App)](https://apps.apple.com/us/app/carbdialer/id1315809661).

**SAFETY WARNING:** If the pump has a target range high end set lower than the BG input into the Bolus Wizard, the Bolus Wizard will add insulin to cover the carbs as well as bring BG down to the high end. I.e. if your high end is 110 and you enter a 160 BG and 45g of carbs in the Bolus Wizard, the Bolus Wizard will dose 1U to bring BG to 110 and 3U for carbs (assuming 50 (mg/dL)/U and 15g/U factors). The rig will likely have already dosed insulin to bring your BG to your low target, and you are potentially "double dosing". In these scenarios, you will have too much insulin onboard and can experience a severe low. If you use the Boluz Wizard, ensure the high end of the BG target range is a high number such as 250 mg/dL. OpenAPS default behavior (`wide_bg_target_range` preference) is to only use the target range lower end. Setting the high end does not impact the OpenAPS algorithms.

## What do you do with the loop in airport security when you travel
The loop is off the shelf hardware - it's no different than your phone or other small gadgets, so leave it in your carry-on bag when going through security. (Dana note: I have traveled [well](https://twitter.com/danamlewis/status/811682733445496833) over 100 times with my loop, and in some cases with 3-4 Pis and batteries and related accessories, and have never had issues going through security because of my loop.)
 
## What do you do with your loop when you travel across timezones? How do you update devices for a time zone change?
You have a couple of options. If you are traveling briefly, or only across a couple of timezones, and would not normally feel the need to adjust the timing of your basals, then you may choose to simply leave your pump, receiver, and Pi/Edison on your home timezone. But, if you would like to adjust to the new timezone (perhaps for a longer trip or a move), you can adjust your rig's timezone using `sudo dpkg-reconfigure tzdata` and then either run `killall -g oref0-pump-loop; oref0-set-device-clocks` to set the devices to match, or just change your pump and receiver time manually.  Make sure to test in your new location to make sure everything is working! We also recommend planning to do this when you have some extra time for troubleshooting, in case you have issues. Also, it's worth noting that your body only changes about an hour or so of timezone a day, so even if you go abroad, there's not a rush to change timezones/the time on your devices - you can wait until 2-3 days into your trip to make the swap, at a time when you have some room to update your rigs.

After the timezone change OpenAPS sometimes gets confused about the BG and/or pump data being "in the future".  The pump and CGM data are not timestamped in UTC, so being unsynchronized with the OpenAPS can cause incorrect behavior.  When the BG or pump data is "in the future" the software may stop pulling current information from the pump, and stop functioning (until the current time in the system reaches the time when the monitor data is no longer "in the future"). It often makes sense to remove all files from OpenAPS <i>monitor</i> folder after changing the timezone.  However, this is sometimes insufficient, as the devices will still have records that are "in the future" from the perspective of your new timezone.  As a result, you should expect Nightscout uploads to fail until the system time catches up to the previous device time, particularly when traveling west.

## What do you do with the loop when you shower?
Because the pumps aren't really waterproof, most of us choose to suspend and disconnect our pumps before we shower. You'll do the same thing even after you're looping. One trick, though, is to cancel any running temp basal rate and set a temp basal for 30 minutes with a rate of 0.0, and then suspend the pump. This will help OpenAPS accurately track your netIOB while you are off your pump. When you get out of the shower and are ready to reconnect your pump, do so. Make sure to unsuspend it. You can then either manually cancel the zero temp basal or let OpenAPS read and decide what temp basal to issue next.

## What do you do when you change sites?
The time required for the typical site change is normally not long enough to appreciably change the netIOB while disconnected. If you want to stay as close as possible to your true netIOB, follow the same process as the shower to put the pump into suspend mode. When it is time to prime, unsuspend and then prime. After priming, you can suspend again after checking to ensure the rig did not enact a temp basal > 0 while you unsuspended. If your site does not require priming after insertion, simply unsuspend the pump. If your site requires priming a canula after insertion, use fix prime to prime the canula after unsuspending.  At this point, you can either manually cancel the zero temp basal or let OpenAPS read and decide what temp basal to issue next.

## What do you do when you exercise?
This varies from person to person, and depends on the type and length of activity.  Here's a few tidbits from [Dana](http://twitter.com/danamlewis) on how she does various activities. (Other loopers, PR into this page with your additional tips and how-to's.)
  * **Hiking** - Definitely take the loop with! Think about setting a temporary target (you can enter it in Nightscout if you have connectivity) higher for the duration of the exercise. If you're offline, just change your targets in your pump. The loop will read the adjusted targets and begin looping toward that target. When you're done with the activity, change your targets back. In this scenario, I might change my loop target from 100 (normal day or nighttime) to 130 or 140 as a target.

  * **Swimming, Snorkeling, Scuba Diving, etc. (water sports)** - You can't loop while you're in the water, because the pump is not waterproof. (Unless you're sitting in a hot tub and have your pump safely above water, along with your CGM sensor being above water so it can transmit to the receiver, which is also not waterproof.)  You can try having your sensor on your arm and keeping it above water so it can read every now and then if the receiver is in range. That being said, again, pump is NOT waterproof so you'll need to apply shower methodology (temp to zero, suspend, take pump off) to best track your netIOB. Some people observe having the CGM, once it gets back into range and reads data after the sensor has been submerged, read falsely high. It's not a big deal for the loop (because it's looking at trends, and doses using temp basals in a conservative way), but you'll likely want to fingerstick and/or wait a while before you'll be really happy with your CGM results again.  See below for another strategy that could work as well if you're much more active than usual.

  * **Running** - If it is a short run, (<30 minutes), I may not take the loop with me because any adjustments it would make are going to impact me after the run is done. For longer runs, I often now take my small, Edison based rig which can slip into the pocket of my hand-held running drink bottle that holds Gatorade. Before any length run, I try to make sure I don't have much positive netIOB on board (that's the biggest key to success). I also turn on activity mode (essentially a temp target of 120-140 or changing my pump targets to 120-140) an hour or so before a run and during the run; especially if I am carrying the loop during the run.

 For any exercise or activity or time period, if you do not choose to take your loop (or if you forget it), the loop will pick up again once you get back into range and resume. (This is why it's important to temp then suspend so it can track the amount of insulin you haven't been getting.)

## What do you do if you want to be off the pump for long periods during a day when you're really active?  Like for the beach or water park or sporting activity or similar?

Let's face it.  There are some days when you just don't want to be attached to a pump.  It's not uncommon for kids at diabetes camp to take a "pump holiday" where they revert to insulin injections in order to be unencumbered by the pump as they run and play and swim.  Unfortunately this means a trade off - giving up the safety of closed loop control.  Some have employed a strategy to be off the pump while active for extended periods but still have the advantages of closed loop assistance during less active periods of the day and overnight by using a combination of long acting basal injections in conjunction with the closed loop, in a manner similar to the following.  Note that this will only work on days that you're really, really active (and as such will have significant reductions in your overall basal requirements).

  * **First -**  Look at your pump and determine your 24 hour basal insulin dose.
  
  * **Second -** Create an alternate basal profile (Profile A or B) on your pump with settings for each time period that are half of your normal settings (we'll call this a "Half Basal" profile).  You'll also want to make a "Half Basal" profile in Nightscout with the new settings, and consider establishing target glucose ranges for the entire 24 hour period that are higher than you might normally use (use values similar to what you would use for activity).  For children a reasonable choice might be 140-180 but yours may be different.
  
  * **Third -**  On the morning of the active day, record the time and give an injection of long acting basal insulin at HALF THE USUAL DOSE of your usual 24-hour basal requirement (which you determined above).  At the same time switch your pump to the "Half Basal" profile you created.  You'll  get half the usual basal dose from the injection, and half from your pump.  You should also change your blood sugar targets on your pump to whatever you decided on when you set up your alternate profile above (don't forget to change them back later).   Use the + icon on Nightscout (upper right corner) and choose event Profile Switch to Half Basal (or whatever you called it) in order to assure appropriate visualization of the basal settings via Nightscout when you have connectivity.
  
  * **Fourth -**  During periods when you're going to be very active, disconnect your pump and set an extended temp basal manually of 0.0 (choose a duration of several hours, or as long as you think you might be off the pump), and then suspend.  This will allow the APS to track the negative IOB.  Obviously since you're going to be off the pump (and if in the water, potentially without the benefit of CGM data as well) you'll want to remember to test more frequently.
  
  * **Fifth -**  Hook back up to the pump for meals to bolus and/or correct for hyperglycemia, and for periods where you'll be less active during the day.  Don't forget to reset a temp basal of 0.0 when you suspend again in order to track negative IOB
  
  * **Sixth -**  At the end of the day, hook up to the pump, cancel your temp basal of 0.0 and start looping again.  If you've been in the water, recognize it may take some time before your CGM data regains full accuracy, so you may still want to check more frequently.  Check and make sure your pump is setting temp targets appropriately and check Nightscout to make sure all is going as you expect.  You should still be on the "Half Basal" profile.
  
  * **Overnight -** The loop will titrate your basal up or down in response to your CGM data.  The caveat is, of course, that even if it lowers your temporary basal to 0.0 you will still be subject to the effects of the dose of long acting subcutaneous insulin you took in the morning.  This will render the loop somewhat less effective at avoiding hypoglycemic events, and is in part the reason that higher than usual targets for blood glucose would be appropriate.  Recognize also that after intense periods of physicial activity it is likely you will be more insulin sensitive, which could exacerbate the potential for hypoglycemia.  Better to be safe and run slightly higher than normal.
  
  * **The Next Morning -**  Around 24 hours after the time you took your long acting insulin dose, switch your pump back to the normal profile, and readjust your glucose targets to your normal values on your pump.  Use Profile Switch in Nightscout to switch back to your usual profile.  Continue to monitor yourself somewhat more frequently until you're sure things are completely back to normal and all of the effects of the long acting insulin bolus from the prior day have resolved.  Alternatively, if you're going to have several days of similar activities in a row, you could take another long acting basal dose and go at it again.  Use your experience from the prior day to adjust that dose up or down slightly depending on how things went with your first day's glucose readings.

## What if I want to turn off the loop for a while?

If you're near the rig or pumper, any one of these actions will turn off the loop:
* Power down the rig
* Turn the temp basal type to % on the pump, which blocks temps from being set
* Log in and stop cron

If you're not near the rig or pumper, any one of these actions will turn off the loop:
* If on same wifi as rig, you can log in and stop cron
* Or change the API secret of NS temporarily, which means OpenAPS can't pull BGs in and loop anymore (so after last temp basal previously set expires, defaults to normal basal rates). 
* *(This one needs testing and validation, the low target may get ignored, or set as 80 as that's the lowest target you can usually set in OpenAPS)*: use very wide temp targets in your Nightscout website.  You can set an wide range from -1000 to 1000 as a temp target for a period of time and it will effectively turn off the loop.  
* You can also choose to leave it at home if you are going out and do not want to be looping during that time. It will start looping again when you get back into range and it can successfully read your pump and CGM data again.

## How do I open loop?

The easiest way to "open loop" is to set the temp basal type on your pump to be "%" instead of "u/hr". This means your pump cannot and willnot accept temporary basal rates commands issued by the rig. But, the rig will still be able to read from the pump and your CGM, and make the calculations of what it would otherwise do. 

You can then watch the OpenAPS pill in Nightscout, or your logs (`l`) on the rig to see what OpenAPS would be doing.

## How can you make adjustments to insulin delivery while on the go? - Optimizing with Temporary Targets:
The use of Temporary Targets can provide additional fine tuning of insulin control on the go, or remotely for parents monitoring children when they are at school or away from home. As described elsewhere in this documentation, an Eating Soon-type (lower than normal) Temporary Target can be used in advance of a meal or activity. Lower Temporary Targets can also be used to force the OpenAPS system to be somewhat more aggressive in correcting a rising blood sugar. Similarly, a higher temporary target can soften a blood sugar drop and help avoid a low, or help limit stacking of insulin that is likely to peak during activity. Temp targets can be set a number of ways, from using IFTTT so you can set them easily from your watch or phone; or by entering them in Nightscout Care Portal.

Temporary Targets can be set in advance by setting a future date/time stamp in Nightscout when you set them.  For example, a parent may wish to set a week's worth of Eating Soon or Activity Modes in advance of a regular school week.  This may be particularly helpful for meals or activity (i.e. gym class) which are regularly scheduled but for which you may have difficulty remembering to trigger the Temporary Target at the right time.  Scheduled or remotely activated Temporary Targets can also be very useful in supporting children in optimal management at school or other locations where there may not be an adult who is in a position to set the Temporary Target each time it is needed. It's also helpful even for adult PWDs when traveling; a loved one at home in a different time zone can set temp targets as needed to help direct the rig's activity while the PWD might be asleep or otherwise occupied.<br>

## How do I improve the range of my Edison/Explorer Board?

There are two options for improving the range of an Explorer Board. The easiest way is to purchase a "wire whip" antenna to add to your rig. [Here is one available at Mouser (915MHz only)](https://www.mouser.com/ProductDetail/620-66089-0930?R=66089-0930virtualkey65480000virtualkey620-66089-0930) or for 866/868 MHz [also availabe at Mouser](https://www.mouser.at/ProductDetail/Anaren/66089-0830?qs=pH7abCSN9NPb5X5zwyxl2w==). You can buy one [at Enhanced Radio Devices](https://www.enhancedradio.com/collections/all) as well, you may consider ordering it with your Explorer Board. It physically clips on to your rig. The picture below shows the antenna clipped on and extended from the board; but you can experiment with wrapping the antenna around your rig to fit in your preferred case to see various impacts to the range. 

![Image of Antenna](../Images/antenna1.jpg)

The other option is to tune the existing on-board antenna by cutting it. The antenna on the Explorer Block is a strip of copper underneath the green outer coating. The antenna is labeled A1. It will have its maximum power at 868 MHz. The antenna has a line across it at one point with a label that says "915". The antenna defaults to the 868 MHz range, which is what WW pumps use. If you have a US pump, mmtune will run and tune to something near 916MHz. Even with the 868 MHz antenna, you should get half a dozen feet or more of range on average.  If you (optionally) want to boost the range of your antenna by a couple more feet, then you cut through the outer coating and the copper on that line with an X-ACTO knife. A single clean cut is sufficient, but if the cut doesn't look clean you could make two cuts and then dig out the circumscribed piece and then reseal the copper with nail polish. With that cut, the antenna will have maximum power near 915 MHz.

If you're unsure whether you need to cut your Explorer Block's antenna, you probably don't.  And if you decide you need slightly more range after using the Edison+Explorer rig for a few weeks, you can always come back later and do so then.

![Image of Antenna](../Images/antenna0.jpg)

## How do I switch between insulin types, or switch to Fiasp? What should I change?

The most important setting for switching between insulin types in an OpenAPS rig is the "curve" type for duration of insulin activity. In oref0 0.6.0, most users will use the rapid-acting curve if they are using Humalog, Novolog, or similar. Fiasp users should use the "ultra-rapid" curve type. [See the preferences page here for more details on how to change your curve](http://openaps.readthedocs.io/en/latest/docs/While%20You%20Wait%20For%20Gear/preferences-and-safety-settings.html#curve-rapid-acting) in your `preferences.json` file (which you can edit with `edit-pref`). 

Additionally, because Fiasp has a slightly faster peak time, you may need to adjust your behavior around meal-time dosing. If you pre-bolus, you may want to consider *not* pre-bolusing for the first few meals with Fiasp until you understand the differences, to avoid lows during or after the meal.

Some users who switch to Fiasp find that they need to adjust settings. Others do not need to change settings that much, and autosens and/or autotune can help adjust to any variances over time as your body's needs change related to the difference insulin type. YDMV, as always!

## Improving the battery life of your Raspberry Pi

!! Important for Enlite users: If you are using Enlite as CGM source, your rig will not work when it's underclocked, since the loop will not run fast enough! (You will always see the "BG too old" error). We are aware of that issue and try to find a solution...

Version - CPU Clock - Battery Life @ 2500mAh (Li-Po)
___
* 0.6.2 - 1000 MHz - **8 hours**
* 0.7.0-dev - 1000 MHz - **9 hours**
* 0.7.0-dev - 500 MHz  - **14.5 hours**
___

As you can see, 0.7.0 made some battery life improvements, but under-clocking the CPU makes an even more significant improvement.

To accomplish this, log into your rig via SSH and modify the file `/boot/config.txt`.

Scroll down to find the line

`#arm_freq=1000`

and change it to

`arm_freq=500`

Note the removal of the `#` at the beginning of the line. Save your change and reboot your rig!
