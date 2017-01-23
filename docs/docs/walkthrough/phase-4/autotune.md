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

#### Phase A: Running Autotune in “manual” mode on the command line

Autotune is currently being tested by a few users on the command line. There has been some additional work to make it easier to export to Excel for review.

How to run it as a one-off:
* First, make sure you have dev branch: `cd ~/src/oref0 && git checkout dev && sudo npm run global-install`
* Install jq: `sudo apt-get install jq`
* Run `oref0-autotune --dir=~/myopenaps --ns-host=https://mynightscout.azurewebsites.net --start-date=YYYY-MM-DD` (obviously, sub in your NS url and the start date you want to start with. Try 1 day first before moving on to 1 week and 1 month to better troubleshoot).
* Make two copies of your profile.json, one to be the starting point for autotune, and one to provide the pump baseline for enforcing the 20-30% min/max limits: `cd ~/myopenaps/settings/ && cp profile.json autotune.json && cp profile.json pumpprofile.json`

If you have issues running it, questions about reviewing the data, or want to provide input for direction of the feature, please comment on [this issue in Github](https://github.com/openaps/oref0/issues/261).


#### Phase B: Running Autotune in OpenAPS closed loop system

Autotune is in the dev branch of OpenAPS, to test running autotune every night as part of a closed loop. This means that autotune would be iteratively running (as described in 261) and making changes to the underlying basals, ISF, and carb ratio being used by the loop. However, there are safety caps in place to limit the amount of tuning that can be done at any time – by 20%, compared to the underlying pump profile. It will be tracked against the pump profile, and if over time the tuning constantly is recommending 20% (or more) than what’s on the pump, people can use this to inform whether they may want to tune the basals and ratios in those directions.

If you're running dev branch, you can set up autotune as part of the setup scripts, and have it run nightly and adjust a new autotune profile.

As with all new and advanced features, this is a friendly reminder that this is DIY, not approved anywhere by anyone, and bears watching to see what it does with your numbers and to decide whether you want to keep running this feature over time, vs. running it as a one-off as needed to check tuning.

#### Phase C (WIP): Running Autotune more easily as an average user

We are actively working to make it easier for people to run autotune as a one-off analysis. Ideally, someone would run this report before their endo appointment and take these numbers in along with their other diabetes data to discuss any needed changes to basal rates, ISF, and potentially carb ratio. With the instructions below, you should be able to run this, even if you do not have a closed loop or regardless of what type of DIY closed loop you have. (OpenAPS/existing oref0 users may want to use the above instructions instead, however, from phase A or phase B on this page.) For more about autotune, you can read [Dana's autotune blog post for some background/additional detail](http://bit.ly/2jKvzQl). 

**Requirements**: You should have Nightscout BG and treatment data. If you do not regularly enter carbs (meals) into Nightscout, autotune will try to raise basals at those times of days to compensate. However, you could still look at overnight bassal recommendations and probably even ISF recommendations overall, though. 

**Note**: this is currently based on *one* ISF and carb ratio throughout the day at the moment. Here is the [issue](https://github.com/openaps/oref0/issues/326) if you want to keep track of the work to make autotune work with multiple ISF or carb ratios.

**Feedback**: Please note autotune is brand new, and still a work in progress (WIP). Please provide feedback along the way, or after you run it. You can share your thoughts in [Gitter](https://gitter.im/nightscout/intend-to-bolus), or via this short [Google form](https://goo.gl/forms/Cxbkt9H2z05F93Mg2). 

**Step 1: Create VM**
* You'll need a Linux machine to run Autotune for now, until Autotune is updated to [support Mac OS X](https://github.com/openaps/oref0/issues/327) or Windows.  If you don't already have access to a physical or virtual machine running Linux, you can either create a Linux VM locally using software like [VirtualBox](https://www.virtualbox.org/wiki/Downloads), or in the cloud with your favorite cloud service.
* For cloud servers, free options include [AWS](https://aws.amazon.com/free/) (free for 1 year) and [Google Cloud](https://cloud.google.com/free-trial/) (free trial for a year; about $5/mo after that).  If you're willing to pay up front, Digital Ocean is $5/mo and very fast to set up. AWS may take a day to spin up your account, so if you're in a hurry, one of the others might be a better option.
* We recommend some form of Debian distro (Ubuntu is the most common) for consistency with the Raspbian and jubilinux environments we use on the Pi and Edison for OpenAPS

**Step 2: Install oref0 on the cloud VM**
* A. After VM setup, do this: `curl -s https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-packages.sh | bash -`. If the install was successful, the last line will say something like: `openaps 0.1.5  (although the version number may have been incremented)`. If you do not see this or see error messages, try running it multiple times. It will not hurt to run this multiple times.
* B. Install the jq package: `sudo apt-get install jq`
* C. Pull/clone the latest oref0 dev branch by running: `mkdir -p ~/src; cd ~/src && git clone -b dev git://github.com/openaps/oref0.git || (cd oref0 && git checkout dev && git pull); cd`
* D. And install the oref0 dev branch: `cd ~/src/oref0 && git checkout dev && sudo npm run global-install` 

**Step 3: Create a profile.json with your settings**
* A. Create a myopenaps and settings directory. `mkdir -p ~/myopenaps/settings`
* B. Change into that directory: `cd ~/myopenaps/settings`.
* C. Create a profile file by typing `nano profile.json`. Copy and paste the example below, but input your information from your pump.  Change the basal profile times to match yours (updating minutes to match - minutes from midnight, not duration of basal), and add more entries if needed. Be sure that all of the } lines in basalprofile have a comma after them, *except* the last one.
```
{
  "min_5m_carbimpact": 3,
  "dia": your_dia,
  "basalprofile": [
    {
      "i": 0,
      "start": "00:00:00",
      "minutes": 0,
      "rate": your_basal
    },
    {
      "i": 1,
      "start": "08:00:00",
      "minutes": 480,
      "rate": your_basal
    },
    {
      "i": 2,
      "start": "13:00:00",
      "minutes": 780,
      "rate": your_basal
    },
    {
      "i": 3,
      "start": "21:00:00",
      "minutes": 1260,
      "rate": your_basal
    }
  ],
  "isfProfile": {
    "sensitivities": [
      {
        "i": 0,
        "start": "00:00:00",
        "sensitivity": your_isf,
        "offset": 0,
        "x": 0,
        "endOffset": 1440
      }
    ]
  },
  "carb_ratio": your_ic_ratio,
  "autosens_max": 1.2,
  "autosens_min": 0.7
}
```
* Make sure to adjust these settings to match yours:
  * dia - Duration of Insulin Action (DIA), in hours (e.g., 4.5, or 3). Usually determined by the type of insulin and its effectiveness on you.
  * basal profile - you need at least one basal rate in here. You can create multiple of these for all of your basal rates, which will give you an easier visual comparing your current basals to what autotune recommends (see visual example), but at a minimum you just need one here for autotune to run. But we recommend putting all or most of your basals in, in order for autotune to appropriately cap at the safety limits (and compare to 20% above or below your existing basals). If you do not put your full basal profile in, it will not compare to those with the safety cap because it does not know about it.
  * "sensitivity" should be your iSF - in mg/dL/U (if using mmol/L/U multiply by 18)
  * "carb_ratio" at the end should be your carb ratio

* Make sure to exit the profile.json when done editing this file - Control-X and hit yes to save.
* D. Verify your profile.json is valid json by running `jq . profile.json` - if it prints a colorful version of your profile.json, you're good to proceed.  If not, go back and edit your profile.json to fix the error.
* E. Create a pumpprofile.json that is the same as your settings.json. On the command line run: `cp profile.json pumpprofile.json`
* F. Create a third file from the command line by running: `cp profile.json autotune.json`

**Step 4: Run autotune on retrospective data from Nightscout**
* Run `oref0-autotune --dir=~/myopenaps --ns-host=https://mynightscout.azurewebsites.net --start-date=YYYY-MM-DD`
* ^ Sub in your Nightscout URL.
* Start with one day to confirm that it works, first. Then run it for one week, and then one month. Compare results and see if the numbers are consistent or changing, and see how that aligns with your gut feeling on whether your basals, ISF, and carb ratio was correct.
* Remember, this is currently based on *one* ISF and carb ratio throughout the day at the moment. Here is the [issue](https://github.com/openaps/oref0/issues/326) if you want to keep track of the work to make autotune work with multiple ISF or carb ratios.

#### Why Isn't It Working At All?

(First - breathe, and have patience! Remember this is a brand new tool that's in EARLY testing phases. Thanks for being an early tester...but don't panic if it doesn't work on your first try.) Here are some things to check: 

* Are you using xDrip as a data source or HAPP for treatments? If so, you need to run the autotune-mdi branch instead of the dev branch. Sub in autotune-mdi instead of dev in step 2-C and 2-D.
* Does your Nightscout have data? It definitely needs BG data, but you may also get odd results if you do not have treatment (carb, bolus) data logged. See [this page](./understanding-autotune.md) with what output you should get and pay attention to depending on data input.
* Did you pull too much data? Start with one day, and make sure it's a day where you had data in Nightscout. Work your way up to 1 week or 1 month of data. If you run into errors on a longer data pull, there may be something funky in Nightscout that's messing up the data format file and you'll want to exclude that date by picking a batch that does not include that particular date.
* Check your profile.json and make sure it really matches the example - chances are there's a stray character in there.
* Also check your pumpprofile.json and autotune.json - if it worked once or twice but then stopped working, it may have a bad file copy. If needed, follow Steps 3-E and 3-F again to re-copy a good profile.json to pumpprofile.json and autotune.json again.
* Still not working? Post a question in [Gitter](https://gitter.im/nightscout/intend-to-bolus). To best help you troubleshoot: Specify if you're on MDI or using a pump. Specify if you're using xDrip as a data source, or if you are otherwise logging data into Nightcout in a way that's not through Care Portal app directly, etc. 

#### What does this output from autotune mean? 
Go here to read more about [understanding the output, to see an example visual of what the output might look like, and scenarios when you may want to disregard portions of the output based on the data you provide it](./understanding-autotune.md).

Remember, autotune is still a work in progress (WIP). Please provide feedback along the way, or after you run it. You can share your thoughts in [Gitter](https://gitter.im/nightscout/intend-to-bolus), or via this short [Google form](https://goo.gl/forms/Cxbkt9H2z05F93Mg2). 

(If you have issues running it, questions about reviewing the data, or want to provide input for direction of the feature, please comment on [this issue in Github](https://github.com/openaps/oref0/issues/261).)

#### Yay, It Worked! This is Cool!

Great! We'd love to hear if it worked well, plus any additional feedback - please also provide input via this short [Google form](https://goo.gl/forms/Cxbkt9H2z05F93Mg2) and/or comment on [this issue in Github](https://github.com/openaps/oref0/issues/261) for more detailed feedback about the tool.



