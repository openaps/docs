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
completed these steps, log on to Azure or Heroku and disconnect the deployment
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

The steps discussed here are essentially the same for both Azure and Heroku
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

### New simpler method for Nightscout upload

[This walkthrough](openaps-to-nightscout.md) outlines an easier method than the
below. We need volunteers to run through this method and replace the sections
below as appropriate.

### Configuring and Uploading OpenAPS Status

**At this point in the docs I find it confusing as the next part dives straight
into working inside of your openaps repo (or whatever the right term for it is).
I would think before jumping straight to setting up the integration with
Nightscout you would go over some basic `openaps use ns` type stuff, or even
just doing `openaps init` for the first time. I see this stuff is in [Phase 2 -
Configuring and Learning to Use openaps
Tools](../phase-2/using-openaps-tools.html), so the next bit seems out of place
if you're supposed to follow the phases in order**

Integration with Nightscout requires couple of changes to your OpenAPS
implementation, which include:

* Adding a new `ns` device, and generating a new report
  `monitor/upload-status.json`, which consolidates the current OpenAPS status to
  be uploaded to Nightscout

Upon successful completion of these two steps, you will be able to see the
current OpenAPS status by hovering over the OpenAPS pill box on your Nightscout
page, as shown here, for example:
![Nightscout-Openaps pill box](https://files.gitter.im/eyim/J8OR/blob)

The `ns` is a virtual device in the oref0 system, which consolidates OpenAPS
status info in a form suitable for upload to Nightscout. First, add the device:

The reports required to generate upload-status.json should look familiar. If you
have not generated any of these required reports, you should set them up and
make sure they all work. In particular, note that monitor/clock-zoned.json
contains the current pump clock time stamp, but with the timezone info included.
If you have not generated that report already, you may do so using the following
commands, which add a `tz` virtual device and use it to create clock-zoned.json
starting from clock.json.

```
$ openaps vendor add openapscontrib.timezones
$ openaps device add tz timezones
$ git add tz.ini
$ openaps report add monitor/clock-zoned.json JSON tz clock monitor/clock.json
```


To test this alias, you may first run your loop manually from command line, then
execute `openaps status-upload`, examine the output, and check that the new
status is visible on the OpenAPS pill box on your Nightscout page. To automate
the status upload each time the loop is executed you can simply add
`status-upload` to your main OpenAPS loop alias. The OpenAPS pill box will show
when the last time your loop ran. If you hover over it, it will provide critical
information that was used in the loop, which will help you understand what the
loop is currently doing.

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


### Set up `ns` device
To get your OpenAPS viewed onto your Nightscout site, start by using the
following tool:


```
nightscout autoconfigure-device-crud
```
To view your data on your Nightscout site, start by doing the following:
```
nightscout autoconfigure-device-crud https://yourname.com yourplainapisecret
```

So this would be your actual `https://myname.azurewebsites.net` or
`https://myname.herokuapp.com`. Your `API_SECRET` is listed in your Azure or
Heroku settings. To test this:
```
openaps use ns shell preflight
```

To get aliases:
```
curl -sg https://gist.githubusercontent.com/bewest/d3db9ca1c144b845382c885138a8f66e/raw/181c5d6f29cd6489ecc9630786cf2c4937ddde79/bewest-aliases.json | openaps import
```

### Sending glucose data:

```
openaps use ns shell format-recent-type tz entries monitor/glucose.json  | json -a dateString | wc -l
# Add it as a report
openaps report add nightscout/recent-missing-entries.json JSON ns shell format-recent-type tz entries monitor/glucose.json
# fetch data for first time
openaps report invoke nightscout/recent-missing-entries.json

# add report for uploading to NS
openaps report add nightscout/uploaded-entries.json JSON  ns shell upload entries.json nightscout/recent-missing-entries.json
# upload for fist time.
openaps report invoke nightscout/uploaded-entries.json

```

### Uploading Latest Treatments to Nightscout

In addition to uploading OpenAPS status, it also very beneficial to upload the
treatment information from the pump into Nightscout. This removes the burden of
entering this information into Nightscout manually.

Note that a `pumphistory-zoned.json` report is required, which can be generated
from pumphistory.json using `tz`, following the approach described above for
clock-zoned.json, including making sure to add it to your monitor-pump alias. In
addition, if you haven't already created a requisite reports you should create
that report and invoke it since it is required. Upon successful upload, the
recent treatments will show up automatically on the Nightscout page.

Note: Currently extended boluses are not handled well and depending on the
timing of the upload are either missed entirely or have incorrect information.


To upload treatments data to Nightscout, prepare you zoned glucose, and pump
model reports, and use the following two reports:

```
openaps report add nightscout/recent-treatments.json JSON ns shell  format-recent-history-treatments monitor/pump-history.json model.json
openaps report add nightscout/uploaded.json JSON  ns shell upload-non-empty-treatments  nightscout/recent-treatments.json
```
Here are the equivalent uses:

```
openaps use ns shell format-recent-history-treatments monitor/pump-history.json model.json
openaps use ns shell upload-non-empty-treatments nightscout/recent-treatments.json
```
The first report runs the format-recent-history-treatments use, which fetches
data from Nightscout and determines which of the latest deltas from openaps need
to be sent. The second one uses the upload-non-empty-treatments use to upload
treatments to Nightscout, if there is any data to upload.


To pull data: `openaps gather-clean-data`

To set up Nightscout reports:
```
curl -sg https://gist.githubusercontent.com/bewest/d3db9ca1c144b845382c885138a8f66e/raw/522155bae116983499bb1de30f10f52eb3c4b6b7/ns-reports.json | openaps import
```
To see your progress: `openaps do-everything`

Then again, to check your progress:  `openaps do-everything`
At this point, you should see treatment circles, information about the battery,
etc.

To verify what was uploaded to Nightscout:
`cat nightscout/uploaded.json`

### Sending openaps status to Nightscout
```
openaps use ns shell status monitor/clock.json oref0-monitor/iob.json oref0-predict/oref0.json oref0-enacted/enacted-temp-basal.json monitor/battery.json monitor/reservoir.json monitor/status.json
```

You should see a lot of info. (Side note: the word "received" is spelled wrong.)

Make sure to save this as a report:
```
openaps report add nightscout/openaps-status.json JSON ns shell monitor/clock.json oref0-monitor/iob.json oref0-predict/oref0.json oref0-enacted/enacted-temp-basal.json monitor/battery.json monitor/reservoir.json monitor/status.json
```

Now it needs to be invoked to test that it is getting data:
```
openaps report invoke nightscout/openaps-status.json
```

Test uploading it:
```
openaps use ns shell upload devicestatus.json nightscout/openaps-status.json
```

If it works, save it as a report:
```
openaps report add nightscout/uploaded-recent-devicestatus.json JSON ns shell upload devicestatus.json nightscout/openaps-status.json added ns://JSON/shell/nightscout/uploaded-recent-devicestatus.json
```

### Updating Aliases
Now those aliases we did earlier need adjustment for all of the recent work we
just did:
```
openaps alias add report-nightscout "report invoke  nightscout/recent-treatments.json nightscout/uploaded.json nightscout/recent-missing-entries.json nightscout/uploaded-entries.json nightscout/openaps-status.json nightscout/uploaded-recent-devicestatus.json"
```

SUCCESS!!

To upload to Nightscout, use:  `openaps do-everything`
To just test uploading to Nightscout, use:  `openaps report-nightscout`

Make sure to backup all the work you have just done:
`oref0 export-loop | tee backup-loop.json`
