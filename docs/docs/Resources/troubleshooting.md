# Troubleshooting

Even those who follow this documentation precisely are bound to end up stuck at some point. This could be due to something unique to your system, a mistyped command, actions performed out of order, or even a typo in this guide. This section provides some tools to help diagnose the issue as well as some common errors that have been experienced and resolved before. If you get stuck, try re-reading the documentation again and after that, share what you've been working on, attempted steps to resolve, and other pertinent details in [#intend-to-bolus in Gitter](https://gitter.im/nightscout/intend-to-bolus) when asking for help troubleshooting. Here is also a [good blog post to read with tips on how to best seek help online to troubleshoot](https://diyps.org/2017/03/19/tips-for-troubleshooting-diy-diabetes-devices-openaps-or-otherwise/).

## Generally useful linux commands

More comprehensive command line references can be found [here](http://www.computerworld.com/article/2598082/linux/linux-linux-command-line-cheat-sheet.html) and [here](http://www.pixelbeat.org/cmdline.html). For the below, since these are basic linux things, also try using a basic search engine (i.e. Google) to learn more about them and their intended use.

`ls -alt` (List all of the files in the current directory with additional details.)

`cd` (Change directory)

`pwd` (Show the present working directory (your current location within the filesystem).)

`sudo <command>` (Super-user do. Temporarily elevates the current users permission to that of root.)

`apt-get install <package>` (Aptitude is a package manager, when a package is missing it will (usually) be there and can be installed by issuing 'apt-get install <missing package name>.)

`tail -f /var/log/syslog`

`grep LOOP /var/log/syslog` (Display lines in file that contain a string, in this example, 'LOOP')

`df -h`

`ifconfig`

`cat <filename>` (Display the contents of the file.)

`nano <filename>` (Open and edit the file in the nano text editor.)

`stat <filename>`

`head <filename>` (Display the beginning of the file.)

`less <filename>` (Display the contents of the file, with advanced navigation)

`pip freeze`

`sudo reboot` (Reboot the system)

`sudo shutdown -h now` (The correct way to shut down the Raspberry Pi from the command line. Wait for the green light to stop blinking before removing the power supply.)

`dmesg` (Displays all the kernel output since boot. It’s pretty difficult to read, but sometimes you see things in there about the wifi getting disconnected and so forth.)

`uptime` (Shows how long the system has been running and the load average of last minute/5 minutes/15 minutes)

`crontab -l` (Display cron jobs)

`sudo service cron status` (Display info on cron service. Also use `stop` and `start`)

[add something for decocare raw logging]

## Dealing with the CareLink USB Stick

The `model` command is a quick way to verify whether you can communicate with the pump. Test this with `openaps use <my_pump_name> model`.

If you can't get a response, it may be a range issue. The range of the CareLink radio is not particularly good, and orientation matters; see [range testing report](https://gist.github.com/channemann/0ff376e350d94ccc9f00) for more information.

Sometimes the Carelink will get into an unresponsive state that it will not recover from without help. You can tell this has happened if the pump is within range of the Carelink and you see a repeating series of "Attempting to use a port that is not open" or "ACK is 0 bytes" errors in pump-loop.log. When this happens the Carelink can be recovered by rebooting or physically unplugging and replugging the CareLink stick.

Once you're setting up your loop, you may want to detect these errors and recover the Carelink programmatically. This can be done by running oref0-reset-usb (`oref0-reset-usb.sh`) to reset the USB connection. For example, you could create a cron job that would run `openaps use <my_pump_name> model`, or tail the 100 most recent lines in pump-loop.log, and grep the output looking for the errors noted above. If grep finds the errors, the cron job would run oref0-reset-usb. Just note that during USB reset you will lose the connection to all of your USB peripherals. This includes your Wi-Fi connection if your rig uses a USB Wi-Fi dongle.

## Dealing with a corrupted git repository

OpenAPS uses git as the logging mechanism, so it commits report changes on each report invoke. Sometimes, due to "unexpected" power-offs (battery dying, unplugging, etc.),the git repository gets broken. When it happens you will receive exceptions when running any report from openaps. As git logging is a safety/security measure, there is no way of disabling these commits.

You may see an error that references a loose object, or a corrupted git repository. To fix a corrupted git repository you can run `oref0-reset-git`, which will first run `oref0-fix-git-corruption` to try to fix the repository, and in case when repository is definitely broken it copies the .git history to a temporary location (`tmp`) and initializes a new git repo.

We recommend runing `oref0-reset-git` in cron so that if the repository gets corrupted it can quickly reset itself. 

Finally, if you're still having git issues, you should `cd ~/myopenaps; rm -rf .git ; git init` . If you do this, git will re-initialize from scratch.

Warning: do not run any openaps commands with sudo in front of it `sudo openaps`. If you do, your .git permissions will get messed up. Sudo should only be used when a command needs root permissions, and openaps does not need that. Such permission problems can be corrected by running `sudo chown -R pi.pi .git` in the openaps directory.  If you are using an Intel Edison, run `sudo chown -R edison.users .git`.

## Debugging Disk Space Issues

If you are having errors related to disk space shortages as determined by `df -h` you can use a very lightweight and fast tool called ncdu (a command-line disk usage analyzer) to determine what folders and files on your system are using the most disk space. You can install ncdu as follows: `sudo apt-get install ncdu`. You can run it by running the following command: `cd / && sudo ncdu` and follow the interactive screen to find your disk hogging folders.

An alternative approach to disk troubleshooting is to simply run the following command from the base unix directory after running `cd /`:

`du -xh -d 3 | egrep "[1-9][0-9][0-9]M|[0-9]G"` (reports disk usage of all directories 3 levels deep from the current directory)

Then, based on which folders are using the most space cd to those folders and run the above du command again until you find the folder that is using up the disk space.

It is common that log files are the cause for disk space issues. If you determine that log file(s) are the problem, use a command like `less` to view the last entries in the logfile to attempt to figure out what is causing the logfile to fill up. To temporarily free up space, you can force the logfiles to rotate immediately by running the following command:

`logrotate -f /etc/logrotate.conf`

## Environment variables

If you are getting your BG from Nightscout or you want to upload loop status/results to Nightscout, among other things you'll need to set 2 environment variables: `NIGHTSCOUT_HOST` and `API_SECRET`. If you do not set and export these variables you will receive errors while running `openaps report invoke monitor/ns-glucose.json` and while executing `ns-upload.sh` script which is most probably part of your `upload-recent-treatments` alias.Make sure your `API_SECRET` is in hashed format. Please see [this page](https://github.com/openaps/oref0#ns-upload-entries) for details. Additionally, your `NIGHTSCOUT_HOST` should be in a format like `http://yourname.herokuapp.com` (without trailing slash). For the complete visualization guide use [this page](https://github.com/openaps/docs/blob/master/docs/Automate-system/vizualization.md) from the OpenAPS documentation.

## Wifi and hotspot issues
See [wifi troubleshooting page](wifi.md)

## Common error messages

**WARNING:** Pay close attention to errors. An error may indicate a serious operational or functional problem with a computer system or component.

These error messages may appear in response to openaps commands in the console, or in the system log (located at /var/log/syslog when using raspbian OS). Some errors can be safely ignored, like timeout errors that occur when the pump is out of range.

### Don't have permission, permission not allowed, etc

The command you are running likely needs to be run with root permissions, try the same command again with ```sudo ``` in front of it

Bash scripts (.sh files) need execute permissions to run. Run this command to grant execute permissions to the owner of a file.

```
chmod u+x myscript.sh
```

### ValueError: need more than 0 values to unpack

A JSON file did not contain entries.

### Unable to upload to http//my-nightscout-website.com

OpenAPS has failed to upload to the configured nightscout website. If you're using a Medtronic CGM and no BG readings appear in nightscout, connect to your rig and the directory of your openaps app (default is myopenaps) run

`openaps first-upload`

### [No JSON object could be decoded](https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#safe=active&q=openaps+%27No+JSON+object+could+be+decoded%27)

[to be written]

### json: error: input is not JSON
```
json: error: input is not JSON: Unexpected '<' at line 1, column 1:
        <head><title>Document Moved</title></head>
```

  This error usually comes up when you have pulled a file down from Nightscout that was an invalid file. Typically you might see this when trying to pull down treatments. Make sure that you have your HOST and API_KEY set correctly at the top of your cron, in your ~/.profile

### TypeError: Cannot read property 'zzzz' of undefined

example: `TypeError: Cannot read property 'rate' of undefined`

[to be written]

### Could not parse carbratio_date when invoking profile report

    Could not parse carbratio_data.
    Feature Meal Assist enabled but cannot find required carb_ratios.

This error may occur when you invoke `settings/profile.json` report.

Check report definition in `openaps.ini`. If you have line `remainder = []` change it to `remainder = `

Below is correct definition

    [report "settings/profile.json"]
    use = shell
    bg_targets = settings/bg_targets.json
    settings = settings/settings.json
    basal_profile = settings/basal_profile.json
    reporter = text
    json_default = True
    max_iob = preferences.json
    device = get-profile
    remainder =
    insulin_sensitivities = settings/insulin_sensitivities.json

### Could not get subg_rfspy state or version. Have you got the right port/device and radio_type?

Basic steps using an Intel Edison with Explorer Board, checking with `openaps mmtune` to see if it is resolved yet:
  * Make sure the Explorer board has not become loose and is sitting correctly on the Edison board
  * Double check that your port in pump.ini is correct
  * Check that your rig is in close range of your pump
  * Check that your pump battery is not empty
  * Reboot your rig
  * Run `oref0-runagain`
  * Fully power down and start up your rig
  * Remove and re-add your pump device

If you are using an Intel Edison with Explorer Board, and that does not resolve your issue, or if the two LEDs next to the microUSB ports on your Explorer board stay on even after an mmtune, you may need to re-flash your radio chip:
  * Install ccprog tools on your Edison: `cd ~/src; git clone https://github.com/ps2/ccprog.git`
  * Build (compile) ccprog so you can run it: `cd ccprog; make ccprog`
  * Flash the radio chip:
```
wget https://github.com/EnhancedRadioDevices/subg_rfspy/releases/download/v0.8-explorer/spi1_alt2_EDISON_EXPLORER_US_STDLOC.hex
./ccprog -p 19,7,36 erase
./ccprog -p 19,7,36 write spi1_alt2_EDISON_EXPLORER_US_STDLOC.hex
```
  * Reboot, and try `openaps mmtune` to make sure it works


### CareLink RF timeout errors

Some of these errors represent temporary RF communication errors between the CareLink USB Stick and the pump.

* Stick transmit / LinkStatus:error:True / BAD AILING

  * [to be written]

```
Stick transmit[TransmitPacket:ReadPumpModel:size[64]:data:''] reader[ReadRadio:size:0] download_i[3] status[<LinkStatus:0x03:status:size=??LinkStatus:error:True:reason:[]:size(0)>] poll_size[0] poll_i[False] command[<LinkStatus:0x03:status:size=??LinkStatus:error:True:reason:[]:size(0)>]:download(attempts[3],expect[0],results[0]:data[0]):BAD AILING
```

* size (0) is less than 64 and not 15, which may cause an error.

  * [to be written]

* this seems like a problem

  * [to be written]

* bad zero CRC?

  * [to be written]

### mmeowlink RF timeout errors

* mmeowlink.exceptions.InvalidPacketReceived: Error decoding FourBySix packet

  * [to be written]

* Timed out or other comms error - Received an error response Timeout - retrying: 1 of 3

  * [to be written]

* Invalid Packet Received - '' - retrying: 1 of 3

  * [to be written]

* Invalid Packet Received - 'Error decoding FourBySix packet' - retrying: 1 of 3

  * [to be written]

* Response not received - retrying at <built-in function time>

  * [to be written]

