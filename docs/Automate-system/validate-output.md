# Validating and Testing

If you haven't read this enough already: the DIY part of this is really important. If you've been copying and pasting, and not understanding what you're doing up to this point - please stop. That's dangerous. You should be testing and validating your work, and asking questions as you go if anything is unclear. (And, if this documentation annoys you enough, put in a PR as you go through each part to update/improve the documentation to help the next person! We've all been there.) :)

That being said, at this stage, you have both a manual loop and a schedule (using cron) to create an automated loop. At this point, you're in the "test and watch" phase. In particular, you should make sure the loop is recommending and enacting the types of temporary basal rates that you might do manually; and that the communication is working between the devices. And, as your test extends from minutes to hours, you'll want to check at least these scenarios: data corruption, lack of data, lack of connectivity, and other non-ideal operating conditions.

##Unit testing

Additionally, you may want to consider some unit testing. There is a basic unit testing framework in oref0 that you can use, and add to. 

###To help with unit test cases:

If you'd like to help out with defining all the desired behaviors in the form of unit test cases:

1) Please clone / checkout [oref0] (https://github.com/openaps/oref0)

2) Type `sudo npm install -g mocha` and `sudo npm install -g should`

3) You should then be able to run `make` (or something like `mocha -c tests/determine-basal.test.js 2>&1 | less -r`) from the openaps-js directory to run all of the existing unit tests

4) As you add additional unit tests, you'll want to run `make` again after each one. 

###How to add more test cases:
 
We'll want to cover every section of the code, so if you see a "rT.reason" in bin/oref0-determine-basal.js that doesn't have a corresponding "output.reason.should.match" line in an appropriate test in tests/determine-basal.test.js, then you should figure out what glucose, temp basal, IOB, and profile inputs would get you into that section of the code (preferably representing what you're likely to see in a real-world situation), and create a test case to capture those inputs and the desired outputs.  Then run the tests and see if your test passes, and the output looks reasonable.  If not, then modify your test case accordingly, or if you think you've found a bug in determine-basal.js, ask on Gitter.


### Nightscout Integration

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

1) Add a device called "ns-upload". `openaps device add fake process ns-upload https://YOURWEBSITE.azurewebsites.net 5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8`
 Once added the relevant portion of your openaps.ini file should look something like this:

[device "ns-upload"]
vendor = openaps.vendors.process
extra = ns-upload.ini

Where ns-upload.ini is a file in your main openaps directory that contains:
[device "ns-upload"]
fields = 
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
