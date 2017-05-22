# Installing OpenAPS on your rig

### Prep Steps
PC users: [follow these instructions to get PUTTY and plug in your rig](windows-putty-prep.md). Then, follow the rest of the instructions below.
Mac users: [follow these instructions to open Terminal and plug in your rig](mac-prep.md). Then, follow the rest of the instructions below.

### Log in to your rig

Copy and paste this: `ssh root@edison/local` and hit enter. Use the password that came with your Edison (probably edison).

You should now see the command prompt change to be root.

### Copy and paste to run this script

Copy and paste the script from https://github.com/openaps/docs/blob/dev/scripts/openaps-bootstrap.sh. Hit enter.

The script will ask you for the following: 
* Type in your wifi, and your password when it comes up.
* Select your time zone. 
* Change your hostname. **Make sure to write down your hostname; this is how you will log in in the future**

**Also be prepared to enter the following items:** 

* directory name for your openaps
* email address for github commits
* serial number of your pump
* whether or not you are using an Explorer board
* if not an Explorer board, and not a Carelink stick, you'll need to enter the mmeowlink port for TI stick or Explorer board (built in TI stick):
    * see [here](https://github.com/oskarpearson/mmeowlink/wiki/Installing-MMeowlink) for directions on finding your port
* (if you're using a Carelink, you will NOT be using mmeowlink)
* how you are getting CGM data.  The options are `g4` (default), `g4-raw`, `g5`, `mdt`, and `xdrip`.  Note:  OpenAPS also attempts to get BG data from your Nightscout.  OpenAPS will always use the most recent BG data regardless of the source.
* Nightscout URL and API secret
* whether you want any of the oref0 advanced features (AMA, Autosens, and/or Autotune)
* BT MAC address of your phone, if you want to pair for BT tethering to personal hotspot
* whether or not you want to automate your loop (using cron)
* **Worldwide pump users**
If you are running from the master branch and not the WW branch, you'll need to follow the instructions at https://github.com/oskarpearson/mmeowlink/wiki/Non-USA-pump-settings to ensure that the correct frequency is used by mmtune.
* After the setup script builds your myopenaps, it will ask if you want to schedule a cron (in other words, automate and turn on your loop).  Usually you'll want to answer `yes` and also then press `enter` to reboot after the cron is installed.

## How to watch your logs

Watch the logs - REQUIRED

THIS IS A REQUIRED MUST-LEARN HOW-TO STEP - DO NOT MOVE ON WITHOUT DOING THIS! This is a key skill for monitoring your OpenAPS setup to "check" or "monitor" or "watch" the logs. It's easy:

(For rigs updated to master after 2/7/17 ([here is how to update](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-2/update-your-rig.html)), you can simply type the letter "l" (aka the single letter `l`), or use the full tail command below to see the logs).

`tail -F /var/log/openaps/pump-loop.log`

Type control-C to exit the pump-loop log.

This will work anytime, anywhere when you log into your rig and is a necessary step for troubleshooting in the future. Do not move forward without having done this step. 

Also, there are several loop logs contained within your OpenAPS setup...not just a pump-loop.  For example, there are also logs for the following operations in your rig:

* Autosens adjustments log: `tail -F /var/log/openaps/autosens-loop.log`

* Nightscout log: `tail -F /var/log/openaps/ns-loop.log`

* oref0-online or wifi connection log: `tail -F /var/log/openaps/network.log`

* Autotune log: `tail -F /var/log/openaps/autotune.log`

You may also want to run Papertrail ADD LINK HERE ABOUT PAPERTRAIL.
