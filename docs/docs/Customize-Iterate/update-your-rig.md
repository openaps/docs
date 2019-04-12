# How to update oref0 on your OpenAPS rig in the future

You've probably heard about all kinds of cool new features that you want to try. If they're part of the master branch already, you just need to go enable them (usually by [re-running the oref0-setup script](http://openaps.readthedocs.io/en/latest/docs/Customize-Iterate/oref0-runagain.html)). You can see notes about what is included in a particular release in [the release notes page for oref0](https://github.com/openaps/oref0/releases).

However, if it's a brand-new feature that's being tested or is recently added to master, you'll need to install the new version of `oref0` first.  By the way, if you want to check which version of oref0 you are currently running, `npm list -g oref0` and if you want to check which branch `cd ~/src/oref0` and then `git branch`. 

<details>
<summary> If you want to view the commit records between the version you are running and the new version (click here):</summary>
<br>
 
1. `cd ~/src/oref0`
2. `git fetch` will update the local git repository. This does not change anything in your working directory
3. `git status` will tell you which branch your working directory is on and how many commits your working directory is behind
4. `git log origin/master` (replace `master` with the branch you are on) will print the commit descriptions. You only need to review the number of log messages corresponding to the number of commites your working directory is behind.
5. `git diff origin/master..` (replace `master` with the branch you are on) will print the individual file differences between your working copy and the new version.

</details>

## Step 1 (Master): Install the new version

1. `cd ~/src/oref0 && git checkout master && git pull && sudo npm install -g oref0`

*(If you get a message that you need to commit or stash, use command `git stash`*)

### Alternative Step 1a (Dev): To get on "dev" branch to test even more recently added new stuff

Or, if the feature you want hasn't been released yet, and you want to test the latest untested development version of `oref0`, run:

1. `cd ~/src/oref0 && git checkout dev && git pull`
2. `npm run global-install`

### Alternative Step 1b (Test a feature branch): Not recommended for initial setup

<details>
<summary>Not recommended for initial setup, click here to see instructions</summary>
<br>

In case you want to test even more advanced stuff you've read about on gitter channels ([intend-to-bolus](https://gitter.im/nightscout/intend-to-bolus) / [openaps/oref0](https://gitter.im/openaps/oref0) / [openaps/autotune](https://gitter.im/openaps/autotune)) or on [official pull request list](https://github.com/openaps/oref0/pulls) you should follow the link, read description and in case you've decided to try it out, do:

1. Checkout the header of pull request. It will contain author name, the branch to be merged to (dev or master) and the feature branch name that you want to test.
2. run `cd ~/src/oref0 && git fetch && git checkout <feature-branch-name> && git pull && npm run global-install`
  * don't forget to replace `<feature-branch-name>` with the actual name of the feature branch you want to test
 
 
</details> 

## Step 2: Re-run oref0-setup

Now that you've updated your `oref0` version, you will want to run the oref0-setup script (`cd && ~/src/oref0/bin/oref0-setup.sh`) again. See [this section](http://openaps.readthedocs.io/en/latest/docs/Build%20Your%20Rig/OpenAPS-install.html#be-prepared-to-enter-the-following-information-into-oref0-setup) for a guide of what the setup script will be prompting you to enter.

## Step 3: Remember to set your preferences!

Reminder! You'll need to re-set your preferences in `preferences.json`. See [the preferences page](http://openaps.readthedocs.io/en/latest/docs/While%20You%20Wait%20For%20Gear/preferences-and-safety-settings.html) to see what preferences might have changed or become available since your last update. 

 To edit any of your preferences, you can enter `edit-pref` (as a shortcut) or `cd ~/myopenaps && nano preferences.json`

## How to update Linux on your OpenAPS rig in the future

Along with updating the OpenAPS software on your rig, you will also want to periodically update your operating system. This isn't the place for a primer on [Linux Commands](http://www.circuitbasics.com/useful-raspberry-pi-commands/), but the following two are useful to keep your system updated and as secure as they can be from recently-found bugs:

```bash
# apt-get update
# apt-get upgrade
```

The first fetches all of the updated package lists for your system, and the second upgrades all of your installed packages to their most current versions. 
