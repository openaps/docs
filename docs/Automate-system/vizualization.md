# Visualization and Monitoring

## Nightscout Integration

Integrating Openaps with Nightscout is a very helpul way to understand what Openaps is doing in a visual way and can be accessed through a web browser rather than logging into the Raspberry Pi and looking at the logs.  

There are a few changes to your Nightscout Implementation:
1) You must install the dev version of Nightscout which can be found here:
https://github.com/nightscout/cgm-remote-monitor/tree/dev

Note:  Currently there is a bug in the dev version that doesn't allow you to set up a new profile using the profile editor.  So if you are starting a fresh install of Nightscout, it is necessary first to launch the master (live) version of the code.  Then create the profile with information on basal rates, etc.  Then after that install the dev version.

If you have an existing version of Nightscout, then create a profile before moving to the dev version.

2) Two configuration changes must be made to the Nightscout implementation:

For Azure users, you must add "openaps" (without the quotes) to the list of plugins enabled and add  DEVICESTATUS_ADVANCED="true" 

Here is what it will look like:

https://files.gitter.im/eyim/lw6x/blob

3) On your Nightscout website, go to the settings (3 vertical lines) in the upper right corner.  Near the bottom is a list of Plugins available.  OpenAPS should show up.  Click the check box to enable.  You should now see the OpenAPS pill box on the left side near the time.

Example here:

https://files.gitter.im/eyim/J8OR/blob

Now we need to make a few changes to your OpenAPS implementation

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

3) Add this report to your openaps.ini file

[report "monitor/upload-status.json"] <br>
use = shell <br>
device = ns-status <br>
clock = monitor/clock-zoned.json <br>
iob = predict/iob.json <br>
suggested = predict/oref0.json <br>
enacted = control/enacted.json <br>
battery = monitor/battery.json <br>
reservoir = monitor/reservoir.json <br>
status = monitor/status.json <br>
reporter = JSON <br>

You many need to change where the openaps system should look for these reports depending on where they are.

4) Add the command openaps status-upload to your loop.  I add it after the main loop

Some things to be aware of:

1) Make sure that the timezones for the pi (use sudo raspi-config to change timezones), in your monitor/clock-zoned.json report and the Nightscout website are all in the same timezone.

2) The basal changes won't appear in Nightscout until the second time the loop runs.

3) The OpenAPS pillbox will show you when the last time your loop ran.  If you hover over it, it will provide critical information that was used in the loop.  It will help you understand what the loop is doing on every cycle.

4) You can scroll back in time and at each glucose data point you can see what the critical information was at that time

5) There are 4 states now, based on what happened in the last 15m:  Enacted, looping, waiting, and warning <br>
Waiting is when the pi is uploading, but hasn't seen the pump in a while <br>
Warning is when there hasn't been a status upload in 15m <br>
Enacted menas it is working fine <br>
Looping means the loop is running but not enacting <br>

###Upload Latest Treatments to Nightscout

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
