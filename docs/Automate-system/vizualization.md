# Visualization and monitoring

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

1) Add a device called "ns-upload".  I find it easiest to paste this into your openaps.ini file.

[device "ns-upload"]
fields = type report
vendor = openaps.vendors.process
cmd = ns-upload
args = https://YOURWEBSITE.azurewebsites.net 5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8 (this is the hashed version of your API_SECRET password)

The last line args = should contain the URL of the Nightscout website.  Note that for Azure it is important to include the https:// before the URL>  What follows is the hashed version of your API_SECRET password.  To get the hased version of the password, put your password into this website:  http://www.sha1-online.com/

For example, if your password is "password" (without quotes) it will return 5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8

2) Add this alias to your openaps.ini file:

status-upload = ! bash -c "openaps report invoke monitor/upload-status.json && (openaps use ns-upload shell devicestatus.json monitor/upload-status.json )"

3) Add this report to your openaps.ini file

[report "monitor/upload-status.json"]
use = shell
device = ns-status
clock = monitor/clock-zoned.json
iob = predict/iob.json
suggested = predict/oref0.json
enacted = control/enacted.json
battery = monitor/battery.json
reservoir = monitor/reservoir.json
status = monitor/status.json
reporter = JSON

You many need to change where the openaps system should look for these reports depending on where they are.

4) Add the command openaps status-upload to your loop.  I add it after the main loop

Some things to be aware of:

1) Make sure that the timezones for the pi (use sudo raspi-config to change timezones), in your monitor/clock-zoned.json report and the Nightscout website are all in the same timezone.

2) The basal changes won't appear in Nightscout until the second time the loop runs.

3) The OpenAPS pillbox will show you when the last time your loop ran.  If you hover over it, it will provide critical information that was used in the loop.  It will help you understand what the loop is doing on every cycle.

4) You can scroll back in time and at each glucose data point you can see what the critical information was at that time

5) There are 4 states now, based on what happened in the last 15m:  Enacted, looping, waiting, and warning
Waiting is when the pi is uploading, but hasn't seen the pump in a while
Warning is when there hasn't been a status upload in 15m
Enacted menas it is working fine
Looping means the loop is running but not enacting
