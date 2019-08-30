# Re-running the setup script

In the future, you may want to run the setup script again (such as when you want to come back and turn on new, advanced features), or if someone asks you to "cat your runagain", which means to display this file so we can analyze the contents.

**First**: `cd ~/myopenaps && cat oref0-runagain.sh` to see what options you have saved in there.

If you want to **edit** the file: `cd ~/myopenaps && nano oref0-runagain.sh` to edit, ctrl-x to save when finished. *Make sure to change `myopenaps` to your openaps directory name if you chose something non-standard when you ran oref0-setup originally.*

To **run again**: `bash ~/myopenaps/oref0-runagain.sh` will run oref0-setup with the options you have saved in the runagain file. 

Don't have a runagain or want to start fresh? `cd && ~/src/oref0/bin/oref0-setup.sh`

Because you're re-running, **remember you will need to also re-do adjustments to your `preferences.json` once you finish re-running setup with either of the methods above. You can do that by `edit-pref`.** 

Note: The following items are not impacted by re-running the setup script:

- Wifi settings
- Bluetooth tethering (assuming you have not changed the Bluetooth address you entered during the initial setup)
- Papertrail settings (assuming you are update to the openaps directory name used in your intial setup, typically `myopenaps`)
