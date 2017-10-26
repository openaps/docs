# How to update your OpenAPS rig in the future

You've probably heard about all kinds of cool new features that you want to try. If they're part of the master branch already, you just need to go enable them (usually by [re-running the oref0-setup script](http://openaps.readthedocs.io/en/latest/docs/Customize-Iterate/oref0-runagain.html)).

However, if it's a brand-new feature that's being tested or is recently added to master, you'll need to install the new version of `oref0` first.  By the way, if you want to check which version of oref0 you are currently running, `npm list -g oref0` and if you want to check which branch `cd ~/src/oref0` and then `git branch`. 

## Step 1: Install the new version

#### Recommended: To get the new stuff from the newest released master version of oref0

1. `cd ~/src/oref0 && git checkout master && git pull && sudo npm install -g oref0`

*(If you get a message that you need to commit or stash, use command `git stash`*)

##### **Optional: To get on "dev" branch to test even more recently added new stuff**

Or, if the feature you want hasn't been released yet, and you want to test the latest untested development version of `oref0`, run:

1. `cd ~/src/oref0 && git checkout dev && git pull`
2. `npm run global-install`


##### **Optional 2 | !!NOT RECOMMENDED FOR INITIAL SETUP!!

In case you want to test even more advanced stuff you've read about on gitter channels ([intend-to-bolus](https://gitter.im/nightscout/intend-to-bolus) / [openaps/oref0](https://gitter.im/openaps/oref0) / [openaps/autotune](https://gitter.im/openaps/autotune)) or on [official pull request list](https://github.com/openaps/oref0/pulls) you should follow the link, read description and in case you've decided to try it out, do:

1. Checkout the header of pull request. It will contain author name, branch (dev or master; make sure that you're on dev!) and git-name-that-was-worked-on by this pull request
2. run 'cd ~/src/oref0 && git fetch && git checkout <git-name-that-was-worked-on> && git pull && npm run global-install'
  * don't forget to exchange git-name-that-was-worked-on

## Step 2: Re-run oref0-setup

Now that you've updated your `oref0` version, you will want to run the oref0-setup script (`cd && ~/src/oref0/bin/oref0-setup.sh`) again. See [this section](http://openaps.readthedocs.io/en/latest/docs/Build%20Your%20Rig/OpenAPS-install.html#be-prepared-to-enter-the-following-information-into-oref0-setup) for a guide of what the setup script will be prompting you to enter.

## Step 3: Remember to set your preferences!

Reminder! You'll need to re-set your preferences in `preferences.json`. See [the preferences page](http://openaps.readthedocs.io/en/latest/docs/While%20You%20Wait%20For%20Gear/preferences-and-safety-settings.html) to see what preferences might have changed or become available since your last update. 

 To edit any of your preferences, you can enter `edit-pref` (as a shortcut) or `cd ~/myopenaps && nano preferences.json`


