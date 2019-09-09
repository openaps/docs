# Autotune

Autotune is a tool to help calculate potential adjustments to ISF, carb ratio, and basal rates. 

This page describes how Autotune works. For information on how to run it, please see [Running autotune](<../Usage and maintenance/running-autotune>).

## The difference between autotune and autosens

[Autosensitivity/resistance mode (aka “autosens”)](<./autosens>) is a feature in OpenAPS that looks at 24 hours of data and makes adjustments to ISF and targets based on the resulting sensitivity calculations. If you have a dying pump site, or have been sick and are resistant, your ISF is likely to be calculated down by autosens and then used in OpenAPS calculations accordingly. The opposite for being more sensitive is true as well. [(Here’s a blog post describing autosensitivity during sick days.)](https://diyps.org/2016/12/01/sick-days-with-a-diy-closed-loop-openaps/)

Autotune, by contrast, is designed to iteratively adjust basals, ISF, and carb ratio over the course of weeks.  Because it makes changes more slowly than autosens, autotune ends up drawing on a larger pool of data, and is therefore able to differentiate whether and how basals and/or ISF need to be adjusted, and also whether carb ratio needs to be changed. Whereas we don’t recommend changing basals or ISF based on the output of autosens (because it’s only looking at 24h of data, and can't tell apart the effects of basals vs. the effect of ISF), autotune is intended to be used to help guide basal, ISF, *and* carb ratio changes because it’s tracking trends over a large period of time.

## How Autotune works

There are two key pieces: oref0-autotune-prep and oref0-autotune-core. (For more autotune code, you can see [oref0-autotune-(multiple files) listed in oref0/bin here](https://github.com/openaps/oref0/tree/dev/bin) - and there are also some autotune files in [oref0/lib](https://github.com/openaps/oref0/tree/dev/lib). 

### 1. oref0-autotune-prep:
 
* autotune-prep takes three things initially: glucose data; treatments data; and starting profile (originally from pump; afterwards autotune will set a profile)
* It calculates BGI and deviation for each glucose value based on treatments
* Then, it categorizes each glucose value as attributable to either carb sensitivity factor (CSF), ISF, or basals
* To determine if a "datum" is attributable to CSF, carbs on board (COB) are calculated and decayed over time based on observed BGI deviations, using the same algorithm used by Advanced Meal Assist. Glucose values after carb entry are attributed to CSF until COB = 0 and BGI deviation <= 0. Subsequent data is attributed as ISF or basals.
* If BGI is positive (meaning insulin activity is negative), BGI is smaller than 1/4 of basal BGI, or average delta is positive, that data is attributed to basals.
* Otherwise, the data is attributed to ISF.
* All this data is output to a single file with 3 sections: ISF, CSF, and basals.

### 2. oref0-autotune-core
 
* autotune-core reads the prepped glucose file with 3 sections. It calculates what adjustments should be made to ISF, CSF, and basals accordingly.
* For basals, it divides the day into hour long increments. It calculates the total deviations for that hour increment and calculates what change in basal would be required to adjust those deviations to 0. It then applies 20% of that change needed to the three hours prior (because of insulin impact time). If increasing basal, it increases each of the 3 hour increments by the same amount. If decreasing basal, it does so proportionally, so the biggest basal is reduced the most.
* For ISF, it calculates the 50th percentile (median) deviation for the entire day and determines how much ISF would need to change to get that deviation to 0. It applies 10% of that as an adjustment to ISF.
* For CSF, it calculates the total deviations over all of the day's mealtimes and compares to the deviations that are expected based on existing CSF and the known amount of carbs entered, and applies 10% of that adjustment to CSF.
* Autotune limits how far it can adjust (or recommend adjustment, if running autotune outside oref0 closed loop) basal, or ISF or CSF, from what is in the existing pump profile.  Autotune uses the same `autosens_max` and `autosens_min` multipliers found in your preferences.json for oref0.  So if autotune is running as part of your loop, autotune can't get too far off without a chance for a human to review the changes.

*Note: Autotune does not read from the active profile (e.g. Pattern A or Pattern B if set). The Standard Basal Pattern is what will be pulled to be used and tuned by Autotune.*  
 
## Understanding autotune output

### Safety reminders

Autotune is a WIP (work in progress) tool. Do not blindly make changes to your pump settings without careful consideration. You may want to print the output of this tool and discuss any particular changes with your care team. Make note that you probably do not want to make long-term changes based on short term (e.g. 24 hour) data. Most people will choose to make long term changes after reviewing carefully autotune output of 3-4 weeks worth of data.

### Example output from autotune

![Example output from autotune](https://diyps.org/wp-content/uploads/2017/01/OpenAPS-autotune-example-by-@DanaMLewis.png)

### What you'll see in autotune inputs and outputs

* You might wonder what CSF in the autotune results refers to: Carb Sensitivity Factor is the amount your blood sugar will rise for a given quantity of carbs consumed. An initial value for CSF is calculated from your ISF and carb:insulin ratio (CR), i.e., CSF = ISF / CR (e.g., for an ISF of 42(mg/dL)/U and CR of 14g/U, CSF is 3(mg/dL)/g.)  Subsequent autotune estimates for CSF are adjusted for the actual observed post-meal BG rise (relative to what would be expected based on insulin activity) compared to the number of carbs eaten.
* You might wonder what `min_5m_carbimpact` in profile.json refers to: It tells autotune how fast to decay carbs when your BG isn't rising. The default value means to assume 8mg/dL per 5m of carb absorption, even when your BG is falling or rising less than that. 
* If you only input one basal rate in the profile.json, it will only show one basal in the left hand column, and tune the day around that basal. You can go back and edit the profile.json (and cp again to make all files the same) with your multiple basal rates if you want to appropriately tune and most easily compare the output suggested against what your existing basal schedule is. 

### If you are DIY closed looping and looking at autotune:

#### With carbs logged in Nightscout
...you can look at everything that autotune outputs

#### Without carb information in Nightscout
...you should only look at overnight basals, daytime basals that are not around typical meal times, and (with caution) ISF. Ignore carb ratio.


### If you are not DIY closed looping and are looking at autotune:

#### With all boluses and carb treatments (even rescue, or low carbs) in Nightscout
...you can look at everything that autotune outputs

#### Without boluses and carb treatments in Nightscout
...don't use autotune until you log this data. 

#### If you don't have Nightscout

...it's probably easiest to set up [Nightscout](http://nightscout.info) and log some data in order to use autotune. This may change in the future (and let us know if you want to work on ways to bring other data types into autotune).