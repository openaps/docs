# WIP Autotune Feature

Autotune was a feature created in late December 2016 and is currently in alpha (early, early testing) mode. This is the first WIP documents. You can also see issue [#261](https://github.com/openaps/oref0/issues/261) and [#99](https://github.com/openaps/oref0/issues/99) for background reading. 

## The different between autotune and autosens:

Autosensitivity/resistance mode (aka “autosens”) is an advanced feature you can enable that looks at 24 hours of data and makes adjustments to ISF and targets based on the resulting sensitivity calculations. If you have a dying pump site, or have been sick and are resistant, your ISF is likely to be calculated down by autosens and then used in OpenAPS calculations accordingly. The opposite for being more sensitive is true as well. (Here’s a blog post describing autosensitivity during sick days.)

Auto”tune” is different because it is drawing on a larger pool of data, and it’s focused on analyzing data as it is attributable to basals and carb ratio, in addition to analyzing ISF. Whereas we don’t recommend changing basals or ISF based on the output of autosens (because it’s only looking at 24h of data), autotune is intended to be used to help guide basal, ISF, and carb ratio changes because it’s tracking trends over a large period of time. See below for how it can be used as a manual one-off calculation or in a closed loop setting; along with notes about the safety caps designed to go with it. 

## How Autotune works

There are two key pieces: autotune-prep and autotune.js

**1. Autotune-prep:**

* Autotune-prep takes three things initially: glucose data; treatments data; and starting profile (originally from pump; afterwards autotune will set a profile)
* It calculates BGI and deviation for each glucose value based on treatments
* Then, categorizes each glucose value as attributable to either CSF, ISF, or basals
* To determine if a "datum" is attributable to CSF, it calculates COB until carbs are observed as absorbed and carb absorption has stopped (COB=0). If COB is 0 but all deviations since hitting COB=0 are positive, those deviations are attributed to CSF. Once deviations are negative after COB=0, subsequent data is attributed as ISF or basals.
* To determine if it is attributable to ISF, autotune-prep looks at whether BGI is negative and greater than one quarter of basal BGI.
* Otherwise, the remaining situations (BGI positive (meaning insulin activity is negative); or BGI is smaller than 1/4 of basal BGI) mean the data is attributed to basals
* Exception: if something would be attributed to ISF but average delta is positive, then that can't be ISF because ISF is activity that is pushing BG down so we attribute it to basals being off if you are rising for no reason. (This will be a future TODO area of improvement to detect non-entered carbs rather than solely attributing to basals).
* All this data is outputs to a single file with 3 sections: ISF, CSF, and basals.

**2. Autotune.js:**

* Autotune.js reads the prepped glucose file with 3 sections. It calculates what adjustments should be made to ISF, CSF, and basals accordingly.
* For basals, it divides the day into hour long increments. It calculates the total deviations for that hour increment and calculates what change in basal would be required to adjust those deviations to 0. It then applies 20% of that change needed to the three hours prior (because of insulin impact time). If increasing basal, increases evenly across all 3 hour increments. If decreasing basal, it does so proportionally, so the biggest basal is reduced the most.
* For ISF, it calculates the 50th percentile (mean) deviation for the entire day and determines how much ISF would need to change to get that deviation to 0. It applies 20% of that as an adjustment to ISF.
* For CSF, it calculates the total deviations over all mealtimes and compares to the deviations that are expected based on existing CSF and the known amount of carbs entered. (TODO: simplify by calculating total carbs entered for day instead of allocating to individual meals)
* Autotune.js applies a 20% limit on all 3 variables if you provide the existing pump profile, to prevent autotune from getting more than 20% off in either direction.
* (FUTURE TODO: Instead of 20% hardcoded safety cap, use autosens min and max ratios.)

### Different ways to utilize Autotune

#### Phase A (Current): Running Autotune in “manual” mode on the command line

Autotune is currently being tested by a few users on the command line. There has been some additional work to make it easier to export to Excel for review.

How to run it:

Collect data:
```
curl "$NIGHTSCOUT_HOST/api/v1/treatments.json?find\[created_at\]\[\$gte\]=`date -d 2016-12-01 -Iminutes`" > ns-treatments.json

for i in `seq 2 25`; do j=$((i+1)); curl "$NIGHTSCOUT_HOST/api/v1/entries/sgv.json?find\[date\]\[\$gte\]=`(date -d 2016-12-$i +%s | tr -d '\n'; echo 000)`&find\[date\]\[\$lte\]=`(date -d 2016-12-$j +%s | tr -d '\n'; echo 000)`&count=1000" > ~/ns-entries.2016-12-$i.json; done
```
Set up testprofile.json.  My too-sensitive one looked like:
```
{
  "max_iob": 4,
  "type": "current",
  "max_daily_safety_multiplier": 4,
  "current_basal_safety_multiplier": 4,
  "autosens_max": 1.2,
  "autosens_min": 0.7,
  "autosens_adjust_targets": true,
  "override_high_target_with_low": false,
  "bolussnooze_dia_divisor": 2,
  "min_5m_carbimpact": 3,
  "carbratio_adjustmentratio": 1,
  "dia": 3,
  "model": {},
  "current_basal": 1,
  "basalprofile": [
    {
      "i": 0,
      "start": "00:00:00",
      "rate": 0.1,
      "minutes": 0
    }
  ],
  "max_daily_basal": 0.1,
  "max_basal": 4,
  "min_bg": 100,
  "max_bg": 100,
  "sens": 100,
  "isfProfile": {
    "units": "mg/dL",
    "sensitivities": [
      {
        "i": 0,
        "start": "00:00:00",
        "sensitivity": 100,
        "offset": 0,
        "x": 0,
        "endOffset": 1440
      }
    ],
    "first": 1
  },
  "carb_ratio": 1000
}
```
Run test (overnight):
```
rm profile.[1-9].json; cp testprofile.json profile.json; for run in `seq 1 9`; do cp profile.json profile.$run.json; for i in `seq 2 24`; do ~/src/oref0/bin/oref0-autotune-prep.js ns-treatments.json profile.json ns-entries.2016-12-$i.json > autotune.2016-12-$i.json; ~/src/oref0/bin/oref0-autotune.js autotune.2016-12-$i.json profile.json > newprofile.2016-12-$i.json; cp newprofile.2016-12-$i.json profile.json; done; done
```

Display results (in another tab while test is running):
```
while(true); do (for type in csf carb_ratio isfProfile.sensitivities[0].sensitivity; do ( echo $type | awk -F \. '{print $1}'; for i in `seq 1 9`; do cat profile.$i.json | json $type; done; cat profile.json | json $type) | while read line; do echo -n "$line "; done; echo;  done; for j in `seq 0 23`; do ( echo $j; for i in `seq 1 9`; do cat profile.$i.json | json basalprofile[$j].rate ; done; cat profile.json | json basalprofile[$j].rate ) | while read line; do echo -n "$line "; done; echo;  done ) 2>/dev/null | column -t; date; done
```

If you have issues running it, questions about reviewing the data, or want to provide input for direction of the feature, please comment on [this issue in Github](https://github.com/openaps/oref0/issues/261). 


#### Phase B (pending): Running Autotune in OpenAPS closed loop system 

Autotune is pending a PR into the dev branch of OpenAPS, to test running autotune every night as part of a closed loop. This means that autotune would be iteratively running (as described in 261) and making changes to the underlying basals, ISF, and carb ratio being used by the loop. However, there are safety caps in place to limit the amount of tuning that can be done at any time – by 20%, compared to the underlying pump profile. It will be tracked against the pump profile, and if over time the tuning constantly is recommending 20% (or more) than what’s on the pump, people can use this to inform whether they may want to tune the basals and ratios in those directions. 

Via the autotune branch, or once in dev, you can set up autotune as part of the setup scripts, and have it run nightly and adjust a new autotune profile. 

As with all new and advanced features, this is a friendly reminder that this is DIY, not approved anywhere by anyone, and bears watching to see what it does with your numbers and to decide whether you want to keep running this feature over time, vs. running it as a one-off as needed to check tuning. 

#### Phase C (future): Running Autotune more easily as an average user

Future work is planned, after further development on the algorithm and all relevant safety components, to make it easier for people to run this as a one-off analysis. Ideally, someone would run this report before their endo appointment and take these numbers in along with their other diabetes data to discuss any needed changes to basal rates, ISF, and potentially carb ratio. 
