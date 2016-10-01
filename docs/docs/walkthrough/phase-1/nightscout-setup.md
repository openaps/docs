# Visualization and Monitoring

## Nightscout Introduction

[Nightscout](http://nightscout.info) in their own words: Nightscout (CGM in the
Cloud) is an open source, DIY project that allows real time access to a CGM data
via personal website, smartwatch viewers, or apps and widgets available for
smartphones.

It basically allows a user to upload CGM data from a variety of sources, to an
online database and cloud computing service. The information is then processed
and displayed visually as a graph. There are plugins that allow greater
information to be shown about OpenAPS too. As the data is uploaded to an online
website and then retrieved by OpenAPS it allows OpenAPS a wider range of
compatibility with various CGM solutions.

[Nightscout](http://nightscout.info) is the recommended way to visualize your
OpenAPS closed loop. Even if you don't choose to share your Nightscout instance
with another person, it will be helpful for you to visualize what the loop is
doing; what it's been doing; plus generate helpful reports for understanding
your data and also allowing you to customize watchfaces with your OpenAPS data.
This provides a visual alternative to SSHing into your Raspberry Pi or loop
system and looking through log files.

At this point it is recommended that you go to the
[Nightscout](http://nightscout.info) website and set Nightscout up. They have
excellent guides of how to get various CGM systems working as well as displaying
your data on a variety of additional devices. Once your website is up and
running you can integrate Nightscout to your OpenAPS using the guide below.

If you plan to use Nightscout to vizualize a production OpenAPS instance, we
recommend using the $7/mo Heroku plans, as OpenAPS' can reach the usage limits of 
the free Azure plan and cause it to shut down for hours or days.

## Nightscout Integration

The integration requires setting up Nightscout and making changes and additions
to your OpenAPS implementation.

### Nightscout Setup

OpenAPS requires the latest (currently dev) version of Nightscout, which can be
found [here](https://github.com/nightscout/cgm-remote-monitor/tree/dev). If you
are already using Nightscout you might have to update your repository. To update
your version, go to the
[Beta Test tool](http://nightscout.github.io/pages/test-beta/?branch=dev), look
for the "I'm ready" button, and create a PR to your dev branch. Once you have
completed these steps, log on to Heroku or Azure and disconnect the deployment
source. Thereafter choose your cgm-remote-monitor github repository as source
again. You should take the dev branch of this repository. The dev branch will
also allow you to use the advanced-meal-assist feature.
_________________________
**If this doesn't work then from the command prompt in terminal run the
following:

```
git clone -b dev https://github.com/<your-github-repository-name>/cgm-remote-monitor.git
cd cgm-remote-monitor
git remote add upstream https://github.com/nightscout/cgm-remote-monitor
git fetch upstream
git merge upstream/dev
git push origin dev
```

**where `<your-github-repository-name>` is replaced with your repository name
found in your Github, upper left once in any of your repositories and also
"signed in as" from the pull-down menu in the top right where all your profile
and settings are found. When you run this it will stop at some point and give
you "git push origin dev" and you can hit enter. Then it will ask for "Username
for 'https://github.com'" where you type in your username (usually your email
address associated with Github) and hit enter. Then it will ask for "Password
for 'https://name@email.com@github.com':" where you type in your password (in
your actual results, the username you entered will be where it says
"name@email.com").
____________________________

The steps discussed here are essentially the same for both Heroku and Azure 
users. Two configuration changes must be made to the Nightscout implementation:

* Add "openaps" (without the quotes) and, optionally, "pump" (without the
  quotes) to the list of plugins enabled, and
* Add a new configuration variable DEVICESTATUS_ADVANCED="true" (without the
  quotes)

For Azure users, here is what these configuration changes will look like (with
just "openaps" added): ![azure config
changes](https://files.gitter.im/eyim/lw6x/blob)

For Heroku users, exactly the same changes should be made on the Config Vars
page. The optional "pump" plugin enables additional pump monitoring pill boxes.
For example, assuming you have added "pump" to the list of enabled plugins, you
may add a new configuration variable `PUMP_FIELDS="reservoir battery"` to
display pump reservoir and battery status on the Nightscout page. The "pump"
plugin offers a number of other options, as documented on the
[Nightscout readme](https://github.com/nightscout/cgm-remote-monitor/blob/dev/README.md#built-inexample-plugins).

Next, on your Nightscout website, go to the Settings (3 horizontal bars) in the
upper right corner.  At the very bottom of the Settings menu, in the "About"
section, you may check the Nightscout version (e.g. version 0.9.0-dev). Just
above is a list of Plugins available.  OpenAPS should show up. Click the check
box to enable. Similarly, in the case you've enabled the "pump" plugin, "Pump"
should also show up in the list, and you may check the box to enable. You
should now see the OpenAPS pill box (and any optional pump monitoring pill
boxes) on the left side of the Nightscout page near the time. You may also want
to graphically show the basal rates: select "Default" or "Icicle" from the
"Render Basal" pull-down menu in the Settings.


### Configure Nightscout profile

You need to create a profile in your Nightscout site that contains the Timezone,
Duration of Insulin Activity (DIA), Insulin to carb ratio (I:C), Insulin
Sensitivity Factor (ISF), Carbs Activity / Absorption rate, Basal Rates and
Target BG range.

These settings are not currently updated from the values stored in the pump. You
will need to keep the Nightscout profile in sync with any changes you make in
your pump.

To configure your profile, on your Nightscout website, go to the Settings (3
horizontal bars) in the upper right corner. Click on the Profile Editor button.
Create a new profile (if you don't already have one) using the settings that
match what you already have set up in your pump. Fill out all the profile fields
and click save.

### Understanding the OpenAPS pill

The OpenAPS pill box has four states, based on what happened in the last 15
minutes: Enacted, Looping, Waiting, and Warning:

* Waiting is when OpenAPS is uploading, but hasn't seen the pump in a while
* Warning is when there hasn't been a status upload in the last 15 minutes
* Enacted means OpenAPS has recently enacted the pump
* Looping means OpenAPS is running but has not enacted the pump

Some things to be aware of:

* Make sure that the timezones for the pi (if need be you can use `sudo
  raspi-config` to change timezones), in your monitor/clock-zoned.json report,
  and the Nightscout website are all in the same time zone.
* The basal changes won't appear in Nightscout until the second time the loop
  runs and the corresponding upload is made.
* You can scroll back in time and at each glucose data point you can see what
  the critical information was at that time

Note: Remember to add `careportal` to Nightscout's `ENABLE` environment variable
in case it is not already there.


