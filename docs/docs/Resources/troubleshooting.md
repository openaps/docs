# Troubleshooting

Even those who follow this documentation precisely are bound to end up stuck at some point. This could be due to something unique to your system, a mistyped command, actions performed out of order, or even a typo in this guide. This section provides some tools to help diagnose the issue as well as some common errors that have been experienced and resolved before. If you get stuck, try re-reading the documentation again and after that, share what you've been working on, attempted steps to resolve, and other pertinent details in [#intend-to-bolus in Gitter](https://gitter.im/nightscout/intend-to-bolus) when asking for help troubleshooting. Here is also a [good blog post to read with tips on how to best seek help online to troubleshoot](https://diyps.org/2017/03/19/tips-for-troubleshooting-diy-diabetes-devices-openaps-or-otherwise/).

What's on this page:

- [Generally useful linux commands](#generally-useful-linux-commands)
- [Dealing with npm run global-install errors](#dealing-with-npm-run-global-install-errors)
- [Dealing with a corrupted git repository](#dealing-with-a-corrupted-git-repository)
- [Debugging Disk Space Issues](#debugging-disk-space-issues)
- [Environment variables](#environment-variables)
- [Wifi and hotspot issues](#wifi-and-hotspot-issues)
   * [My wifi connection keeps dropping or I keep getting kicked out of ssh](#my-wifi-connection-keeps-dropping-or-i-keep-getting-kicked-out-of-ssh)
   * [I forget to switch back to home wifi and it runs up my data plan](#i-forget-to-switch-back-to-home-wifi-and-it-runs-up-my-data-plan)
   * [I am having trouble consistently connecting to my wifi hotspot when I leave the house](#i-am-having-trouble-consistently-connecting-to-my-wifi-hotspot-when-i-leave-the-house)
   * [I am not able to connect to my wireless access point on my iPhone](#i-am-not-able-to-connect-to-my-wireless-access-point-on-my-iphone)
- [Common error messages](#common-error-messages)
   * [Don't have permission, permission not allowed, etc](#permission-not-allowed)
   * [ValueError: need more than 0 values to unpack](#valueerror-need-more-than-0-values-to-unpack)
   * [Unable to upload to Nightscout](#unable-to-upload-to-Nightscout)
   * [No JSON object could be decoded](#no-json-object-could-be-decoded)
   * [json: error: input is not JSON](#json-error-input-is-not-json)
   * [TypeError: Cannot read property 'zzzz' of undefined](#typeerror-cannot-read-property-zzzz-of-undefined)
   * [Could not parse carbratio date when invoking profile report](#could-not-parse-carbratio-date-when-invoking-profile-report)
   * [Could not get subg rfspy state or version ccprog](#could-not-get-subg-rfspy-state-or-version-ccprog)
   * [Dealing with the CareLink USB Stick](#dealing-with-the-carelink-usb-stick)

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

## Dealing with npm run global-install errors

If you get an error while running an `npm global-install`, you may be able to clear it by running the following commands:

`rm -rf /usr/lib/node_modules/.staging/ && rm -rf ~/src/oref0 && cd ~/src && git clone git://github.com/openaps/oref0.git || (cd oref0 && git checkout master && git pull)`

then run `cd ~/src/oref0 && git checkout master && git pull` or if you are running dev then `cd ~/src/oref0 && git checkout dev && git pull`

then run `cd ~/src/oref0 && npm run global-install` and then re-run oref0-setup.

## Dealing with a corrupted git repository

In oref0 versions prior to oref0 0.6.0, OpenAPS used git as the logging mechanism, so it commits report changes on each report invoke. Sometimes, due to "unexpected" power-offs (battery dying, unplugging, etc.),the git repository gets broken. You may see an error that references a loose object, or a corrupted git repository. To fix a corrupted git repository you can run `oref0-reset-git`, which will first run `oref0-fix-git-corruption` to try to fix the repository, and in case when repository is definitely broken it copies the .git history to a temporary location (`tmp`) and initializes a new git repo. In some versions of oref0 (up to 0.5.5), `oref0-reset-git` is in cron so that if the repository gets corrupted it can quickly reset itself. 

If you're still having git issues, you should `cd ~/myopenaps; rm -rf .git ; git init` . If you do this, git will re-initialize from scratch.  This only applies to 0.5.x (or earlier) or upgrades to dev from master and does not apply to a fresh 0.6.x install.

Warning: do not run any openaps commands with sudo in front of it `sudo openaps`. If you do, your .git permissions will get messed up. Sudo should only be used when a command needs root permissions, and openaps does not need that. Such permission problems can be corrected by running `sudo chown -R pi.pi .git` in the openaps directory.  If you are using an Intel Edison, run `sudo chown -R edison.users .git`.

oref0 0.6.x and beyond will not use git and will not have git-related errors to deal with.

## Debugging Disk Space Issues

If you are having errors related to disk space shortages as determined by `df -h`, but you still have some room on your /root drive (i.e., it is not 100% in use), you can use a very lightweight and fast tool called ncdu (a command-line disk usage analyzer) to determine what folders and files on your system are using the most disk space. You can install ncdu as follows: `sudo apt-get install ncdu`. You can run it by running the following command: `cd / && sudo ncdu` and follow the interactive screen to find your disk hogging folders.

An alternative approach to disk troubleshooting is to simply run the following command from the base unix directory after running `cd /`:

`du -xh -d 3 | egrep "[1-9][0-9][0-9]M|[0-9]G"` (reports disk usage of all directories 3 levels deep from the current directory)

Then, based on which folders are using the most space cd to those folders and run the above du command again until you find the folder that is using up the disk space.

One potential culprit can be cached software packages, which can be removed with `sudo apt-get clean` and/or `sudo apt-get autoremove --purge`

It is also common that log files (i.e., the /var/log directory) are the cause for disk space issues. If you determine that log file(s) are the problem, use a command like `less` to view the last entries in the logfile to attempt to figure out what is causing the logfile to fill up. If you still have some room on your /root drive (i.e., it is not 100% in use according to `df /root`), you can temporarily free up space by forcing the logfiles to rotate immediately, with the following command:

`logrotate -f /etc/logrotate.conf`

If your /root drive is 100% in use according to `df /root`, you may need to free up space by removing log files. It should be safe to remove archived log files with the command `rm /var/log/*.[0-9] /var/log/*.gz`. Check again with `df /root` that you have plenty of space - normally your /root drive should have 80% or less space in use. If you have more in use but still less than 100% you can use one of the above techniques to free more space. 

If your disk is still 100% full, you may have to remove a live log file. Run the command `du /var/log/openaps/* /var/log/*|sort -n |tail -5`, which will show the largest 5 log files. Pick the largest file, use the command `less` to view the last entries to determine if there is a problem, and when you're sure you don't need the file any longer you can use the command `rm log_file_name` to delete it (replace log_file_name with the large log file's name). You should `reboot` after removing any of the live log files so the system resumes logging properly.

## Environment variables

If you are getting your BG from Nightscout or you want to upload loop status/results to Nightscout, among other things you'll need to set 2 environment variables: `NIGHTSCOUT_HOST` and `API_SECRET`. If you do not set and export these variables you will receive errors while running `openaps report invoke monitor/ns-glucose.json` and while executing `ns-upload.sh` script which is most probably part of your `upload-recent-treatments` alias.Make sure your `API_SECRET` is in hashed format. Please see [this page](https://github.com/openaps/oref0#ns-upload-entries) or [this issue](https://github.com/openaps/oref0/issues/397) for details. Additionally, your `NIGHTSCOUT_HOST` should be in a format like `http://yourname.herokuapp.com` (without trailing slash). For the complete visualization guide use [this page](https://github.com/openaps/docs/blob/master/docs/Automate-system/vizualization.md) from the OpenAPS documentation.

## Wifi and hotspot issues

### My wifi connection keeps dropping or I keep getting kicked out of ssh
There is a script that you can add to your root cron that will test your connection and reset it if it is down. Here is an example that runs every two minuntes (odd minutes). You could also do it every 5 minutes or less. Note, this does not have to be for an Edison, you can set this up for a Pi, etc as well.

```
cd ~/src
git clone https://github.com/TC2013/edison_wifi
cd edison_wifi
chmod 0755 /root/src/edison_wifi/wifi.sh
```
Next, add the script to your root cron. Note this is a different cron that what your loops runs on, so when you open it don't expect to see your loop and other items you have added.
  * Log in as root ```su root```
  * Edit your root cron ```crontab -e```
  * Add the following line ```1-59/2 * * * * /root/src/edison_wifi/wifi.sh google.com 2>&1 | logger -t wifi-reset```

### I forget to switch back to home wifi and it runs up my data plan
You can add a line to your cron that will check to see if `<YOURWIFINAME>` is available and automatically switch to it if you are on a different network.
  * Log in as root ```su root```
  * Edit your root cron ```crontab -e```
  * Add the following line ```*/2 * * * * ( (wpa_cli status | grep <YOURWIFINAME> > /dev/null && echo already on <YOURWIFINAME>) || (wpa_cli scan > /dev/null && wpa_cli scan_results | egrep <YOURWIFINAME> > /dev/null && sudo wpa_cli select_network $(wpa_cli list_networks | grep jsqrd | cut -f 1) && echo switched to <YOURWIFINAME> && sleep 15 && (for i in $(wpa_cli list_networks | grep DISABLED | cut -f 1); do wpa_cli enable_network $i > /dev/null; done) && echo and re-enabled other networks) ) 2>&1 | logger -t wifi-select```

### I am having trouble consistently connecting to my wifi hotspot when I leave the house
When you turn on your hotspot it will only broadcast for 90 seconds and then stop (even if it is flipped on). So, when you leave your house you need to go into the hotspot setting screen (and flip on if needed). Leave this screen open until you see your rig has connected. It may only take a few seconds or a full minute.

### I am not able to connect to my wireless access point on my iPhone 
Consider changing your iPhone's name...  In most cases iPhone will set the phone's SSID to something like "James’s iPhone"  By default Apple puts a curly apostrophe (’) into the SSID instead of a straight one (').  Your choices from here are either paste in the curly apostrophe in wpa_supplicant.conf, or change the name on the phone.  To change the name on the iPhone:
   * On your iOS device, go to Settings > General > About.
   * Tap the first line, which shows the name of your device.
   * Rename your device, then tap Done.

## Common error messages

**WARNING:** Pay close attention to errors. An error may indicate a serious operational or functional problem with a computer system or component.

These error messages may appear in response to openaps commands in the console, or in the system log (located at /var/log/syslog when using raspbian OS). Some errors can be safely ignored, like timeout errors that occur when the pump is out of range.

### Permission not allowed

The command you are running likely needs to be run with root permissions, try the same command again with ```sudo ``` in front of it

Bash scripts (.sh files) need execute permissions to run. Run this command to grant execute permissions to the owner of a file.

```
chmod u+x myscript.sh
```

### ValueError: need more than 0 values to unpack

A JSON file did not contain entries. It usually will self-resolve with the next successful pump history read.

### Unable to upload to Nightscout

OpenAPS has failed to upload to the configured nightscout website. If you're using a Medtronic CGM and no BG readings appear in nightscout, connect to your rig and the directory of your openaps app (default is myopenaps) run

`openaps first-upload`

### No JSON object could be decoded

Usually means the file does not exist. It usually will self-resolve with the next successful pump history read. If it recurs, you will need to [drill down](http://openaps.readthedocs.io/en/latest/docs/Troubleshooting/oref0-setup-troubleshooting.html#running-commands-manually-to-see-what-s-not-working-from-an-oref0-setup-sh-setup-process) to find the area where it is not successfully reading. 

### json: error: input is not JSON
```
json: error: input is not JSON: Unexpected '<' at line 1, column 1:
        <head><title>Document Moved</title></head>
```

  This error usually comes up when you have pulled a file down from Nightscout that was an invalid file. Typically you might see this when trying to pull down treatments. Make sure that you have your HOST and API_KEY set correctly at the top of your cron, in your ~/.profile

### TypeError: Cannot read property 'zzzz' of undefined

example: `TypeError: Cannot read property 'rate' of undefined`

Usually is related to a typo if you have manually been editing files. Otherwise, should self-resolve.

### Could not parse carbratio date when invoking profile report

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

### Could not get subg rfspy state or version ccprog or cannot connect to CC111x radio

Full error is usually: 
`Could not get subg_rfspy state or version. Have you got the right port/device and radio_type? (ccprog)`

Or (on an intel edison):
`cannot connect to CC111x radio on /dev/spidev5.1`

Basic steps using an Intel Edison with Explorer Board or a Raspberry Pi with Explorer HAT:
  * checking with `killall -g oref0-pump-loop; openaps mmtune` to see if it is resolved yet
  * Make sure the Explorer board or HAT has not become loose and is sitting correctly on the Edison board or Pi
  * Check that your rig is in close range of your pump
  * Check that your pump battery is not empty
  * Reboot, or fully power down and start up your rig

If you are using an Intel Edison with Explorer Board or a Raspberry Pi with Explorer HAT, and that does not resolve your issue, or if the two LEDs next to the microUSB ports on your Explorer board (respectively D1/D2 on Explorer HAT) stay on even after an mmtune, you may need to re-flash your radio chip:
  * Stop the reboot loop: `sudo service cron stop && killall -g oref0-pump-loop && shutdown -c`
  * Install ccprog tools on your Edison: `cd ~/src; git clone https://github.com/ps2/ccprog.git`
  * Build (compile) ccprog so you can run it: `cd ccprog; make ccprog`
  * If using a Raspberry Pi with Explorer HAT make sure you've installed MRAA (folder `~/src/mraa` present)
  * Flash the radio chip:
  
#### Using an Intel Edision + Explorer Block:
```
wget https://github.com/EnhancedRadioDevices/subg_rfspy/releases/download/v0.8-explorer/spi1_alt2_EDISON_EXPLORER_US_STDLOC.hex
./ccprog -p 19,7,36 erase
./ccprog -p 19,7,36 write spi1_alt2_EDISON_EXPLORER_US_STDLOC.hex
```
If you receive an error saying that ccprog is only tested on C1110 chips then reboot the rig and try again. i.e.
```
reboot
```
Then:
``` 
cd ~/src/ccprog
./ccprog -p 19,7,36 erase
./ccprog -p 19,7,36 write spi1_alt2_EDISON_EXPLORER_US_STDLOC.hex
```


#### Using a Raspberry Pi + Explorer HAT:
```
wget https://github.com/EnhancedRadioDevices/subg_rfspy/releases/download/v0.8-explorer/spi1_alt2_EDISON_EXPLORER_US_STDLOC.hex
./ccprog -p 16,18,7 reset
./ccprog -p 16,18,7 erase
./ccprog -p 16,18,7 write spi1_alt2_EDISON_EXPLORER_US_STDLOC.hex
```

  * Reboot, and try `killall -g oref0-pump-loop; openaps mmtune` to make sure it works
  
  
### Monitor/mmtune.json is empty or does not exist
#### Only verified to work with Intel Edison + Explorer Block
Full error is:
```
cannot connect to CC111x radio on /dev/spidev5.1
1999/12/31 19:14:23 cc111x: no response
monitor/mmtune.json is empty or does not exist
```
Trying to reflash the radio may result in:
```
Erasing chip.
This code is only tested on CC1110. Unsupported chip id = 0x00.
Chip erase failed.
```
If you're affected by this particular issue, the two LEDs next to the microUSB ports on your Explorer board may stay on continuously, or they may flash during loop attempts, but stay on between loops. If this is the case, you may need to completely reinstall OpenAPS. This requires redoing everything from the Jubilinux flash, to the bootstrap script and finally the OpenAPS setup. 

**Note:** Starting the Jubilinux flash from the beginning will overwrite everything, so you may want to copy and save any configuration files you don't want to lose, like your `wpa_supplicant.conf` Wi-Fi settings for example. 

Instructions to reinstall OpenAPS are [here](https://openaps.readthedocs.io/en/latest/docs/Build%20Your%20Rig/OpenAPS-install.html#step-1-jubilinux-for-edison-rigs-only)

Once you have finished running the OpenAPS setup script, view your loop by entering `l`. Your loop will probably still be failing, but with a different error message:
```
Could not get subg_rfspy state or version. Have you got the right port/device and radio_type?
```
Now you should be able to follow [the directions above](https://openaps.readthedocs.io/en/latest/docs/Resources/troubleshooting.html?highlight=ccprog#could-not-get-subg-rfspy-state-or-version-ccprog-or-cannot-connect-to-cc111x-radio) to reflash the radio.
This time the reflash should be successful and you should see:
```
Erasing chip.
Chip erased.
root@yourrig:~/src/ccprog# ./ccprog -p 19,7,36 write spi1_alt2_EDISON_EXPLORES_STDLOC.hex
```
Press enter, then you should see:
```
Writing 2769 bytes to flash....
```
You have now successfully reflashed the radio. Now `reboot` and your loop should start running with red and green LEDs off (except for an occasional blink).


## Dealing with the CareLink USB Stick

**Note:** Generally, the Carelink stick is no longer supported. We *highly* recommend moving forward with a different radio stick. See [the hardware currently recommended in the docs](http://openaps.readthedocs.io/en/latest/docs/Gear%20Up/hardware.html), or ask on Gitter. 

The `model` command is a quick way to verify whether you can communicate with the pump. Test this with `openaps use <my_pump_name> model` (after you do a `killall -g oref0-pump-loop`).

If you can't get a response, it may be a range issue. The range of the CareLink radio is not particularly good, and orientation matters; see [range testing report](https://gist.github.com/channemann/0ff376e350d94ccc9f00) for more information.

Sometimes the Carelink will get into an unresponsive state that it will not recover from without help. You can tell this has happened if the pump is within range of the Carelink and you see a repeating series of "Attempting to use a port that is not open" or "ACK is 0 bytes" errors in pump-loop.log. When this happens the Carelink can be recovered by rebooting or physically unplugging and replugging the CareLink stick.

Once you're setting up your loop, you may want to detect these errors and recover the Carelink programmatically. This can be done by running oref0-reset-usb (`oref0-reset-usb.sh`) to reset the USB connection. For example, you could create a cron job that would run `openaps use <my_pump_name> model`, or tail the 100 most recent lines in pump-loop.log, and grep the output looking for the errors noted above. If grep finds the errors, the cron job would run oref0-reset-usb. Just note that during USB reset you will lose the connection to all of your USB peripherals. This includes your Wi-Fi connection if your rig uses a USB Wi-Fi dongle.
