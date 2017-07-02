# Troubleshooting oref0-setup script process

Please be patient. It can take 15-20 minutes for your new OpenAPS rig to enact temp basal rates on your insulin pump after powering on for the first time. Your OpenAPS rig can require the same 15-20 minutes if it's been powered off for more than 20 minutes. It often takes less time but don't over-react. Your rig has to establish network connections, pull CGM data, pump history data, and perform complex calculations prior to enacting temp basals. If your insulin pump does not indicate a temp basal after approximately 15-20 minutes, however, you can begin troubleshooting the cause. A simple reboot, instead of a power on, should take much less time.

## Re-run the script again

You won't hurt anything by running the script (step 2) multiple times, as long as you name it something different. If you already have a working loop and are testing the setup scripts, just make sure to comment out in cron the loop you don't want running.

## Should I enact cron?

Cron is the scheduler that runs the loop. I.e. this is the automation feature to automate your closed loop. If you're using a test pump, it's pretty safe to go ahead and automate your loop. But if you're not sure, you can always come back and do this later.

If you're troubleshooting and looking to use `openaps` manually, cron must be momentarly disabled to free access to local resources.  To check if cron is running use `crontab -e` or `crontab -l`.  If you see a file filled with content, chances are cron is enabled.

To stop cron'd jobs and enter an openaps command:  `killall -g openaps; openaps <whatever>` 

If you'd like to run multiple commands without having to do `killall -g openaps; ` before each one, you can run `sudo service cron stop` first.
<br>
To start cron: `sudo service cron start` or reboot your rig.

To prevent cron running on initial boot, either clear the `crontab -e` file or "comment out" (`#`) each line of the crontab file.  If you've cleared the crontab file, but would like to enable cron'd tasks, rerun the initial setup script (step 2) and indicate you'd like to use cron.  This will regenerate the configuration.

## How do I know if it is working?

Please be patient. We can not emphasize this enough.

* Check your pump to see if it is setting temp basals.
* "Tail" the pump log to see what is is doing: `tail -F /var/log/openaps/pump-loop.log`
* A very basic test to see if the pump communication works is to issue a `openaps use pump model`. That should return your pump model. If it displays an error or an empty string your rig can't communicate with your pump.
* Check Nightscout to see if it is updating with your information. Note: that if Nightscout is not showing your loop is running, it might be running but unable to communicate with Nightscout. In those cases check the pump-loop.log on your rig.
* Run commands manually (check out the [openaps toolkit basics here](http://openaps.readthedocs.io/en/latest/docs/openaps-guide/core/medtronic.html#openaps-use-pump)) 

## It's not working yet:

Make sure to check through the following list before asking on Gitter if your setup is not working (yet). Remember if you just ran oref0-setup.sh, wait a good ~20 minutes as mentioned above before seeking help. Time, and the below list of steps, resolves 99% of problems. Also check out [this blog post for tips if asking for help online](https://diyps.org/2017/03/19/tips-for-troubleshooting-diy-diabetes-devices-openaps-or-otherwise/).

* Check to make sure that your pump is in absolute and not % mode for temp basals.
* Did you put in the right SN for the pump? Should be numbers only...
* Check to make sure your carelink and/or radio stick is plugged in.
* Check to make sure your receiver is plugged in, if you're plugging a receiver in.
* Don't have data in Nightscout? Make sure there is no trailing slash `/` on the URL that you are entering and that the API secret is correct. Check your Nightscout URL, too - it's one of the most common errors to mistype that. (And FWIW, you shouldn't be typing things like that in the first place: that's what copy and paste are for.)
* Check and make sure your receiver is >50% charged (if battery low, it may drain the rig battery and prevent it from operating).
* Check and make sure your pump is near your rig. Closer is better, e.g. check if it works when the pump and rig are at most 20 inches (50 cm) apart.
* Check that your pump battery is not empty.
* Check and make sure your pump is not suspended or stuck in rewind or prime screens. If it's a test pump, you don't even have to fill a reservoir, but put your pinky finger or eraser-end of a pencil in for slight pressure when priming so the pump will "sense" it and stop. Make sure to back out of the prime screen.
* Check to make sure you have a carb ratio set manually in your Medtronic insulin pump, if it is not done, the follwoing display will appear in your pump.log: Could not parse input data: [SyntaxError: /root/myopenaps/monitor/iob.json: Unexpected end of input]
* A reboot may be required after running oref0-setup if the Carelink is unable to communicate with the pump (e.g. you see "Attempting to use a port that is not open" errors in pump-loop.log). Additional Carelink troubleshooting steps can be found in [Dealing with the CareLink USB Stick](http://openaps.readthedocs.io/en/latest/docs/Resources/troubleshooting.html#dealing-with-the-carelink-usb-stick).
* 512/712 users - see the section at the bottom of the page

## Running commands manually to see what's not working from an oref0-setup.sh setup process
  
You've probably run into an error in your setup where someone has recommended "running commands manually" to drill down on an error. What to do? Some of the following:
  
 * Start by killing anything that's currently running. ` killall -g openaps`
 * Look and see what's running in your cron. `crontab -l`
 * If you want to do more than one command of debugging, it's best to disable your cronjobs, use `/etc/init.d/cron stop`. Don't forget to start the cronjobs afterwards or reboot your rig to make sure the cronjobs will be running.
 * Run whichever alias is failing to see what commands it is running. I.e. if the pump loop is failing, it's `openaps pump-loop`, which you can run to show what's inside it by `openaps alias show pump-loop`. 
 * Run each of those commands next individually, and that should give you a better idea of where it's failing or getting stuck. Do this, and share back (if needed) with your troubleshooter about where you think it's getting stuck.  If that still doesn't give you or your troubleshooter enough info, keep drilling down further:
   * **For example**, if your pump-loop.log always shows `Error, retrying` after `Old pumphistory:`, then you'd want to run `openaps refresh-old-pumphistory` manually to reproduce the problem and see if you can get more error details.
   * If necessary, you can drill down further.  So in this example, you might want to run `openaps alias show refresh-old-pumphistory` to see what *that* alias does, and then `openaps gather` to drill down further.
   * Don't use `2>/dev/null` or `>/dev/null ` parts of commands, because they will hide output of commands
   * If a command does not return output, check with `echo $?` if the exit code returns `0`. That means OK (no error). If it returns non-zero (e.g. `1`) then the command failed and you need to drill down further. 
   * You can keep drilling down until you get through all the aliases to the actual reports, which can be run manually using a command like `openaps report invoke monitor/status.json` to see the raw unfiltered output with full error details.
 * Still no luck? Try the [Troubleshooting](http://openaps.readthedocs.io/en/master/docs/Resources/troubleshooting.html) page or ask for help.

### 512 users / 712 users / x12 users

If you have one of the x12 model pumps, you need to do the following. Note there are TWO major steps, of creating the files and then adjusting aliases:
 * A. Add pump settings files manually. Certain commands like Read Settings, BG Targets and certain Read Basal Profile are not available, and requires creating a static json for needed info missing to successfully run the loop. You'll be creating raw-pump/settings.json, raw-pump/bg-targets-raw.json, and raw-pump/selected-basal-profile.json.
  * To do this, you will need to create the file location for the raw-pump settings.json file:
  * Make sure you are in your myopenaps directory.
  * Type `dir` to see the current list of files, you should see something like this: 
```
cgm                     meal.ini         oref0-runagain.sh  settings
cgm.ini                 mmtune_old.json  pebble.ini         tz.ini
detect-sensitivity.ini  monitor          preferences.json   units.ini
determine-basal.ini     ns-glucose.ini   pump.ini           upload
enact                   ns.ini           pump-session.json  xdrip.ini
get-profile.ini         openaps.ini      raw-cgm
iob.ini                 oref0.ini    
```
 * To create the file location for the settings.json file: `mkdir raw-pump`
 * Next, change the directory to the file you just created: `cd raw-pump`
 * (Confirm your command prompt looks like `root:~/myopenaps/raw-pump#`)
 * Now do: `nano settings.json`
 * This will open a text editor where you can add your raw pump settings.  You can use the examples further below for each file.
 * Suggestion - copy and paste the below files into some kind of editor (i.e. Word) and make changes to match your pump, first)
 * **WARNING**: Make sure you change the code below to match YOUR settings and what is on YOUR pump. Otherwise, it'll loop off of whatever you put it in, so this needs to be correct.
 * Paste the code, once personalized, into the text editor.
 * Hit escape to exit insert mode, if needed.
 * `Ctl-X`, and when it asks if you want to save, Yes, and keep the settings.json name
 * Repeat the steps above for also creating the following files: bg-targets-raw.json, and the selected-basal-profile.json.
 * Once complete, when you change directory (cd) to raw-pump and type dir and you should see the following files:
```
 settings.json     bg-targets-raw.json     selected-basal-profile.json
```
### Example files for 512/712 users:

#### Sample file for selected-basal-profile.json

Note:  The format for the basal rates is the "minutes" value refers to the "minutes from midnight" for whatever rate schedule you are setting.  For example, the 6:00 am rate in the example file below is a rate of 1.15 units/hour and 6:00 am is 360 minutes since midnight passed (6 hours x 60 minutes per hour).  

If you have a basal rate less than 1.0 unit/hour, make sure to include a zero before the decimal point such as `0.55`

You can add or delete basal rates to the sample file below, but pay close attention to syntax.  The last basal rate in the profile needs end without a comma after the last `}`

```
  [
  {
    "i": 0,
    "start": "00:00:00",
    "rate": 1.15,
    "minutes": 0
  },
  {
    "i": 1,
    "start": "02:30:00",
    "rate": 1.20,
    "minutes": 150
  },
  {
    "i": 2,
    "start": "06:00:00",
    "rate": 1.15,
    "minutes": 360
  },
  {
    "i": 3,
    "start": "09:00:00",
    "rate": 1.05,
    "minutes": 600
  },
  {
    "i": 4,
    "start": "11:30:00",
    "rate": 1.05,
    "minutes": 690
  },
  {
    "i": 5,
    "start": "14:00:00",
    "rate": 1.05,
    "minutes": 840
  },
  {
    "i": 6,
    "start": "18:30:00",
    "rate": 1.05,
    "minutes": 1110
  },
  {
    "i": 7,
    "start": "23:00:00",
    "rate": 1.05,
    "minutes": 1380
  }
  ]
```
#### Sample file for bg-targets-raw.json

Note: the "offset" is the same concept and calculation as "minutes" in the sample file below...it is the minutes since midnight for that particular target to start.

```
{
  "units": "mg/dL", 
  "targets": [
    {
      "high": 145, 
      "start": "00:00:00", 
      "low": 125, 
      "offset": 0, 
      "i": 0, 
      "x": 0
    }, 
    {
      "high": 145, 
      "start": "06:00:00", 
      "low": 125, 
      "offset": 360, 
      "i": 12, 
      "x": 1
    }, 
    {
      "high": 145, 
      "start": "20:00:00", 
      "low": 125, 
      "offset": 1200, 
      "i": 40, 
      "x": 2
    }
  ], 
  "first": 1
}
```

#### Sample Pump settings file for settings.json

notes are added with `#` on the lines you want to adjust or pay attention to in particular

```
{
  "low_reservoir_warn_point": 5, #adjust to your warning level of units remaining
  "keypad_lock_status": 0, 
  "maxBasal": 1,  #adjust to your preferred max temp basal
  "temp_basal": {
    "percent": 100, 
    "type": "Units/hour"
  }, 
  "low_reservoir_warn_type": 0, 
  "insulinConcentration": 100, 
  "audio_bolus_enable": false, 
  "variable_bolus_enable": true, 
  "alarm": {
    "volume": -1, 
    "mode": 1
  }, 
  "rf_enable": true,  #you will want this set to true or else your pump will not tune properly 
  "auto_off_duration_hrs": 0, 
  "block_enable": false, 
  "timeformat": 1, 
  "insulin_action_curve": 3, #adjust to your selected duration of insulin action in whole hour increments
  "audio_bolus_size": 0, 
  "selected_pattern": 0, 
  "patterns_enabled": true, 
  "maxBolus": 3.0,  #adjust to your preferred max single bolus units
  "paradigm_enabled": 1
}
```

* B. Adapt the aliases as following so it doesn't call for non-existing pump files:
  * First, copy and paste each of these three individually:
  
  ```
  cd ~/myopenaps && killall -g openaps
  openaps alias remove get-settings
  openaps alias add get-settings "report invoke settings/model.json settings/bg_targets.json settings/insulin_sensitivities_raw.json settings/insulin_sensitivities.json settings/carb_ratios.json settings/profile.json"
  ```
  
  * The 512 also does not have the ability to report bolusing so the “gather” alias also has to be adjusted. So also do these three lines individually, copying and pasting in:
```
  cd ~/myopenaps && killall -g openaps
  openaps alias remove gather
  openaps alias add gather '! bash -c "(openaps monitor-pump || openaps monitor-pump) 2>/dev/null >/dev/null && echo refreshed    pumphistory || (echo unable to refresh pumphistory; exit 1) 2>/dev/null"'
```

* C. Copy the files you created in the `raw-pump` directory into the settings directory

`cd ~/myopenaps && cp ./raw-pump/bg-targets-raw.json ./settings/ && cp ./raw-pump/selected-basal-profile.json ./settings/ && cp ./raw-pump/settings.json ./settings/`
