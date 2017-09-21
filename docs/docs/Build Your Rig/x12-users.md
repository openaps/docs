# 512 and 712 Pump users

If you have one of the x12 model pumps, you can still successfully use OpenAPS for basic looping (but not some advanced featuers like SMB).  You'll need to complete some extra setup steps before your loop will be successful, however. There are TWO major steps; (1) creating the files and (2) adjusting aliases.  x12 users will have to be aware that the files will need to be manually updated anytime the pump user wants to change basal rate schedules, ISFs, or other pump settings.  

## Add pump files manually

Certain commands like Read Settings, BG Targets and certain Read Basal Profile are not available for x12 pumps.  Therefore, you will create new files (called static json files) for the missing information.  Specifically, you'll be creating three files called settings.json, bg_targets_raw.json, and selected_basal_profile.json.  To do this:
  
* Create a new subdirectory to your myopenaps directory.  We are going to name the subdirectory `raw-pump`.  After we create the new sub-directory, we will be changing into that newly created directory.  The following command will do all those things at once: `cd ~/myopenaps && mkdir raw-pump && cd raw-pump`  You can confirm the successful completion of this step by looking at your terminal prompt and it should show `root:~/myopenaps/raw-pump#`

* `nano settings.json` to create a new settings.json file by using the nano editor. This will open a text editor where you can add your pump settings.  Use the sample files below to copy and paste into the editor.  **WARNING**: Make sure you change the values within the sample files to match YOUR settings and what is on YOUR pump. The loop is going to use the content of these files, so this needs to be correct for safe looping.  Some hints are provided within the sample files to help you notice which items will need your personalized settings.

 * To finish and save the new file, press `Ctl-X`, and when it asks if you want to save `Y` for yes, and `return` to keep the settings.json name.
 
 * Repeat the steps above for also creating the following files (sample files for these are below, as well): bg_targets_raw.json and selected_basal_profile.json.
 
Once complete, type `ls` and you should see the following files:

```
 settings.json     bg_targets_raw.json     selected_basal_profile.json
```

* Finish our work with these files by copying them into the settings directory:

`cd ~/myopenaps && cp ./raw-pump/bg_targets_raw.json ./settings/ && cp ./raw-pump/selected_basal_profile.json ./settings/ && cp ./raw-pump/settings.json ./settings/`


### Sample file for settings.json

notes are added with `#` on the lines you want to adjust or pay attention to in particular

```
{
  "low_reservoir_warn_point": 5, #adjust to your warning level of units remaining
  "keypad_lock_status": 0, 
  "maxBasal": 1.5,  #adjust to your preferred max temp basal rate
  "temp_basal": {
    "percent": 100, #leave as-is
    "type": "Units/hour" #leave as-is
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

### Sample file for bg-targets-raw.json

Note: the "offset" entry is the minutes since midnight for that particular target to start.  The profile always starts with a midnight rate first, offset is 0.  The next BG target, in this example, starts at 6 am and therefore has an offset of 360 minutes (6 hours from midnight at 60 minutes per hour).  Target range can have the same bg value for high and low, if desired, but be careful not to have a high target set lower than the low target.

You can add or delete bg targets to the sample file below, but pay close attention to syntax.  The last bg target range in the profile needs end without a comma after the last `}`

```
{
  "units": "mg/dL", 
  "targets": [
    {
      "high": 120, 
      "start": "00:00:00", 
      "low": 110, 
      "offset": 0, 
      "i": 0, 
      "x": 0
    }, 
    {
      "high": 110, 
      "start": "06:00:00", 
      "low": 110, 
      "offset": 360, 
      "i": 12, 
      "x": 1
    }, 
    {
      "high": 120, 
      "start": "20:00:00", 
      "low": 110, 
      "offset": 1200, 
      "i": 40, 
      "x": 2
    }
  ], 
  "first": 1
}
```

### Sample file for selected-basal-profile.json

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

## Adapt the aliases 

The last steps are to edit the standard openaps aliases so they don't call for non-existing pump files

* First, copy and paste each of these three lines individually to adjust the "get-settings" alias:
  
  ```
  cd ~/myopenaps && killall -g openaps
  openaps alias remove get-settings
  openaps alias add get-settings "report invoke settings/model.json settings/bg_targets.json settings/insulin_sensitivities_raw.json settings/insulin_sensitivities.json settings/carb_ratios.json settings/profile.json"
  ```

## Updating your pump settings

If you need to make changes to the settings contained in your pump, specifically those covered by the three files you've created (basal rates, bg-targets, max temp basal rate, or insulin duration), then you will need to edit the files and update their contents in the settings directory.  For example, if you change your basal schedule or rates in the pump...simply editing them in the pump manually will not be enough to let OpenAPS know the basal profile has been altered.  You'll need to login to the rig, access the files and update the information manually in the files.  You can make the adjustments to the file(s) you created in the raw-pump subdirectory by using `cd ~/myopenaps/raw-pump`, then the same nano command(s), and then using the same file copy command to push the edited files into the settings directory.
