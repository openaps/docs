# WIP Autotune Feature

Autotune is a feature created in late December 2016 and is currently in beta (early testing) mode in the oref0 dev branch.  You can also see issue [#261](https://github.com/openaps/oref0/issues/261) and [#99](https://github.com/openaps/oref0/issues/99) and pull request [#313](https://github.com/openaps/oref0/pull/313) for background reading.

## The difference between autotune and autosens:

Autosensitivity/resistance mode (aka “autosens”) is an advanced feature you can enable that looks at 24 hours of data and makes adjustments to ISF and targets based on the resulting sensitivity calculations. If you have a dying pump site, or have been sick and are resistant, your ISF is likely to be calculated down by autosens and then used in OpenAPS calculations accordingly. The opposite for being more sensitive is true as well. (Here’s a blog post describing autosensitivity during sick days.)

Auto"tune", by contrast, is designed to iteratively adjust basals, ISF, and carb ratio over the course of weeks.  Because it makes changes more slowly than autosens, autotune ends up drawing on a larger pool of data, and is therefore able to differentiate whether and how basals and/or ISF need to be adjusted, and also whether carb ratio needs to be changed. Whereas we don’t recommend changing basals or ISF based on the output of autosens (because it’s only looking at 24h of data, and can't tell apart the effects of basals vs. the effect of ISF), autotune is intended to be used to help guide basal, ISF, *and* carb ratio changes because it’s tracking trends over a large period of time. See below for how it can be used as a manual one-off calculation or in a closed loop setting, along with notes about the safety caps designed to go with it.

## How Autotune works

There are two key pieces: oref0-autotune-prep and oref0-autotune-core

**1. oref0-autotune-prep:**

* autotune-prep takes three things initially: glucose data; treatments data; and starting profile (originally from pump; afterwards autotune will set a profile)
* It calculates BGI and deviation for each glucose value based on treatments
* Then, it categorizes each glucose value as attributable to either carb sensitivity factor (CSF), ISF, or basals
* To determine if a "datum" is attributable to CSF, carbs on board (COB) are calculated and decayed over time based on observed BGI deviations, using the same algorithm used by Advanced Meal Assist. Glucose values after carb entry are attributed to CSF until COB = 0 and BGI deviation <= 0. Subsequent data is attributed as ISF or basals.
* If BGI is positive (meaning insulin activity is negative), BGI is smaller than 1/4 of basal BGI, or average delta is positive, that data is attributed to basals.
* Otherwise, the data is attributed to ISF.
* All this data is output to a single file with 3 sections: ISF, CSF, and basals.

**2. oref0-autotune-core:**

* autotune-core reads the prepped glucose file with 3 sections. It calculates what adjustments should be made to ISF, CSF, and basals accordingly.
* For basals, it divides the day into hour long increments. It calculates the total deviations for that hour increment and calculates what change in basal would be required to adjust those deviations to 0. It then applies 20% of that change needed to the three hours prior (because of insulin impact time). If increasing basal, it increases each of the 3 hour increments by the same amount. If decreasing basal, it does so proportionally, so the biggest basal is reduced the most.
* For ISF, it calculates the 50th percentile (median) deviation for the entire day and determines how much ISF would need to change to get that deviation to 0. It applies 10% of that as an adjustment to ISF.
* For CSF, it calculates the total deviations over all of the day's mealtimes and compares to the deviations that are expected based on existing CSF and the known amount of carbs entered, and applies 10% of that adjustment to CSF.
* Autotune applies a 20% limit on how much a given basal, or ISF or CSF, can vary from what is in the existing pump profile, so that if it's running as part of your loop, autotune can't get too far off without a chance for a human to review the changes.
* (FUTURE TODO: Instead of 20% hardcoded safety cap, use autosens min and max ratios.)

### Different ways to utilize Autotune

#### Phase A (Current): Running Autotune in “manual” mode on the command line

Autotune is currently being tested by a few users on the command line. There has been some additional work to make it easier to export to Excel for review.

How to run it:

Run `oref0-autotune <--dir=myopenaps_directory> <--ns-host=https://mynightscout.azurewebsites.net> [--start-date=YYYY-MM-DD] [--end-date=YYYY-MM-DD] [--runs=number_of_runs] [--xlsx=autotune.xlsx]`

If you're running this on a computer that doesn't have a myopenaps_directory, you can point it at a directory with a settings/pumpprofile.json file.  An example of one (note: do NOT use this as-is; put your actual settings in) would be:
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

If you have issues running it, questions about reviewing the data, or want to provide input for direction of the feature, please comment on [this issue in Github](https://github.com/openaps/oref0/issues/261).


#### Phase B: Running Autotune in OpenAPS closed loop system

Autotune is in the dev branch of OpenAPS, to test running autotune every night as part of a closed loop. This means that autotune would be iteratively running (as described in 261) and making changes to the underlying basals, ISF, and carb ratio being used by the loop. However, there are safety caps in place to limit the amount of tuning that can be done at any time – by 20%, compared to the underlying pump profile. It will be tracked against the pump profile, and if over time the tuning constantly is recommending 20% (or more) than what’s on the pump, people can use this to inform whether they may want to tune the basals and ratios in those directions.

If you're running dev branch, you can set up autotune as part of the setup scripts, and have it run nightly and adjust a new autotune profile.

As with all new and advanced features, this is a friendly reminder that this is DIY, not approved anywhere by anyone, and bears watching to see what it does with your numbers and to decide whether you want to keep running this feature over time, vs. running it as a one-off as needed to check tuning.

#### Phase C (future/current WIP): Running Autotune more easily as an average user

Future work is planned, after further development on the algorithm and all relevant safety components, to make it easier for people to run this as a one-off analysis. Ideally, someone would run this report before their endo appointment and take these numbers in along with their other diabetes data to discuss any needed changes to basal rates, ISF, and potentially carb ratio.

Step 1: Create VM
* You'll need a Linux VM for now, until Autotune is updated to [support Mac OS X](https://github.com/openaps/oref0/issues/327) or Windows.  You can either create a Linux VM locally using software like [VirtualBox](https://www.virtualbox.org/wiki/Downloads), or in the cloud with your favorite cloud service.
* For cloud servers, free options include [AWS](https://aws.amazon.com/free/) (free for 1 year) and [Google Cloud](https://cloud.google.com/free-trial/) (free trial for a year; about $5/mo after that).  If you're willing to pay up front, Digital Ocean is $5/mo and very fast to set up. AWS may take a day to spin up your account, so if you're in a hurry, one of the others might be a better option.
* We recommend some form of Debian distro (Ubuntu is the most common) for consistency with the Raspbian and jubilinux environments we use on the Pi and Edison for OpenAPS

Step 2: Install oref0 on the cloud VM
* After VM setup, to install oref0, follow (http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-2/oref0-setup.html ) to do Step 0 and Step 1.
* After install oref0 dependencies, you'll need to install the oref0 dev branch. at this stage `cd ~/src/oref0` and `git checkout dev` and `npm run global-install` might be the easiest way to do that. (Copy and paste and run those three commands)

Step 3: Create a profile.json with your settings
* See (way) above for an example of a profile.json - create one (`nano profile.json`) and have it full of your profile information that is on your pump.

Step 4: Run autotune on retrospective data from Nightscout
