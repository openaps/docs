# Installing OpenAPS on your rig

### Prep Steps
PC users: [follow these instructions to get PUTTY and plug in your rig](windows-putty-prep.md). Then, follow the rest of the instructions below.

Mac users: [follow these instructions to open Terminal and plug in your rig](mac-prep.md). Then, follow the rest of the instructions below.

### Log in to your rig

First, copy and paste: `sudo screen /dev/tty.usbserial-* 115200`, then hit enter.

You’ll most likely be asked for your **computer password**.  Enter it.  A blank screen will likely come up, then press enter to wake things up to show an Edison login prompt.  Login with username “root” (no quotes) and no password will be needed. 

![Example terminal screen](../../Images/Edison/change_me_out_for_jubilinux.png)

If you have a problem getting to the Edison login prompt, and possibly get a warning like "can't find a PTY", close that terminal window.  Then unplug the usb cables from your computer (not from the Edison...leave those ones as is) and swap the USB ports they were plugged in.  Open a new terminal window, use the `sudo screen /dev/tty.usbserial-* 115200` command again.  Usually just changing the USB ports for the cables will fix that "can't find a PTY" error.

(**Note**: In the future, you will log into your rig by typing `ssh root@edison.local`, when you do not have the rig plugged into your computer. Also note that if you change your hostname, it will be `ssh root@whatyounamedit.local`)

You should now see the command prompt change to be root.

### Copy and paste to run the wifi and oref0-setup scripts

Copy and paste the script from https://github.com/openaps/docs/blob/dev/scripts/openaps-bootstrap.sh. Hit enter.

The script will do some initial installing, check the wifi, and ask you to hit enter to proceed.

It will run for a while again, and then ask you for the following: 
* Type in your wifi and hit enter; and type your wifi password and hit enter.
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

You may also want to run Papertrail.
