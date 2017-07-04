# General linux and other guide/troubleshooting basic

Some conventions used in this guide:

* Wherever you see text that is formatted `like this`, it is a code snippet. You should copy and paste instead of attempting to type this out; this will save you debugging time for finding your typos.
* You will see a <tt>$</tt> at the beginning of many of the lines of code. This
  indicates that it is to be entered and executed at the terminal prompt. Do not type in the dollar sign <tt>$</tt>.
* Wherever there are `<bracketed_components>` in the the code, these are meant for you to insert your own information. Most of the time, it doesn't matter what you choose **as long as you stay consistent throughout this guide**. That means if you choose `myopenaps` as your  `<myopenaps>`, you must use `myopenaps` every time you see `<myopenaps>`. Choose carefully when naming things. Do not include the `< >` brackets in your name.

### Before you get started

Some familiarity with using the terminal will go a long way, but is not required for getting started.  Terminal (or PuTTY) is basically a portal into your rig, allowing us to use our computer's display and keyboard to communicate with the little [Edison or Pi] computer in your rig.  The active terminal line will show your current location, within the computer's file structure, where commands will be executed.  The line will end with a <tt>$</tt> and then have a prompt for you to enter your command.  

There are many commands that are useful, but some of the commands you'll get comfortable with are: 

* `cd` means "change directory" - you can `cd <directorynamewithnobrackets>` to change into a directory; and `cd ..` will take you backward one directory and `cd` will take you back to the root directory. If you try to `cd` into a file, your computer will tell you that's not going to happen.

* `ls` means "list", is also your friend - it will tell you what is inside a directory. If you don't see what you expect, you likely want to `cd ..` to back up a level until you can orient yourself. If you aren't comfortable with what `cd` and `ls` do or how to use them, take a look at some of the Linux Shell / Terminal commands on the [Troubleshooting](../Resources/troubleshooting.md) page and the reference links on the [Technical Resources](../Resources/technical-resources.md) page. 

* `cat` means "concatenation" - it will show you the contents of a file if you `cat <filename>`.  Very useful when trying to see what you have in preferences or other oref0 files.

* `vi` and `nano` are both editing command prefixes.  Using those will bring you into files for the purposes of editing their contents.  It is like `cat` except you will be able to edit.

One other helpful thing to do before starting any software work is to log your terminal session. This will allow you to go back and see what you did at a later date. This will also be immensely helpful if you request help from other OpenAPS contributors as you will be able to provide an entire history of the commands you used. To enable this, just run `script <filename>` at the beginning of your session. It will inform you that `Script started, file is <filename>`. When you are done, simply `exit` and it will announce `Script done, file is <filename>`. At that point, you can review the file as necessary.

`ls <myopenaps>` will show the following files and subdirectories contained within the directory:
* autotune
* cgm
* cgm.ini
* detect-sensitivity.ini
* determine-basal.ini
* enact
* get-profile.ini
* iob.ini
* meal.ini
* mmtune_old.json
* monitor
* ns-glucose.ini
* ns.ini
* openaps.ini
* oref0.ini
* oref0-runagain.sh
* pebble.ini
* preferences.json
* pump.ini
* pump-session.json
* raw-cgm
* settings
* tz.ini
* units.ini
* upload
* xdrip.ini

`ls settings` will show the contents of the `settings` subdirectory; the files which collect longer-term loop data.  
* autosens.json
* autotune.json	     
* basal_profile.json   
* bg_targets.json      
* bg_targets_raw.json  
* carb_ratios.json	
* insulin_sensitivities.json      
* insulin_sensitivities_raw.json
* model.json			     
* profile.json		     
* pumphistory-24h.json
* pumphistory-24h-zoned.json
* pumpprofile.json
* settings.json
* temptargets.json

`ls monitor` will show the contents of the `monitor` subdirectory; current data going on right now in your loop.
* battery.json
* carbhistory.json
* clock.json
* clock-zoned.json
* edison-battery.json
* glucose.json
* iob.json
* meal.json
* meal.json.new
* mmtune.json
* pumphistory.json        
* pumphistory-zoned.json
* reservoir.json
* status.json
* temp_basal.json

`ls enact` will show the contents of the `enact` subdirectory; loop's suggested and enacted temp basals and changes.
* enacted.json
* suggested.json
