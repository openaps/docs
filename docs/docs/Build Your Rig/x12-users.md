# 512 and 712 Pump users

If you have one of the x12 model pumps, you can still successfully use OpenAPS for basic looping (but not some advanced featuers like SMB).  You'll need to complete some extra setup tweaks before your loop will be successful, however.

Note: If you have an old rig running oref0 0.5.3 or below, you'll need to follow historical instructions. The instructions below reflect the adjusted oref0-setup.sh in 0.6.0 and beyond, that does some of this work manually.

## Most important step - make sure you said yes (y) in oref0-setup.sh 

During the interactive setup script, one early question is about whether you have an x12 pump. This means you, if you have a 512 or 712 pump you're setting up. Make sure to type Y or y and see the confirmation that you'll be using an x12 pump.

## Edit the three (3) necessary files: basal, settings, and targets

At the end of the oref0-setup.sh script, it will open the most important file for you to edit - your basal profile. Edit this file to match your preferred basal rates and timing. 

```
Note: The "minutes" is "minutes from midnight". e.g., a basal starting at 5:00am 
will have a minutes entry of 5 x 60 = 300 minutes and a basal starting at 7:30am 
will have a minutes entry of 7.5 x 60 = 450 minutes. 
If you have a basal rate less than 1.0 unit/hour, 
make sure to include a zero before the decimal point such as `0.55`
```

After you ctrl-x and hit "y" to save the file, you'll also see a reminder to further adjust other files with your settings in order to loop off of your information. 

* If you need to edit your basal rate file in the future, simply type `nano ~/myopenaps/settings/basal_profile.json` from the command line.

To edit and set your maxBasal or your DIA:
* `nano ~/myopenaps/settings/settings.json`

Finally, to set your targets:
* `nano ~/myopenaps/settings/bg_targets_raw.json`


### Examples of the three file types

To see examples of each of these three files, see below.

#### Sample file for settings.json

notes are added with `#` on the lines you want to adjust or pay attention to in particular

```
{
  "maxBasal": 1.5,  #adjust to your preferred max temp basal rate
  "temp_basal": {
    "percent": 100,
    "type": "Units/hour"
  }, 
  "insulin_action_curve": 6 #adjust to your selected duration of insulin action in whole hour increments
}
```

#### Sample file for bg-targets-raw.json

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
