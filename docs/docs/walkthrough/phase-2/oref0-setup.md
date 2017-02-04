# Phase 2: oref0-setup.sh

We've created an oref0-setup.sh script that can help set up a complete working loop configuration from scratch in just a few minutes. This is in pursuit of our community goal to simplify the technical aspects of setting up a DIY closed loop - while still emphasizing that this is a DIY project that you have personal responsibility for. We also want to encourage you to spend more time and energy exploring whether the algorithm you choose to use is doing what you want it to do and that it aligns with how you might manually choose to take action.

Please make sure to complete ALL steps on this page. **If you skip parts of step 0 and step 1, you will run into issues on step 2. **

## Step 0: Dependencies

You first need to install the base openaps toolkit and its dependencies.

### Automated Installation Script

Running this code will install all of the dependencies for you automatically:
 
`curl -s https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-packages.sh | bash -`

If the install was successful, the last line will say something like:
    
    openaps 0.1.5  (although the version number may have been incremented)

If you do not see this or see error messages, try running it multiple times. It will not hurt to run this multiple times.

(Interested in the development repositories? [See this shell script.](https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-src.sh))

### Manual Installation

If you prefer to install the dependencies yourself, the following Debian/Ubuntu packages are required:

    git python python-dev python-software-properties python-numpy python-pip nodejs-legacy npm watchdog

The following [npm](https://docs.npmjs.com/) packages are required:

    json oref0

Finally, these [Python pip](https://pip.pypa.io/en/stable/) packages are required:

    openaps openaps-contrib

## Step 1: Pull/clone oref0

Pull/clone the latest oref0 master by running:

`mkdir -p ~/src; cd ~/src && git clone git://github.com/openaps/oref0.git || (cd oref0 && git checkout master && git pull)`

If you have been looping for awhile, are setting up an additional rig, are comfortable using the advanced features from the master branch, and want to test out the latest features of the oref0 dev branch (which may still be highly experimental) you can use:

`mkdir -p ~/src; cd ~/src && git clone -b dev git://github.com/openaps/oref0.git || (cd oref0 && git checkout dev && git pull)`

## Step 2: Run oref0-setup

__Note:__ If you're using the 915MHz Explorer board, you'll need to log in as root to run oref0-setup.sh, as the mraa package doesn't yet support running under an ordinary user account. Also read below regarding port and other information to enter when running the script.

Run this:

`cd && ~/src/oref0/bin/oref0-setup.sh`

to run the script interactively, or get usage guidelines for providing inputs as command line arguments. 

**Be prepared to enter the following items:** 
* Directory name for your openaps
* serial number of your pump
* the mmeowlink port:
    * /dev/spidev5.1 if using explorer board
    * see [here](https://github.com/oskarpearson/mmeowlink/wiki/Installing-MMeowlink) for other port options
* how you are getting cgm data and cgm serial numbers if needed
* nightscout host and api-secret if using nightscout 
* whether you want any of the oref0 advanced implementations
* whether or not you want to automate your loop (using cron)

**Hint:** if you're not sure if you need something (advanced features), you probably don't, but for more information on the advanced features, see [here](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-4/advanced-features.html). Also, scheduling something in cron means scheduling the loop to run automatically. So if you want an automated closed loop, Yes, you want to schedule it in cron. If you don't want an automated loop yet, you can always come back and run the script again later to automate. In addition, running the script again will update the various packages that the script installs.

**Worldwide pump users**
If you are running from the master branch and not the WW branch, you'll need to follow the instructions at https://github.com/oskarpearson/mmeowlink/wiki/Non-USA-pump-settings to ensure that the correct frequency is used by mmtune.

The very first time may take a while (10-15 minutes) for it to successfully read and pull a full history from your pump. Wait at least 15 minutes when watching the log (see below, step 3) before asking for help. If it looks like it is giving you an error message, make sure you completed step 0 and 1 (see above!). If in doubt, run step 0 and step 1 again, and run the setup script (step 2) again as well. It will not hurt to run it multiple times, but you will probably want to comment out or delete any existing crons before adding another. Go on to the [next page](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-2/troubleshoot-oref0-setup.html) for other ideas of trouble shooting. Read that page's troubleshooting tips before jumping into Gitter with questions about what to try next.

### Re-running the setup script

In the future, you may want to run the setup script again (such as when you want to come back and turn on new, advanced features). To do so, you will be able to run `bash ~/myopenaps/oref0-runagain.sh` to start running the setup script again with those options. (You may first want to `cat oref0-runagain.sh` to see what options you have saved in there.  To run it again with different options, you can copy and paste and modify that output, or you can `nano oref0-runagain.sh` to change what's saved in the file to run the next time.)

## Step 3: Watch the logs

When you decide to enable the new loop in cron, follow the log file (and watch Nightscout) to make sure that it is working properly:

`tail -F /var/log/openaps/pump-loop.log`
