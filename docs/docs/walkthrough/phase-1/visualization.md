# Visualization and Monitoring

[Nightscout](http://nightscout.info) is the recommended way to visualize your OpenAPS closed loop. Even if you don't choose to share your Nightscout instance with another person, it will be helpful for you to visualize what the loop is doing; what it's been doing; plus generate helpful reports for understanding your data and also allowing you to customize watchfaces with your OpenAPS data. This provides a visual alternative to SSHing into your raspberry Pi or loop system and looking through log files.

## Nightscout Integration

The integration requires setting up Nightscout and making changes and additions to your OpenAPS implementation.

### Nightscout Setup

OpenAPS requires the latest (currently dev) version of Nightscout, which can be found here: https://github.com/nightscout/cgm-remote-monitor/tree/dev. If you are already using Nightscout you might have to update your repository. Just go to the https://github.com/nightscout/cgm-remote-monitor repository and look for "updating my version". Once you have completed these steps, log on to Azure or Heroku and disconnect the deployment source. Thereafter choose your cgm-remote-monitor github repository as source again. You should take the dev branch of this repository especially if you plan to use the advanced-meal-assist feature.

The steps discussed here are essentially the same for both Azure and Heroku users. Two configuration changes must be made to the Nightscout implementation:

* Add "openaps" (without the quotes) and, optionally, "pump" (without the quotes) to the list of plugins enabled, and
* Add a new configuration variable DEVICESTATUS_ADVANCED="true" (without the quotes)

For Azure users, here is what these configuration changes will look like (with just "openaps" added): ![azure config changes](https://files.gitter.im/eyim/lw6x/blob). For Heroku users, exactly the same changes should be made on the Config Vars page. The optional "pump" plugin enables additional pump monitoring pill boxes. For example, assuming you have added "pump" to the list of enabled plugins, you may add a new configuration variable PUMP_FIELDS="reservoir battery" to display pump reservoir and battery status on the Nightscout page. The "pump" plugin offers a number of other options, as documented on the Nightscout readme page: https://github.com/nightscout/cgm-remote-monitor/blob/dev/README.md#built-inexample-plugins

Next, on your Nightscout website, go to the Settings (3 horizontal bars) in the upper right corner.  At the very bottom of the Settings menu, in the "About" section, you may check the Nightscout version (e.g. version 0.9.0-dev). Just above is a list of Plugins available.  OpenAPS should show up. Click the check box to enable. Similarly, in the case you've enabled the "pump" plugin, "Pump" should also show up in the list, and you may check the box to enable. You should now see the OpenAPS pill box (and any optional pump monitoring pill boxes) on the left side of the Nightscout page near the time. You may also want to graphically show the basal rates: select "Default" or "Icicle" from the "Render Basal" pull-down menu in the Settings.

# Configuring and Learning to Use openaps Tools

This section provides an introduction to intializing, configuring, and using the openaps toolset. The purpose is to get you familiar with how the different commands work and to get you thinking about how they may be used to build your own closed loop. Make sure you have completed the [Setting Up the Raspberry Pi 2](../phase-0/rpi.md) and [Setting Up openaps](../phase-0/openaps.md) sections prior to starting.

The [openaps readme](https://github.com/openaps/openaps/blob/master/README.md) has detailed information on the installation and usage of openaps. You should take the time to read through it in detail, even if it seems confusing at first. There are also a number of example uses available in the [openaps-example](https://github.com/bewest/openaps-example) repository.


Some familiarity with using the terminal will go a long way, so if you aren't
comfortable with what `cd` and `ls` do, take a look at some of the Linux Shell
/ Terminal links on the [Technical
Resources](../../Resources/technical-resources.md) page.

Some conventions used in this guide:
* Wherever there are `<bracketed_components>` in the the code, these are meant
  for you to insert your own information. Most of the time, it doesn't matter
  what you choose **as long as you stay consistent throughout this guide**.
  That means if you choose `Barney` as your  ` < my_pump_name > `, you must use
  `Barney` every time you see `< my_pump_name >`. Choose carefully. Do not
  include the ` < > ` brackets in your name.


``` eval_rst
.. note::
    One helpful thing to do before starting is to log your terminal session. This
    will allow you to go back and see what you did at a later date. This will also
    be immensely helpful if you request help from other OpenAPS contributors as you
    will be able to provide an entire history of the commands you used. To enable
    this, just run `$ script <filename>` at the beginning of your session. It will
    inform you that `Script started, file is <filename>`. When you are done, simply
    `$ exit` and it will announce `Script done, file is <filename>`. At that point,
    you can review the file as necessary.
```

<br>
## Configuring openaps

### Initialize a new openaps environment

To get started, SSH into your Raspberry Pi. Go to your home directory:

`$ cd`

Create a new instance of openaps in a new directory:

`$ openaps init <my_openaps>`

As mentioned above, `<my_openaps>` can be anything you'd like: `myopenaps`, `awesome-openaps`, `openaps4ever`, `bob`, etc.

Now that it has been created, move into the new openaps directory:

`$ cd <my_openaps>`

All subsequent openaps commands must be run in this directory. If you try to run an openaps command in a different directory, you will receive an error:

`Not an openaps environment, run: openaps init`

The directory you just created and initialized as an openaps environment is mostly empty at the moment, as can been seen by running the list files command:

```
$ ls
openaps.ini
```
That `openaps.ini` file is the configuration file for this particular instance of openaps. It will contain all of your device information, plugin information, reports, and aliases. In the subsequent sections, you will be configuring your openaps instance to add these components. For now, however, it is blank. Go ahead and take a look:

`$ cat openaps.ini`

Didn't return much, did it? By the way, that `cat` command will be very useful as you go through these configuration steps to quickly check the contents of files (any files, not just `openaps.ini`). Similarly, if you see a command that you are unfamiliar with, such as `cat` or `cd`, Google it to understand what it does. The same goes for error messages—you are likely not the first one to encounter whatever error is holding you back.

### Add pump as device

In order to communicate with the pump and cgm receiver, they must first be added as devices to the openaps configuration. To do this for the pump:

`$ openaps device add <my_pump_name> medtronic <my_serial_number>`

Here, `<my_pump_name>` can be whatever you like, but `<my_serial_number>` must be the 6-digit serial number of your pump. You can find this either on the back of the pump or near the bottom of the pump's status screen, accessed by hitting the ESC key.

**Important:** Never share your 6-digit pump serial number and never post it online. If someone had access to this number, and was in radio reach of your pump, this could be used to communicate with your pump without your knowledge. While this is a feature when you want to build an OpenAPS, it is a flaw and a security issue if someone else can do this to you.

### Add Dexcom CGM receiver as device

Now you will do this for the Dexcom CGM receiver:

`$ openaps device add <my_dexcom_name> dexcom`

Note this step is not required if you are using a Medtronic CGM. The pump serves as the receiver and all of the pumping and glucose functionality are contained in the same openaps device.

### Check that the devices are all added properly

`$ openaps device show`

should return something like:

```
medtronic://pump
dexcom://cgms
```
Here, `pump` was used for `<my_pump_name>` and `cgms` was used for
`<my_dexcom_name>`. The names you selected should appear in their place.

Your `openaps.ini` file now has some content; go ahead and take another look:

`$ cat openaps.ini`

Now, both of your devices are in this configuration file:

```
[device "pump"]
vendor = openaps.vendors.medtronic
extra = pump.ini

[device "cgms"]
vendor = openaps.vendors.dexcom
extra = cgms.ini
```

Again, `pump` was used for `<my_pump_name>` and `cgms` was used for `<my_dexcom_name>`. Your pump model should also match your pump.

Because your pump's serial number also serves as its security key, that information is now stored in a separate ini file (here noted as `pump.ini`) that was created when you created the pump device. This makes it easier for sharing the `openaps.ini` file and also for keeping `pump.ini` and `cgms.ini` more secure. Be careful with these files. Open the pump's ini file now (use the name reported to you in the line labeled `extra` in the `openaps.ini` file).

`$ cat pump.ini`

It should show something like this:

```
[device "pump"]
serial = 123456
```

The serial number should match that of your pump.

If you made a mistake while adding your devices or simply don't like the name you used, you can go back and remove the devices as well. For example, to remove the pump:

`$ openaps device remove <my_pump_name>`

Then, you can add your pump again with a different name or serial number.

### Environment Variables for OpenAPS Access to Nightscout

To be able to upload data, OpenAPS needs to know the URL for your Nightscout website and the hashed version of your API_SECRET password, which you have entered as one of your Nightscout configuration variables. Two environment variables, NIGHTSCOUT_HOST and API_SECRET, are used to store the website address and the password, respectively.

To obtain the hashed version of the API_SECRET, run the following ```echo -n "<API_SECRET>" | shasum``` and replace ```<API_SECRET>``` with what you set up in Nightscout. For example, if your enter ```echo -n "password" | shasum```, the hashed version returned will be 5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8. Run it with your password and save the hashed key that is output for the next step.

In your terminal window, you may now define the two environment variables. This is done by adding them to your .profile in your home directory. The .profile runs each time the system starts and will ensure these variables are set for future use on the command line.

```nano ~/.profile``` and add the following at the end of the file below any other content that may already be there:
```
NIGHTSCOUT_HOST=https://<your Nightscout address>; export NIGHTSCOUT_HOST
API_SECRET=<your hashed password>; export API_SECRET
```

Now run ```source /etc/profile``` to enact the changes we've just made without restart the machine

### Configure Nightscout profile

You need to create a profile in your Nightscout site that contains the Timezone, Duration of Insulin Activity (DIA), Insulin to carb ratio (I:C), Insulin Sensitivity Factor (ISF), Carbs Activity / Absorption rate, Basal Rates and Target BG range.  

These settings are not currently updated from the values stored in the pump. You will need to keep the Nightscout profile in sync with any changes you make in your pump.

To configure your profile, on your Nightscout website, go to the Settings (3 horizontal bars) in the upper right corner.  
Click on the Profile Editor button.  
Create a new profile (if you don't already have one) using the settings that match what you already have set up in your pump.  
Fill out all the profile fields and click save.

We stopped here in order to go first build the dependencies needed for the next step.

### New simpler method for Nightscout upload

[This walkthrough](openaps-to-nightscout.md) outlines an easier method than the below.  We need volunteers to run through this method and replace the sections below as appropriate.

### Configuring and Uploading OpenAPS Status

**At this point in the docs I find it confusing as the next part dives straight into working inside of your openaps repo (or whatever the right term for it is). I would think before jumping straight to setting up the integration with Nightscout you would go over some basic `openaps use ns` type stuff, or even just doing `openaps init` for the first time. I see this stuff is in [Phase 2 - Configuring and Learning to Use openaps Tools](https://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-2/using-openaps-tools.html), so the next bit seems out of place if you're supposed to follow the phases in order**

Integration with Nightscout requires couple of changes to your OpenAPS implementation, which include:

* Adding a new `ns-status` device, and generating a new report `monitor/upload-status.json`, which consolidates the current OpenAPS status to be uploaded to Nightscout
* Uploading the status report to Nightscout, using the `ns-upload` command

Upon successful completion of these two steps, you will be able to see the current OpenAPS status by hovering over the OpenAPS pill box on your Nightscout page, as shown here, for example: ![Nightscout-Openaps pill box](https://files.gitter.im/eyim/J8OR/blob)

The `ns-status` is a virtual device in the oref0 system, which consolidates OpenAPS status info in a form suitable for upload to Nightscout. First, add the device:

```
$ openaps device add ns-status process --require "clock iob suggested enacted battery reservoir status" ns-status
```

The corresponding entry in your openaps.ini file should look like this:

[device "ns-status"] <br>
fields = clock iob suggested enacted battery reservoir status<br>
cmd = ns-status<br>
vendor = openaps.vendors.process<br>
args = <br>

Then use the `ns-status` device to add the `monitor/upload-status.json` report, which you may do as follows:

```
$ openaps report add monitor/upload-status.json JSON ns-status shell monitor/clock-zoned.json monitor/iob.json enact/suggested.json enact/enacted.json monitor/battery.json monitor/reservoir.json monitor/status.json
```

The reports required to generate upload-status.json should look familiar. If you have not generated any of these required reports, you should set them up and make sure they all work.  In particular, note that monitor/clock-zoned.json contains the current pump clock time stamp, but with the timezone info included. If you have not generated that report already, you may do so using the following commands, which add a `tz` virtual device and use it to create clock-zoned.json starting from clock.json.

```
$ sudo pip install recurrent
$ openaps vendor add openapscontrib.timezones
$ openaps device add tz timezones
$ git add tz.ini
$ openaps report add monitor/clock-zoned.json JSON tz clock monitor/clock.json
```

At this point, you may want to update your monitor-pump alias to make sure that it produces all the required reports, so that uploading status to Nightscout can be automated. After you've generated a monitor/upload-status.json report, you can try to manually upload the OpenAPS status to Nightscout using the `ns-upload` command:

```
$ ns-upload $NIGHTSCOUT_HOST $API_SECRET devicestatus.json monitor/upload-status.json
```

If successful, this command will POST the status info to your Nightscout site, and return the content of the Nightscout devicestatus.json file, which you can examine to see what status information is sent to Nightscout.

Finally, you may define a new alias `status-upload`, to combine generating the report and uploading the status to Nightscout:

```
$ openaps alias add status-upload '! bash -c "openaps report invoke monitor/upload-status.json && ns-upload $NIGHTSCOUT_HOST $API_SECRET devicestatus.json monitor/upload-status.json"'
```

To test this alias, you may first run your loop manually from command line, then execute `openaps status-upload`, examine the output, and check that the new status is visible on the OpenAPS pill box on your Nightscout page. To automate the status upload each time the loop is executed you can simply add `status-upload` to your main OpenAPS loop alias. The OpenAPS pill box will show when the last time your loop ran.  If you hover over it, it will provide critical information that was used in the loop, which will help you understand what the loop is currently doing.

The OpenAPS pill box has four states, based on what happened in the last 15 minutes:  Enacted, Looping, Waiting, and Warning:

* Waiting is when OpenAPS is uploading, but hasn't seen the pump in a while
* Warning is when there hasn't been a status upload in the last 15 minutes
* Enacted means OpenAPS has recently enacted the pump
* Looping means OpenAPS is running but has not enacted the pump

Some things to be aware of:

* Make sure that the timezones for the pi (if need be you can use `sudo raspi-config` to change timezones), in your monitor/clock-zoned.json report, and the Nightscout website are all in the same time zone.
* The basal changes won't appear in Nightscout until the second time the loop runs and the corresponding upload is made.
* You can scroll back in time and at each glucose data point you can see what the critical information was at that time

### Uploading Latest Treatments to Nightscout

Note: Remember to add `careportal` to Nightscout's `ENABLE` environment variable in case it is not already there.

In addition to uploading OpenAPS status, it also very beneficial to upload the treatment information from the pump into Nightscout.  This removes the burden of entering this information into Nightscout manually. This can be accomplished using `nightscout` command and adding a new `upload-recent-treatments` alias as follows:

```
$ openaps alias add latest-ns-treatment-time '! bash -c "nightscout latest-openaps-treatment $NIGHTSCOUT_HOST | json created_at"' || die "Can't add latest-ns-treatment-time"
$ openaps alias add format-latest-nightscout-treatments '! bash -c "nightscout cull-latest-openaps-treatments monitor/pumphistory-zoned.json settings/model.json $(openaps latest-ns-treatment-time) > upload/latest-treatments.json"' || die "Can't add format-latest-nightscout-treatments"
$ openaps alias add upload-recent-treatments '! bash -c "openaps format-latest-nightscout-treatments && test $(json -f upload/latest-treatments.json -a created_at eventType | wc -l ) -gt 0 && (ns-upload $NIGHTSCOUT_HOST $API_SECRET treatments.json upload/latest-treatments.json ) || echo \"No recent treatments to upload\""' || die "Can't add upload-recent-treatments"
```

Note that a pumphistory-zoned.json report is required, which can be generated from pumphistory.json using `tz`, following the approach described above for clock-zoned.json, including making sure to add it to your monitor-pump alias. In addition, if you haven't already created a settings/model.json report, you should create that report and invoke it since it is required for format-latest-nightscout-treatments.

After running your loop from command line, you may try executing `openaps upload-recent-treatments` manually from command line. Upon successful upload, the recent treatments will show up automatically on the Nightscount page.

Note:  Currently extended boluses are not handled well and depending on the timing of the upload are either missed entirely or have incorrect information.

As a final step in the OpenAPS and Nightscout integration, you may add `status-upload` and `upload-recent-treatments` to your main loop, and automate the process using cron. Make sure you include the definitions of the environment variables NIGHTSCOUT_HOST and API_SECRET in the top part of your crontab file, without `export`, or quotes:
```
NIGHTSCOUT_HOST=https://<your Nightscout address>
API_SECRET=<your hashed password>
```

### Setup script
[This script](https://github.com/openaps/oref0/commit/d9951683cef1fd6aefc38d2c76ce9e5a177b9aa2) may be useful.
