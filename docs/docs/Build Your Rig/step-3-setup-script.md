# Step 3: Setup script

* **If you pressed `enter` to continuing on with the setup script at the end of the bootstrap script**, you do **NOT** need to specifically enter the command in the box below.  By pressing `enter` to continuing on with setup script, the command was automatically started for you.

* **If you pressed `control-c` to end at the completion of the bootstrap script** and did not continue automatically with setup script, this is where you'll pick back up.  At this point, your rig should have your first wifi connection finished and your dependencies installed.  

    Login to your rig and run the following command (aka "the setup script"):
    
    `cd && ~/src/oref0/bin/oref0-setup.sh`

(Note: if this is your first time logging into the rig since running bootstrap script, you will have to change your rig's password on this first login.  You will enter the default password first of `edison` and then be prompted to enter your new password twice in a row.  If you get an error, it is likely that you forgot to enter `edison` at the first prompt for changing the password.)

#### Be prepared to enter the following information into the setup script:

The screenshot below shows an example of the questions you'll be prompted to reply to during the setup script (oref0-setup).  Your answers will depend on the particulars of your setup.  Also, don't expect the rainbow colored background - that's just to help you see each of the sections it will ask you about!

<details>
    <summary><b>Be prepared to enter the following items (click here to expand list):</b></summary>
<br>

* 6-digit serial number of your pump
* whether you are using an 512/712 model pump (those require special setup steps that other model pumps do not)
* whether you are using an Explorer board
   * if not an Explorer board, and not a Carelink stick, you'll need to enter the mmeowlink port for TI stick.  See [here](https://github.com/oskarpearson/mmeowlink/wiki/Installing-MMeowlink) for directions on finding your port
    * if you're using a Carelink, you will NOT be using mmeowlink. After you finish setup you need to check if the line `radio_type = carelink` is present in your `pump.ini` file.
* CGM method:  The options are `g4-upload`, `g4-local-only`, `g5`, `mdt`, and `xdrip`.
   * Note:  OpenAPS also attempts to get BG data from your Nightscout.  OpenAPS will always use the most recent BG data regardless of the source. As a consequence, if you use FreeStyle Libre or any other CGM system that gets its data only from Nightscout, you'll be fine choosing any of the options above. 
   * Note:  For Medtronic 640G (CGM) users, it is recommended that you enter 'xdrip' - otherwise the BG values may not be read from your Nightscout. (The reason being, the 'MDT' option applies only for the enlite sensor attached to the actual pump you're looping with)
   * Note: G4-upload will allow you to have raw data when the G4 receiver is plugged directly into the rig.
* Nightscout URL and API secret (or NS authentication token, if you use that option)
* BT MAC address of your phone, if you want to pair for BT tethering to personal hotspot (letters should be in all caps)
  * Note, you'll still need to do finish the BT tethering as outlined [here](http://openaps.readthedocs.io/en/latest/docs/Customize-Iterate/bluetooth-tethering-edison.html) after setup.
* Your desired max-iob
* whether you want Autosensitivity and/or Autotune enabled
* whether you want any carbs-required Pushover notifications (and if you do, you'll need your Pushover API token and User Key)

</details>

![Oref1 setup script](../Images/build-your-rig/sample-setup.png)

At the end of the questions, the script will ask if you want to continue.  Review the information provided in the "to run again with these same options" area...check for any typos.  If everything looks correct, then press `y` to continue.  If you see a typo, press `n` and then type `cd && ~/src/oref0/bin/oref0-setup.sh` to start the setup questions over again.

After the setup script finishes building your loop (called myopenaps), it will ask if you want to schedule a cron (in other words, automate and turn on your loop) and remove any existing cron.  You'll want to answer `y` to both - and also then press `enter` to reboot after the cron is installed.  If your setup script stalls out before those two questions happen, rerun the setup script again.

**************************

### Log rotate fix

<details>
    <summary><b>Click here to expand notes about checking log rotate, which was fixed in 0.6.1:</b></summary>
<br>
    
Make sure that at the end of the setup script, your log rotate file is set to `daily` as described below.  Most users will have the `compress` line properly edited already, but the log rotate file seems to be left at `weekly` for many users.  If you leave the setup at `weekly`, you will likely get a `device full` error in your pump logs within a week...so please check this before moving on!

* Enter `vi /etc/logrotate.conf` then press “i” for INSERT mode, and make the following changes so that your file matches the one below for the highlighted areas:

 * set the log rotation to `daily` from `weekly`
 * remove the # from the “#compress” line (if it is present)

* Press ESC and then type `:wq` to save and quit

![Log rotation examples](../Images/Edison/log_rotation.png)

</details> 

