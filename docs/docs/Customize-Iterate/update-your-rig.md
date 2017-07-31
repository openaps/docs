# How to update your OpenAPS rig in the future

You've probably heard about all kinds of cool new features that you want to try. If they're part of the master branch already, you just need to go enable them (usually by [re-running the oref0-setup script](http://openaps.readthedocs.io/en/latest/docs/Build Your Rig/OpenAPS-install.html#re-running-the-setup-script)).

However, if it's a brand-new feature that's being tested or is recently added to master, you'll need to install the new version of `oref0` first.  By the way, if you want to check which version of oref0 you are currently running, `npm list -g oref0` and if you want to check which branch `cd ~/src/oref0` and then `git branch`. 

## Step 1: Install the new version

#### Recommended: To get the new stuff from the newest released master version of oref0

1. `cd ~/src/oref0 && git checkout master && git pull && sudo npm install -g oref0`

*(If you get a message that you need to commit or stash, use command `git stash`*)

##### **Optional: To get on "dev" branch to test even more recently added new stuff**

Or, if the feature you want hasn't been released yet, and you want to test the latest untested development version of `oref0`, run:

1. `cd ~/src/oref0 && git checkout dev && git pull`
2. `npm run global-install`

## Step 2: Re-run oref0-setup

Now that you've updated your `oref0` version, you will want to run the oref0-setup script (`cd && ~/src/oref0/bin/oref0-setup.sh`) again. See [this section](http://openaps.readthedocs.io/en/latest/docs/Build%20Your%20Rig/OpenAPS-install.html#be-prepared-to-enter-the-following-information-into-oref0-setup) for a guide of what the setup script will be prompting you to enter.
