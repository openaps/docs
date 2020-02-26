# Common error messages

**WARNING:** Pay close attention to errors. An error may indicate a serious operational or functional problem with a computer system or component.

These error messages may appear in response to openaps commands in the console, or in the system log (located at /var/log/syslog when using raspbian OS). Some errors can be safely ignored, like timeout errors that occur when the pump is out of range.

## Permission not allowed

The command you are running likely needs to be run with root permissions, try the same command again with ```sudo ``` in front of it

Bash scripts (.sh files) need execute permissions to run. Run this command to grant execute permissions to the owner of a file.

```
chmod u+x myscript.sh
```

## ValueError: need more than 0 values to unpack

A JSON file did not contain entries. It usually will self-resolve with the next successful pump history read.

## Unable to upload to Nightscout

OpenAPS has failed to upload to the configured nightscout website. If you're using a Medtronic CGM and no BG readings appear in nightscout, connect to your rig and the directory of your openaps app (default is myopenaps) run

`openaps first-upload`

## No JSON object could be decoded

Usually means the file does not exist. It usually will self-resolve with the next successful pump history read. If it recurs, you will need to [drill down](<../Troubleshooting/oref0-setup-troubleshooting#running-commands-manually-to-see-what-s-not-working-from-an-oref0-setup-sh-setup-process>) to find the area where it is not successfully reading. 

## json: error: input is not JSON
```
json: error: input is not JSON: Unexpected '<' at line 1, column 1:
        <head><title>Document Moved</title></head>
```

  This error usually comes up when you have pulled a file down from Nightscout that was an invalid file. Typically you might see this when trying to pull down treatments. Make sure that you have your HOST and API_KEY set correctly at the top of your cron, in your ~/.profile

## TypeError: Cannot read property 'zzzz' of undefined

example: `TypeError: Cannot read property 'rate' of undefined`

Usually is related to a typo if you have manually been editing files. Otherwise, should self-resolve.

## Could not parse carbratio date when invoking profile report

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

## Could not get subg rfspy state or version ccprog or cannot connect to CC111x radio

Full error is usually: 
`Could not get subg_rfspy state or version. Have you got the right port/device and radio_type? (ccprog)`

Or (on an intel edison):
`cannot connect to CC111x radio on /dev/spidev5.1`

Or (on a Raspberry Pi):
`cannot connect to CC111x radio on /dev/spidev0.0`

Basic steps using an Intel Edison with Explorer Board or a Raspberry Pi with Explorer HAT:
  * checking with `cd ~/myopenaps && sudo service cron stop && killall -g openaps ; killall-g oref0-pump-loop; oref0-mmtune && sudo service cron start` to see if it is resolved yet
  * Make sure the Explorer board or HAT has not become loose and is sitting correctly on the Edison board or Pi
  * Check that your rig is in close range of your pump
  * Check that your pump battery is not empty
  * Reboot, or fully power down and start up your rig

If you are using an Intel Edison with Explorer Board or a Raspberry Pi with Explorer HAT, and that does not resolve your issue, or if the two LEDs next to the microUSB ports on your Explorer board (respectively D1/D2 on Explorer HAT) stay on even after an mmtune, you may need to re-flash your radio chip:
  * Stop the reboot loop: `sudo service cron stop && killall-g oref0-pump-loop && shutdown -c`
  * (for versions >0.7.0) Install MRAA (you only need to do this once per rig): `oref0-mraa-install`
  * Reboot manually, and if necessary stop the reboot loop again: `sudo service cron stop && killall-g oref0-pump-loop && shutdown -c`
  * Install ccprog tools on your Edison: `cd ~/src; git clone https://github.com/ps2/ccprog.git`
  * Build (compile) ccprog so you can run it: `cd ccprog; make ccprog`
  * If using a Raspberry Pi with Explorer HAT make sure you've installed MRAA (folder `~/src/mraa` present)
  * Flash the radio chip:
  
### Using an Intel Edision + Explorer Block:
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

### Using a Raspberry Pi + Explorer HAT:
```
wget https://github.com/EnhancedRadioDevices/subg_rfspy/releases/download/v0.8-explorer/spi1_alt2_EDISON_EXPLORER_US_STDLOC.hex
./ccprog -p 16,18,7 reset
./ccprog -p 16,18,7 erase
./ccprog -p 16,18,7 write spi1_alt2_EDISON_EXPLORER_US_STDLOC.hex
```

  * Reboot, and try `cd ~/myopenaps && sudo service cron stop && killall -g openaps ; killall-g oref0-pump-loop; oref0-mmtune && sudo service cron start` to make sure it works
  
  
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

## Memory or disk space errors

If you are having errors related to disk space shortages as determined by `df -h`, but you still have some room on your /root drive (i.e., it is not 100% in use), you can use a very lightweight and fast tool called ncdu (a command-line disk usage analyzer) to determine what folders and files on your system are using the most disk space. You can install ncdu as follows: `sudo apt-get install ncdu`. You can run it by running the following command: `cd / && sudo ncdu` and follow the interactive screen to find your disk hogging folders.

An alternative approach to disk troubleshooting is to simply run the following command from the base unix directory after running `cd /`:

`du -xh -d 3 | egrep "[1-9][0-9][0-9]M|[0-9]G"` (reports disk usage of all directories 3 levels deep from the current directory)

Then, based on which folders are using the most space cd to those folders and run the above du command again until you find the folder that is using up the disk space.

It is common that log files (i.e., the /var/log directory) are the cause for disk space issues. If you determine that log file(s) are the problem, use a command like `less` to view the last entries in the logfile to attempt to figure out what is causing the logfile to fill up. If you still have some room on your /root drive (i.e., it is not 100% in use according to `df /root`), you can temporarily free up space by forcing the logfiles to rotate immediately, with the following command:

`logrotate -f /etc/logrotate.conf`

If your /root drive is 100% in use according to `df /root`, you may need to free up space by removing log files. It should be safe to remove archived log files with the command `rm /var/log/*.[0-9] /var/log/*.gz`. Check again with `df /root` that you have plenty of space - normally your /root drive should have 80% or less space in use. If you have more in use but still less than 100% you can use one of the above techniques to free more space. 

If your disk is still 100% full, you may have to remove a live log file. Run the command `du /var/log/openaps/* /var/log/*|sort -n |tail -5`, which will show the largest 5 log files. Pick the largest file, use the command `less` to view the last entries to determine if there is a problem, and when you're sure you don't need the file any longer you can use the command `rm log_file_name` to delete it (replace log_file_name with the large log file's name). You should `reboot` after removing any of the live log files so the system resumes logging properly.

## Errors during `openaps report invoke monitor/ns-glucose.json` or `ns-upload.sh`

If you are getting your BG from Nightscout or you want to upload loop status/results to Nightscout, among other things you'll need to set 2 environment variables: `NIGHTSCOUT_HOST` and `API_SECRET`. This is handled in the setup script. If you do not set and export these variables you will receive errors while running `openaps report invoke monitor/ns-glucose.json` and while executing `ns-upload.sh` script which is most probably part of your `upload-recent-treatments` alias.Make sure your `API_SECRET` is in hashed format. Please see [this page](https://github.com/openaps/oref0#ns-upload-entries) or [this issue](https://github.com/openaps/oref0/issues/397) for details. Additionally, your `NIGHTSCOUT_HOST` should be in a format like `http://yourname.herokuapp.com` (without trailing slash). For the complete guide to setting up Nightscout see [this page](<../While You Wait For Gear/nightscout-setup>).