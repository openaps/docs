# Understanding autotune

## Safety reminders

Autotune is a WIP (work in progress) tool. Do not blindly make changes to your pump settings without careful consideration. You may want to print the output of this tool and discuss any particular changes with your care team. Make note that you probably do not want to make long-term changes based on short term (i.e. 24 hour) data. Most people will choose to make long term changes after reviewing carefully autotune output of 3-4 weeks worth of data.

## Example output from autotune

![Example output from autotune](https://diyps.org/wp-content/uploads/2017/01/OpenAPS-autotune-example-by-@DanaMLewis.png)

## What you'll see in autotune inputs and outputs

* You might wonder what CSF in the autotune results refers to: Carb Sensitivity Factor is the amount your blood sugar will rise for a given quantity of carbs consumed. And initial value for CSF is calculated from your ISF and carb:insulin ratio (CR), i.e., CSF = ISF / CR (e.g., for an ISF of 42mgDL/U and CR of 14g/U, CSF is 3mgDL/g.)  Subsequent autotune estimates for CSF are adjusted for the actual observed post-meal BG rise (relative to what would be expected based on insulin activity) compared to the number of carbs eaten.
* You might wonder what min_5m_carbimpact in profile.json refers to: It tells autotune how fast to decay carbs when your BG isn't rising. The default value means to assume 3mg/dL per 5m of carb absorption, even when your BG is falling or rising less than that. 
* If you only input one basal rate in the profile.json, it will only show one basal in the left hand column, and tune the day around that basal. You can go back and edit the profile.json (and cp again to make all files the same) with your multiple basal rates if you want to appropriately tune and most easily compare the output suggested against what your existing basal schedule is. 

## If you are DIY closed looping and looking at autotune:

#### With carbs logged in Nightscout
...you can look at everything that autotune outputs

#### Missing carb information in Nightscout
...you should only look at overnight basals, daytime basals that are not around typical meal times, and (with caution) ISF. Ignore carb ratio.


## If you are not DIY closed looping and are looking at autotune:

#### You have all boluses and carb treatments (even rescue, or low carbs) in Nightscout
...you can look at everything that autotune outputs

#### Without boluses and carb treatments in Nightscout
...don't use autotune until you log this data. 

#### If you don't have Nightscout

...it's probably easiest to set up [Nightscout](http://nightscout.info) and log some data in order to use autotune. This may change in the future (and let us know if you want to work on ways to bring other data types into autotune).




