# How to update your OpenAPS rig in the future

You've probably heard about all kinds of cool new features that you want to try. If they're part of the master branch already, you just need to go enable them (usually by [re-running the oref0-setup script](oref0-setup.md#re-running-the-setup-script)). 

However, if it's a brand-new feature that's being tested or is recently added to master, you'll need to install the new version of `oref0` first.

## To get the new stuff from the newest released version of oref0

1. `sudo npm install -g oref0`

## To get on "dev" branch to test even more recently added new stuff

Or, if the feature you want hasn't been released yet, and you want to test the latest untested development version of `oref0`, run:

1. `cd ~/src/oref0 && git checkout dev && git pull`
2. `npm run global-install`

## Re-run oref0-setup

Now that you've updated your `oref0` version, you can [re-run the oref0-setup script](oref0-setup.md#re-running-the-setup-script) to use it.
