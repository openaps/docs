# Step 5: Finish your OpenAPS setup

You're looping? Congrats! However, you're not done quite done yet. 

****************
**Shortly after you confirm your loop is running, you should [set your preferences](<../Usage and maintenance/preferences-and-safety-settings>).  Don't forget, your preferences are reset to defaults after each run of a setup script, so please remember to check preferences after confirming a loop is successfully run/rerun.**
*******************

## So you think you're looping? Now keep up to date!

If you've gone "live" with your loop, congratulations! You'll probably want to keep a very close eye on the system and validate the outputs for a while. (For every person, this amount of time varies).

One important final step, in addition to continuing to keep an eye on your system, is letting us know that you are looping.

**This is important in case there are any major changes to the system that we need to notify you about**. One example where this was necessary is when we switched from 2015 to 2016: the dates were incorrectly reporting as 2000, resulting in incorrect IOB calculations. As a result, we needed to notify current loopers so they could make the necessary update/upgrade.

### After you have looped for three consecutive nights:

So that we can notify you if necessary, [please fill out this form if you have been looping for 3+ days](http://bit.ly/nowlooping). Your information will not be shared in any way. You can indicate your preferred privacy levels in the form. As an alternative, if you do not want to input info, please email dana@openaps.org. Again, this is so you can be notified in the case of a major bug find/fix that needs to be deployed.

**Note**: you only ever need to fill this form out once. If you're building multiple rigs, or switching between DIY systems, no need to fill this out multiple times. We're just counting - and wanting to connect with in terms of safety announcements - humans. :) 

## Optional step: improving the battery life of your Raspberry Pi

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

## Customizing your closed loop

As your time permits, there's still more useful and cool things you can do to make looping more efficient and automated.

* First, review some [common situations you may encounter and practical advice for using your loop.](<../Usage and maintenance/usability-considerations>)
* [Add more wifi networks to your rig](<../Usage and maintenance/Wifi/on-the-go-wifi-adding>) so that when you are away from home, the rig has access to trusted wifi networks
* [Set up Papertrail](<../Usage and maintenance/monitoring-openaps#papertrail-remote-monitoring-of-openaps-logs-recommended>) Papertrail will even allow you to remotely track your logs when you are not logged into your rig. Setting up Papertrail and watching your logs will dramatically help you understand your rig and help troubleshoot if you run into problems.
* [Set up IFTTT for your phone or watch](<../Customize-Iterate/ifttt-integration>) to allow you to use Nightscout's temp targets, carb entries, and similar for single button interactions with your rig
* [Finish Bluetooth tethering your phone](<../Usage and maintenance/Wifi/bluetooth-tethering-edison>) so that when you are away from trusted wifi networks, your rig can automatically access your phone's mobile hotspot for continued online looping. 
* [Learn about offline looping](<../Customize-Iterate/offline-looping-and-monitoring>) for times when your rig is not able to access internet (no wifi, no hotspot).
* [Additional access to your rig via other types of mobile apps.](<../Customize-Iterate/useful-mobile-apps>) Grab some of these other apps, based on your preference, for accessing your rig in different ways. 

Remember, the performance of your DIY closed loop is up to you. Make sure you at least look at the rest of the documentation for help with troubleshooting, ideas about advanced features you can implement in the future when you're comfortable with baseline looping, and more. Plus, the docs are updated frequently, so it's worth bookmarking and checking back periodically to see what features and preference options have been added. 

