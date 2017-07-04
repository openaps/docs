# Installing OpenAPS on your rig with an already-flashed-Edison

### Prep Steps
PC users: [follow these instructions to get PUTTY and plug in your rig](windows-putty-prep.md). Then, follow the rest of the instructions below.

Mac users: [follow these instructions to open Terminal and plug in your rig](mac-prep.md). Then, follow the rest of the instructions below.

### Log in to your rig

If you're not already, make sure you're logged into your rig via root. You should see root@jubilinux on the command prompt.

### Copy and paste to run the wifi and oref0-setup scripts

Go to [this webpage](https://raw.githubusercontent.com/openaps/docs/dev/scripts/openaps-bootstrap.sh) in a separate tab/window.

Copy all of those lines; go back to Terminal/PuTTY and paste into the command line. Then, hit enter.

The script will do some initial installing, check the wifi, and ask you to hit enter to proceed.

It will run for a while again, and then ask you for the following: 
* Type in your wifi and hit enter; and type your wifi password and hit enter.

![Example of wifi bootstrap script finding wifi options](../Images/Edison/openaps-bootstrap-wifi-setup.png)

* Change your hostname. **Make sure to write down your hostname; this is how you will log in in the future as `ssh root@whatyounamedit.local`**

* Pick your time zone. (i.e. in the US, you'd hit enter on US; and scroll and find your time zone, such as Eastern)

It will then continue to run a while (~10+ minutes) before initiating the oref0-setup.sh script automatically, which will ask you for the following:

**Be prepared to enter the following items:** 

* directory name for your openaps - we recommend the default `myopenaps` 
* email address for github commits
* serial number of your pump
* whether or not you are using an Explorer board
* if not an Explorer board, and not a Carelink stick, you'll need to enter the mmeowlink port for TI stick or Explorer board (built in TI stick):
    * see [here](https://github.com/oskarpearson/mmeowlink/wiki/Installing-MMeowlink) for directions on finding your port
* (if you're using a Carelink, you will NOT be using mmeowlink)
* how you are getting CGM data.  The options are `g4` (default), `g4-raw`, `g5`, `mdt`, and `xdrip`.  Note:  OpenAPS also attempts to get BG data from your Nightscout.  OpenAPS will always use the most recent BG data regardless of the source.
* Nightscout URL and API secret
* whether you want things like Autosensitivity (recommended), and/or Autotune
* whether you want any oref1-related advanced features - NOT RECOMMENDED until you have run oref0 and are familiar with basic OpenAPS looping
* BT MAC address of your phone, if you want to pair for BT tethering to personal hotspot
* After the setup script builds your myopenaps, it will ask if you want to schedule a cron (in other words, automate and turn on your loop).  Usually you'll want to answer `y` - and also then press `enter` to reboot after the cron is installed.

#### Log in again, and change your password

If this is your first build, after it reboots it will prompt you to log back in. Log in as "root" and the password from before (probably edison). It will ask you a second time for the current password (probably edison). However, now it will prompt you to change your password.  You'll want to change it to something personal so your device is secure. Make sure to write down/remember your password; this is what you'll use to log in to your rig moving forward. You'll type it twice.

Once you've successfully changed your password, you'll end back at the command prompt, logged in as root and ready to watch your logs while the system begins to read your pump history, gather glucose records, and begin the calculations of any needed adjustments. So it's time to watch your logs next!

## How to watch your logs - REQUIRED!

THIS IS A REQUIRED MUST-LEARN HOW-TO STEP - DO NOT MOVE ON WITHOUT DOING THIS! This is a key skill for monitoring your OpenAPS setup to "check" or "monitor" or "watch" the logs. 

It's easy: simply type the letter `l` (for logs). (*This is a shortcut for the full command, `tail -F /var/log/openaps/pump-loop.log`*.)

Done watching the logs? Type control-C to exit the pump-loop log.

This will work anytime, anywhere when you log into your rig and is a necessary step for troubleshooting in the future. Do not move forward without having done this step. 

Also, there are several loop logs contained within your OpenAPS setup...not just a pump-loop.  For example, there are also logs for the following operations in your rig:

* Autosens adjustments log: `tail -F /var/log/openaps/autosens-loop.log`

* Nightscout log: `tail -F /var/log/openaps/ns-loop.log`

* oref0-online or wifi connection log: `tail -F /var/log/openaps/network.log`

* Autotune log: `tail -F /var/log/openaps/autotune.log`

(Normal docs:) Please see [Phase 1 Papertrail](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-1/papertrail.html) for an easy way to track all your logs in one easy setup.  Papertrail will even allow you to remotely track your logs when you are not logged into your rig.  Setting up Papertrail and watching your logs will dramatically help you understand your rig and help troubleshoot if you run into problems.

## You're not done yet - switch back to the main/normal docs for more customizations

You're looping? Congrats! However, you're not done yet. There's still more to learn - make sure you read the next few sections for information to make sure you know how to read your logs and [answer the question of "why is it doing what it is doing?"](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/Understand-determine-basal.html); make sure [you're in the right mode](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/beyond-low-glucose-suspend.html#going-beyond-low-glucose-suspend-mode) (do you only want it to limit insulin when dropping low? do you want it to increase insulin when your BG is high?), plus [customize all the other settings](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-3/beyond-low-glucose-suspend.html#understanding-your-preferences-json). 

Remember, the performance of your DIY closed loop is up to you. Make sure you at least look at the rest of the documentation for help with troubleshooting, ideas about advanced features you can implement in the future when you're comfortable with baseline looping, and more. Plus, the docs are updated frequently, so it's worth bookmarking and checking back periodically to see what features and preference options have been added. 

(Not looping yet? No worries - remember it may take 15-20 minutes for the first loop to run; and see the [next page on troubleshooting tips](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-2/troubleshoot-oref0-setup.html) you should work through before asking for help.)
