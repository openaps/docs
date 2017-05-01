# Autotune

Autotune is a feature/tool created in late December 2016 and is currently being tested within the community.  You can also see issue [#261](https://github.com/openaps/oref0/issues/261) and [#99](https://github.com/openaps/oref0/issues/99) and pull request [#313](https://github.com/openaps/oref0/pull/313) for background reading. Want to pay it forward and help improve autotune? You can see [the identified issues that are known to need volunteers to help tackle here](https://github.com/openaps/oref0/projects/1). Those who are not running autotune in a closed-loop setting should use the "Phase C" instructions below.

## The difference between autotune and autosens:

Autosensitivity/resistance mode (aka “autosens”) is an advanced feature you can enable that looks at 24 hours of data and makes adjustments to ISF and targets based on the resulting sensitivity calculations. If you have a dying pump site, or have been sick and are resistant, your ISF is likely to be calculated down by autosens and then used in OpenAPS calculations accordingly. The opposite for being more sensitive is true as well. [(Here’s a blog post describing autosensitivity during sick days.)](https://diyps.org/2016/12/01/sick-days-with-a-diy-closed-loop-openaps/)

Autotune, by contrast, is designed to iteratively adjust basals, ISF, and carb ratio over the course of weeks.  Because it makes changes more slowly than autosens, autotune ends up drawing on a larger pool of data, and is therefore able to differentiate whether and how basals and/or ISF need to be adjusted, and also whether carb ratio needs to be changed. Whereas we don’t recommend changing basals or ISF based on the output of autosens (because it’s only looking at 24h of data, and can't tell apart the effects of basals vs. the effect of ISF), autotune is intended to be used to help guide basal, ISF, *and* carb ratio changes because it’s tracking trends over a large period of time. See below for how it can be used as a manual one-off calculation or in a closed loop setting, along with notes about the safety caps designed to go with it.

## How Autotune works

There are two key pieces: oref0-autotune-prep and oref0-autotune-core. (For more autotune code, you can see [oref0-autotune-(multiple files) listed in oref0/bin here](https://github.com/openaps/oref0/tree/dev/bin) - and there are also some autotune files in [oref0/lib](https://github.com/openaps/oref0/tree/dev/lib). 

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
* Autotune limits how far it can adjust (or recommend adjustment, if running autotune outside oref0 closed loop) basal, or ISF or CSF, from what is in the existing pump profile.  Autotune uses the same autosens_max and autosens_min multipliers found in your preferences.json for oref0.  So if autotune is running as part of your loop, autotune can't get too far off without a chance for a human to review the changes.

### Different ways to utilize Autotune

#### Phase A: Running Autotune in “manual” mode on the command line

If you have an OpenAPS rig and want to test autoune manually, you can do so manually on the command line. There has been some additional work to make it easier to export to Excel for review.

How to run it as a one-off:
* First, make sure you have the latest version of oref0: `npm list -g oref0 | egrep oref0@0.4.[0-9] || (echo Installing latest oref0 package && sudo npm install -g oref0)`
* Install jq: `sudo apt-get install jq`
* Make two copies of your profile.json, one to be the starting point for autotune, and one to provide the pump baseline for enforcing the min/max limits: `cd ~/myopenaps/settings/ && cp profile.json autotune.json && cp profile.json pumpprofile.json`
* Run `oref0-autotune --dir=~/myopenaps --ns-host=https://mynightscout.azurewebsites.net --start-date=YYYY-MM-DD` (obviously, sub in your NS url and the start date you want to start with. Try 1 day first before moving on to 1 week and 1 month to better troubleshoot).

If you have issues running it, questions about reviewing the data, or want to provide input for direction of the feature, please comment on [this issue in Github](https://github.com/openaps/oref0/issues/261).


#### Phase B: Running Autotune in OpenAPS closed loop system

You can also test running autotune every night as part of a closed loop. This means that autotune would be iteratively running (as described in [#261](https://github.com/openaps/oref0/issues/261)) and making changes to the underlying basals, ISF, and carb ratio being used by the loop. However, there are safety caps (your autosens_max and autosens_min) in place to limit the amount of tuning that can be done at any time compared to the underlying pump profile. The autotune_recommendations will be tracked against the current pump profile, and if over time the tuning constantly is recommending changes beyond the caps, people can use this to inform whether they may want to tune the basals and ratios in those directions.

You can choose to set up autotune as part of the oref0-setup script, and have it run nightly and adjust a new autotune profile.  It is important to realize that when autotune is enabled in your loop to run automatically, changes to your basal profile within the pump during the middle of the day will NOT cause an immediate change to the basal profile the loop is using.  The loop will continue to use your autotune-generated profile until a new one is updated just after midnight each night.  Each autotune nightly run will pull the current pump profile as its baseline for being able to make adjustments.  If you have reason to want a want a mid-day change to your basal program immediately (e.g., steroid medication started), you may have to temporarily suspend autotune to allow loop to use your pump's adjusted basal program.  

As with all new and advanced features, this is a friendly reminder that this is DIY, not approved anywhere by anyone, and bears watching to see what it does with your numbers and to decide whether you want to keep running this feature over time, vs. running it as a one-off as needed to check tuning.

#### Phase C: Running Autotune more easily as an average user or as a "one-off"

If you are not running autotune as part of a closed loop, you can still run it as a "one-off". We are actively working to make it easier for people to run autotune as a one-off analysis. Ideally, someone can run this report before their endo appointment and take these numbers in along with their other diabetes data to discuss any needed changes to basal rates, ISF, and potentially carb ratio. With the instructions below, you should be able to run this, even if you do not have a closed loop or regardless of what type of DIY closed loop you have. (OpenAPS/existing oref0 users may want to use the above instructions instead, however, from phase A or phase B on this page.) For more about autotune, you can read [Dana's autotune blog post for some background/additional detail](http://bit.ly/2jKvzQl) and scroll up in the page to see more details about how autotune works.

**Requirements**: You should have Nightscout BG and treatment data. If you do not regularly enter carbs (meals) into Nightscout (this happens automatically when you use the "Bolus Wizard" on the Medtronic pump and should not be manually added to Nightscout if you use the Bolus Wizard), autotune will try to raise basals at those times of days to compensate. However, you could still look at overnight bassal recommendations and probably even ISF recommendations overall, though. [Read this page for more details on what you should/not pay attention to with missing data.](./understanding-autotune.md)

**Note**: this is currently based on *one* ISF and carb ratio throughout the day at the moment. Here is the [issue](https://github.com/openaps/oref0/issues/326) if you want to keep track of the work to make autotune work with multiple ISF or carb ratios.

**Feedback**: Please note autotune is brand new, and still a work in progress (WIP). Please provide feedback along the way, or after you run it. You can share your thoughts in [Gitter](https://gitter.im/openaps/autotune), or via this short [Google form](https://goo.gl/forms/Cxbkt9H2z05F93Mg2). 

**Paying it forward**: Want to pay it forward and help improve autotune? You can see [the identified issues that are known to need volunteers to help tackle here](https://github.com/openaps/oref0/projects/1). You can also create a pull request to help edit and improve this documentation. (See a "[my first PR guide](http://openaps.readthedocs.io/en/latest/docs/Resources/my-first-pr.html)" here if you haven't done a pull request before.)

**Step 0: Decide where to run Autotune**
* The easiest way to run autotune from a Windows machine if you are unfamiliar with programming will be to create a Linux VM. If you don't already have access to a physical or virtual machine running Linux, you can either create a Linux VM locally using software like [VirtualBox](https://www.virtualbox.org/wiki/Downloads), or in the cloud with your favorite cloud service.
* Mac users may simply run Autotune locally on their Mac, by skipping down to Step 1b below.

**Step 1a: Create a Linux VM**
 * To run a Linux VM on a cloud server, free options include [AWS](https://aws.amazon.com/free/) (free for 1 year) and [Google Cloud](https://cloud.google.com/free-trial/) (free trial for a year; about $5/mo after that).  If you're willing to pay up front, Digital Ocean is $5/mo and very fast to set up. AWS may take a day to spin up your account, so if you're in a hurry, one of the others might be a better option.
 * We recommend some form of Debian distro (Ubuntu is the most common) for consistency with the Raspbian and jubilinux environments we use on the Pi and Edison for OpenAPS
 * If you have no experience an easy way to start is the VirtualBox as VM and Ubuntu as Linux OS. Step-by-step setup instructions can be found here: https://www.youtube.com/watch?v=ncA85gRAJxk  
 * Make sure your VM is using the same timezone as your pump.  You can change timezone using `sudo dpkg-reconfigure tzdata`
 * If your VM is outside the US, particularly in a country that uses `,` as a decimal separator, make sure your system locale is set to `en_US.utf8` or another locale that uses `.` as the decimal separator.
 * If you're interacting with your VM via its graphical interface, make sure you have installed a browser at your VM (i.e.  Firefox) then open the currect page from your VM. You may think that copying from your Windows/iOS and pasting in your Linux terminal would work but is not as simple .. and yes, there is lots of copying / pasting!  To make copying and pasting simpler, it is often better to `ssh` directly to your VM, rather than using its graphical interface (or the cloud provider's console interface).
 * Now do this: `curl -s https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-packages.sh | bash -`. If the install was successful, the last line will say something like: `openaps 0.1.5  (although the version number may have been incremented)`. If you do not see this or see error messages, try running it multiple times. It will not hurt to run this multiple times.

**Step 1b: Prep your Mac**
* MAC USERS: Follow these steps instead of 1a above if you want to run autotune on your Mac. (Mac users can instead do the above instructions if they prefer to create a Linux virtual machine to run it on):
* To run AutoTune using a Mac you will use the Terminal application. Open the Terminal application on your Mac (it is located in the Utilities application folder on your Mac). For more information about using Terminal see: http://openaps.readthedocs.io/en/latest/docs/introduction/understand-this-guide.html#before-you-get-started
* After you open a Terminal window, copy and paste the command for each of the Mac install command steps below, and then hit the return key after you paste each command, which will execute it. If you are asked for a password, enter the password for your Mac.
* Tip for New Mac Users: If you typically use a Windows machine and you keep trying to do a control-c (copy) and control-v (paste), remember, on a Mac use command-c (copy) and command-v (paste) instead.
* For example, the first step is to install Homebrew on your Mac. To do this you need to copy and paste the following command from step 1.) of the Mac install commands below and then hit the return key:  `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

Mac install commands:

 * 1.) Install Homebrew: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
 * 2.) Install Coreutils: `brew install coreutils`
 * 3.) Install Node for (NPM): `brew install node`
 * 4.) Install JQ from Homebrew: `brew install jq` 
 
**Step 2: Install oref0**
* Install the latest version of oref0: `npm list -g oref0 | egrep oref0@0.4.[0-9] || (echo Installing latest oref0 package && sudo npm install -g oref0)`

**Step 3: Create a profile.json with your settings**
* A. Create a myopenaps and settings directory. `mkdir -p ~/myopenaps/settings`
* B. Change into that directory: `cd ~/myopenaps/settings`.
* C. Create a profile file by typing `nano profile.json`. Copy and paste the example below, but input your information from your pump.  Change the basal profile times to match yours (update the minutes to match your basal start time; the minutes are number of minutes from midnight to the start of basal, e.g., a basal starting at 5:00am will have a minutes entry of 5 x 60 = 300 minutes and a basal starting at 7:30am will have a minutes entry of 7.5 x 60 = 450 minutes), and add more entries if needed. Be sure that all of the } lines in basalprofile have a comma after them, *except* the last one.  You need to use a 0 before any entries with a decimal point, such as a basal rate of `0.35`; without the 0 before the decimal point, your autotune will have an error.  Every comma, quote mark, and bracket matter on this file, so please double-check carefully.
```
{
  "min_5m_carbimpact": 3,
  "dia": your_dia,
  "basalprofile": [
    {
      "start": "00:00:00",
      "minutes": 0,
      "rate": your_basal
    },
    {
      "start": "08:00:00",
      "minutes": 480,
      "rate": your_basal
    },
    {
      "start": "13:00:00",
      "minutes": 780,
      "rate": your_basal
    },
    {
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
* E. Create a pumpprofile.json that is the same as your profile.json. On the command line run: `cp profile.json pumpprofile.json`
* F. Create a third file from the command line by running: `cp profile.json autotune.json`

**Step 4: Run autotune on retrospective data from Nightscout**
* Run `oref0-autotune --dir=~/myopenaps --ns-host=https://mynightscout.azurewebsites.net --start-date=YYYY-MM-DD`
* ^ Sub in your Nightscout URL.
* Start with one day to confirm that it works, first. Then run it for one week, and then one month. Compare results and see if the numbers are consistent or changing, and see how that aligns with your gut feeling on whether your basals, ISF, and carb ratio was correct.
* If you want to run dates in the past, add the following: --end-date=YYYY-MM-DD (otherwise, it will just default to ending yesterday).
* Remember, this is currently based on *one* ISF and carb ratio throughout the day at the moment. Here is the [issue](https://github.com/openaps/oref0/issues/326) if you want to keep track of the work to make autotune work with multiple ISF or carb ratios.

#### Why Isn't It Working At All?

(First - breathe, and have patience! Remember this is a brand new tool that's in EARLY testing phases. Thanks for being an early tester...but don't panic if it doesn't work on your first try.) Here are some things to check: 

* Does your Nightscout have data? It definitely needs BG data, but you may also get odd results if you do not have treatment (carb, bolus) data logged. See [this page](./understanding-autotune.md) with what output you should get and pay attention to depending on data input.
* Did you pull too much data? Start with one day, and make sure it's a day where you had data in Nightscout. Work your way up to 1 week or 1 month of data. If you run into errors on a longer data pull, there may be something funky in Nightscout that's messing up the data format file and you'll want to exclude that date by picking a batch that does not include that particular date.
* Make sure when you sub in your Nightscout URL you do not include a "/" at the end of the URL
* Check your profile.json and make sure it really matches the example - chances are there's a stray character in there.
* Also check your pumpprofile.json and autotune.json - if it worked once or twice but then stopped working, it may have a bad file copy. If needed, follow Steps 3-E and 3-F again to re-copy a good profile.json to pumpprofile.json and autotune.json again.
* If VM is already set up, and you are returning to your VM for another session of autotune, double-check that your VM timezone matches your pump: `sudo dpkg-reconfigure tzdata` 
* Invalid calculations may be due to the locale settings of your VM (correct settings are `en_US.utf-8` or another locale that uses `.` as the decimal separator). An easy way to overcome such a problem is to add `env LANG=en_US.UTF-8` in front of your command for running autotune, it should look like this: `env LANG=en_US.UTF-8 oref0-autotune --dir=~/myopenaps --ns-host=https://mynightscout.azurewebsites.net --start-date=YYYY-MM-DD`
* Did you turn on Nightscout authentication with the setting `AUTH_DEFAULT_ROLES`?  Currently Autotune will only work with the `readable` setting.  See [issue #397](https://github.com/openaps/oref0/issues/397) in Github.
* Still not working? Post a question in [Gitter](https://gitter.im/openaps/autotune). To best help you troubleshoot: Specify if you're on MDI or using a pump. Specify if you're using xDrip as a data source, or if you are otherwise logging data into Nightscout in a way that's not through Care Portal app directly, etc. 

#### What does this output from autotune mean? 
Go here to read more about [understanding the output, to see an example visual of what the output might look like, and scenarios when you may want to disregard portions of the output based on the data you provide it](./understanding-autotune.md).

Remember, autotune is still a work in progress (WIP). Please provide feedback along the way, or after you run it. You can share your thoughts in [Gitter](https://gitter.im/openaps/autotune), or via this short [Google form](https://goo.gl/forms/Cxbkt9H2z05F93Mg2). 

(If you have issues running it, questions about reviewing the data, or want to provide input for direction of the feature, please comment on [this issue in Github](https://github.com/openaps/oref0/issues/261).)

#### Yay, It Worked! This is Cool!

Great! We'd love to hear if it worked well, plus any additional feedback - please also provide input via this short [Google form](https://goo.gl/forms/Cxbkt9H2z05F93Mg2) and/or comment on [this issue in Github](https://github.com/openaps/oref0/issues/261) for more detailed feedback about the tool. You can also help us tackle some of the known issues and feature requests listed [here](./understanding-autotune.md).
