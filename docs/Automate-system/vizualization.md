# Visualization and Monitoring

## Nightscout Integration

Integrating OpenAPS with Nightscout is a very helpul way to visualize what OpenAPS using a web browser or an app on a mobile device, as opposed to logging into your Raspberry Pi and looking through the logs. The integration requires setting up Nightscout and making changes and additions to your OpenAPS implementation.

### Nightscout setup

OpenAPS requires the latest (currently dev) version of Nighthscout, which can be found here: https://github.com/nightscout/cgm-remote-monitor/tree/dev. 

Note:  currently there is a bug in the dev version, which doesn't allow you to set up a new profile using the profile editor. If you are starting a fresh install of Nightscout, you should first deploy the master version of the code. Once the master version is up an running, you can create your profile with information on basal rates, etc. After that, you can deploy the dev version. If you have an existing version of Nightscout, then create your profile before moving to the dev version. Or, you may keep your existing Nightscout as is, and start a new Nightscout site (master first, followed by dev), specifically to test OpenAPS integration. 

The steps discussed here are essantially the same for both Azure and Heroku users. Two configuration changes must be made to the Nightscout implementation:

* Add "openaps" (without the quotes) to the list of plugins enabled, and 
* Add  DEVICESTATUS_ADVANCED="true" 

For Azure users, here is what these configuration changes will look like: https://files.gitter.im/eyim/lw6x/blob.

Next, on your Nightscout website, go to the settings (3 vertical lines) in the upper right corner.  At the very bottom, in the "About" section, you may check the Nightscout version (e.g. version 0.9.0-dev). Just above is a list of Plugins available.  OpenAPS should show up.  Click the check box to enable. You should now see the OpenAPS pill box on the left side near the time. You may also want to graphically show the basal rates: select "Default" or "Icicle" from the Render Basal pull-down menu. Here is an example of a configured Nightscout page: https://files.gitter.im/eyim/J8OR/blob

### Environment Variables for OpenAPS Access to Nightscout

To be able to upload data, OpenAPS needs to know the URL for your Nightscout website and the hashed version of your API_SECRET password, which you have entered as one of your Nightscout configuration settings. Two environment variables, NIGHTSCOUT_HOST and API_SECRET, are used to store the website address and the password respectively. 

To obtain the hashed version of the API_SECRET, go to http://www.sha1-online.com/ (keep the default sha-1) and hash your API_SECRET. For example, if your enter "password" (without quotes), the hashed version return will be 5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8. 

In your Raspberry PI terminal window, you may now define the two environment variables as follows:

```
$ export  NIGHTSCOUT_HOST = https://<your Nightscout address>
$ export  API_SECRET = <your hashed password>
```

These variables will stay defined as long as the current terminal session remains active. Note that it is important to enter https:// (not http://) in front of your Nightscout address.

### Configuring and Uploading OpenAPS Status

Integration with Nightscout requires couple of changes to your OpenAPS implementation, which include: 

* Preparing a new report `monitor/upload-status.json` which consolidates the current OpenAPS status to be uploaded to Nightscout 
* Uploading the status report to Nightscount, using a `` command 

Upon successful completion of these two steps, you will be able to see the current OpenAPS status by hovering over the OpenAPS pill box on your Nightscount page. 

3) Add this report to your openaps.ini file

1) Add two devices, one called "ns-upload", via a command like `openaps device add fake process ns-upload https://YOURWEBSITE.azurewebsites.net 5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8`, and one called "ns-status".

Once added the relevant portion of your openaps.ini file should look something like this:

[device "ns-upload"] <br>
extra - ns-upload.ini <br>

Where ns-upload.ini is a file in your main openaps directory that contains:
[device "ns-upload"] <br>
fields = <br>
vendor = openaps.vendors.process <br>
cmd = ns-upload <br>
args = https://YOURWEBSITE.azurewebsites.net 5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8 (this is the hashed version of your API_SECRET password) <br>

The last line args = should contain the URL of the Nightscout website.  Note that for Azure it is important to include the https:// before the URL>  What follows is the hashed version of your API_SECRET password.  To get the hased version of the password, put your password into this website:  http://www.sha1-online.com/

For example, if your password is "password" (without quotes) it will return 5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8

[device "ns-status"] <br>
fields = clock iob suggested enacted battery reservoir status<br>
cmd = ns-status<br>
vendor = openaps.vendors.process<br>
args = <br>

2) Add this alias to your openaps.ini file:

status-upload = ! bash -c "openaps report invoke monitor/upload-status.json && (openaps use ns-upload shell devicestatus.json monitor/upload-status.json )"

4) Add the command openaps status-upload to your loop.  I add it after the main loop

5) There are 4 states now, based on what happened in the last 15m:  Enacted, looping, waiting, and warning <br>
Waiting is when the pi is uploading, but hasn't seen the pump in a while <br>
Warning is when there hasn't been a status upload in 15m <br>
Enacted menas it is working fine <br>
Looping means the loop is running but not enacting <br>

Some things to be aware of:

* Make sure that the timezones for the pi (use sudo raspi-config to change timezones), in your monitor/clock-zoned.json report and the Nightscout website are all in the same timezone.
* The basal changes won't appear in Nightscout until the second time the loop runs.
* The OpenAPS pillbox will show you when the last time your loop ran.  If you hover over it, it will provide critical information that was used in the loop.  It will help you understand what the loop is doing on every cycle.
* You can scroll back in time and at each glucose data point you can see what the critical information was at that time

### Uploading Latest Treatments to Nightscout

It is also very beneficial to upload the treatment information from the pump and into Nightscout.  This removes the burden of entering this information into Nightscout

Here are the alias to add to your openaps.ini file:

latest-ns-treatment-time = ! bash -c "nightscout latest-openaps-treatment $NIGHTSCOUT_HOST | json created_at"<br>
<br>
format-latest-nightscout-treatments = ! bash -c "nightscout cull-latest-openaps-treatments monitor/pump-history-zoned.json monitor/model.json $(openaps latest-ns-treatment-time) > upload/latest-treatments.json" <br>
<br>
upload-recent-treatments = ! bash -c "openaps format-latest-nightscout-treatments && test $(json -f upload/latest-treatments.json -a created_at eventType | wc -l ) -gt 0 && (ns-upload $NIGHTSCOUT_HOST $API_SECRET treatments.json upload/latest-treatments.json ) || echo \"No recent treatments to upload\""<br>

In the aliases you will see variables like these:  $NIGHTSCOUT_HOST $API_SECRET.  These are environmental variable.  You can read more about them here:  https://en.wikipedia.org/wiki/Environment_variable <br>

Basically $NIGHTSCOUT_HOST is your Nightscout URL and $API_SECRET is your API_secret password for Nightscout.  You will need to define these either in crontab or in your loop script.  TO define them use the following:

export NIGHTSCOUT_HOST=https://yourwebsite.azurewebsites.net
export API_SECRET=yourpassword   (plain text seems to work fine)



Note:  Currently extended bolus are not handled well and depending on the timing of the upload are either missed entirely or has incorrect information.  
