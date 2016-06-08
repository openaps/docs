# Visualization and Monitoring

[Nightscout](http://nightscout.info) is the recommended way to visualize your CGM data, your pump data, and ultimately closed-loop operation of OpenAPS. This provides a visual alternative to SSHing into your raspberry Pi or loop system and looking through log files. Even if you don't choose to share your Nightscout instance with another person, the ability to visualize all data combined on the same screen is very helpful. Furthermore, Nightscout can be used to generate helpful data reports, and to customize various watchfaces. 

## Nightscout Integration

The integration requires setting up Nightscout and making changes and additions to your OpenAPS implementation.

### Nightscout Setup

OpenAPS requires the latest (currently dev) version of Nightscout, which can be found here: https://github.com/nightscout/cgm-remote-monitor/tree/dev. If you are already using Nightscout you might have to update your repository. Just go to the https://github.com/nightscout/cgm-remote-monitor repository and look for "updating my version". Once you have completed these steps, log on to Azure or Heroku and disconnect the deployment source. Thereafter choose your cgm-remote-monitor github repository as source again. You should take the dev branch of this repository especially if you plan to use the advanced-meal-assist feature. 

The steps discussed here are essentially the same for both Azure and Heroku users. Two configuration changes must be made to the Nightscout implementation:

* Add `careportal` to Nightscout's `ENABLE` environment variable in case it is not already there;
* Add `openaps` and, optionally, `pump` to the `ENABLE` environment variable, and 
* Add a new configuration variable `DEVICESTATUS_ADVANCED = true`

For Azure users, here is what these configuration changes will look like (with just "openaps" added): ![azure config changes](https://files.gitter.im/eyim/lw6x/blob). For Heroku users, exactly the same changes should be made on the Config Vars page. The optional "pump" plugin enables additional pump monitoring pill boxes. For example, assuming you have added "pump" to the list of enabled plugins, you may add a new configuration variable PUMP_FIELDS="reservoir battery" to display pump reservoir and battery status on the Nightscout page. The "pump" plugin offers a number of other options, as documented on the Nightscout readme page: https://github.com/nightscout/cgm-remote-monitor/blob/dev/README.md#built-inexample-plugins 

Next, on your Nightscout website, go to the Settings (3 horizontal bars) in the upper right corner.  At the very bottom of the Settings menu, in the "About" section, you may check the Nightscout version (e.g. version 0.9.0-dev). Just above is a list of Plugins available.  OpenAPS should show up. Click the check box to enable. Similarly, in the case you've enabled the "pump" plugin, "Pump" should also show up in the list, and you may check the box to enable. You should now see the OpenAPS pill box (and any optional pump monitoring pill boxes) on the left side of the Nightscout page near the time. You may also want to graphically show the basal rates: select "Default" or "Icicle" from the "Render Basal" pull-down menu in the Settings. 

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
Click on the Profile Editor button. Create a new profile (if you don't already have one) using the settings that match what you already have set up in your pump. Fill out all the profile fields and click save.

Once you have Nightscount up and running, and ready for integration with OpenAPS, you will be able to add pump data and OpenAPS status to the display, as described in the rest of this section. The next steps require starting an openaps instance, setting up openaps devices, generating openaps reports, and collecting approptiate data. You may therefore skip the rest of this section, and come back to it once you have completed [Phase 2 - Configuring and Learning to Use openaps Tools](https://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-2/using-openaps-tools.html), and again once you have completed closing the loop.

**NOTE: more significant updates to the rest of this section are in progress. You may proceed as described below or (even better) look through the recent [gitter chat](https://gitter.im/nightscout/intend-to-bolus) related to Nightscout integration.** 

### Configuring and Uploading OpenAPS Status

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

In addition to uloading OpenAPS status, it also very beneficial to upload the treatment information from the pump into Nightscout.  This removes the burden of entering this information into Nightscout manually. This can be accomplished using `nightscout` command and adding a new `upload-recent-treatments` alias as follows: 

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
