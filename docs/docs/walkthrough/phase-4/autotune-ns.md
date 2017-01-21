# Using Autotune without OpenAPS

[Autotune](autotune) is a feature created in late December 2016 and is currently in beta (early testing) mode in the oref0 dev branch.  You can also see issue [#261](https://github.com/openaps/oref0/issues/261) and [#99](https://github.com/openaps/oref0/issues/99) and pull request [#313](https://github.com/openaps/oref0/pull/313) for background reading.


This page is currently a stub, copied from the main [Autotune](autotune) page.  Please update it with the steps required to spin up a new cloud VM, install oref0 there, create a profile (documented below), and run autotune on retrospective data from NS.



#### Phase A (Current): Running Autotune in “manual” mode on the command line

Autotune is currently being tested by a few users on the command line. There has been some additional work to make it easier to export to Excel for review.

How to run it:

Run `oref0-autotune <--dir=myopenaps_directory> <--ns-host=https://mynightscout.azurewebsites.net> [--start-date=YYYY-MM-DD] [--end-date=YYYY-MM-DD] [--runs=number_of_runs] [--xlsx=autotune.xlsx]`

If you're running this on a computer that doesn't have a myopenaps_directory, you can point it at a directory with a settings/pumpprofile.json file.  An example of a too-sensitive one would be:
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
