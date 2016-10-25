# Phase 2: oref0-setup.sh

We've created an oref0-setup.sh script that can help set up a complete working loop configuration from scratch in just a few minutes. This is in pursuit of our community goal to simplify the technical aspects of setting up a DIY closed loop - while still emphasizing that this is a DIY project that you have personal responsibility for. We also want to encourage you to spend more time and energy exploring whether the algorithm you choose to use is doing what you want it to do and that it aligns with how you might manually choose to take action.

__Step 0:__
You first need to install the base openaps toolkit and its dependencies. Running this code will do this for you. 
 
`curl -s https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-packages.sh | bash -`

If the install was successful, the last line will say something like:
    
    openaps 0.1.5  (although the version number may have been incremented)

If you do not see this or see error messages, try running the script multiple times.

(Interested in the development repositories? [See this shell script.](https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-src.sh))

__Step 1:__
Pull/clone the latest oref0 dev by running:

`mkdir -p ~/src; cd ~/src && git clone -b dev git://github.com/openaps/oref0.git || (cd oref0 && git checkout dev && git pull)`

__Step 2:__ 

`cd && ~/src/oref0/bin/oref0-setup.sh`

to run the script interactively, or get usage guidelines for providing inputs as command line arguments. Be prepared to enter the following items: Directory name for your openaps; serial number of your pump; the mmeowlink port if using it (/dev/spidev5.1 if using explorer board, see [here](https://github.com/oskarpearson/mmeowlink/wiki/Installing-MMeowlink) for other port options); how you are getting cgm data and cgm serial numbers if needed; nightscout host and api-secret if using nightscout; whether you want any of the oref0 advanced implementations. 

Hint: if you're not sure if you need something (advanced features), you probably don't. Also, scheduling something in cron means scheduling the loop to run automatically. So if you want an automated closed loop, Yes, you want to schedule it in cron. If you don't want an automated loop yet, you can always come back and run the script again later to automate.

__Note:__ If you're using the 915MHz Explorer board, you'll need to log in as root to run oref0-setup.sh, as the mraa package doesn't yet support running under an ordinary user account.

__Step 3:__ 
When you decide to enable the new loop in cron, follow the log file (and watch Nightscout) to make sure that it is working properly:

`tail -F /var/log/openaps/pump-loop.log`


