# Troubleshooting oref0-setup script process

Please be patient. It can take 15-20 minutes for your new OpenAPS rig to enact temp basal rates on your insulin pump after powering on for the first time. Your OpenAPS rig can require the same 15-20 minutes if it's been powered off for more than 20 minutes. It often takes less time but don't over-react. Your rig has to establish network connections, pull CGM data, pump history data, and perform complex calculations prior to enacting temp basals. If your insulin pump does not indicate a temp basal after approximately 15-20 minutes, however, you can begin troubleshooting the cause. A simple reboot, instead of a power on, should take much less time.

## Re-run the script again

You won't hurt anything by running the script multiple times. If you already have a working loop and are testing the setup scripts, just make sure to comment out in cron the loop you don't want running.

## Should I enact cron?

Cron is the scheduler that runs the loop. I.e. this is the automation feature to automate your closed loop. If you're using a test pump, it's pretty safe to go ahead and automate your loop. But if you're not sure, you can always come back and do this later.

If you're troubleshooting and looking to use `openaps` manually, cron must be momentarily disabled to free access to local resources.  To check if cron is running use `crontab -e` or `crontab -l`.  If you see a file filled with content, chances are cron is enabled.

To stop cron'd jobs and enter an openaps command:  `killall -g openaps; openaps <whatever>` 

If you'd like to run multiple commands without having to do `killall -g openaps; ` before each one, you can run `sudo service cron stop` first.
<br>
To start cron: `sudo service cron start` or reboot your rig.

To prevent cron running on initial boot, either clear the `crontab -e` file or "comment out" (`#`) each line of the crontab file.  If you've cleared the crontab file, but would like to enable cron'd tasks, rerun the initial setup script (step 2) and indicate you'd like to use cron.  This will regenerate the configuration.

## How do I know if it is working?

Please be patient. We can not emphasize this enough.

* Check your pump to see if it is setting temp basals.
* "Tail" the pump log to see what is is doing: `tail -F /var/log/openaps/pump-loop.log`
* Check Nightscout to see if it is updating with your information. Note: that if Nightscout is not showing your loop is running, it might be running but unable to communicate with Nightscout. In those cases check the pump-loop.log on your rig.

## It's not working yet:

Make sure to check through the following list before asking on Gitter if your setup is not working (yet). Remember if you just ran oref0-setup.sh, wait a good ~20 minutes as mentioned above before seeking help. Time, and the below list of steps, resolves 99% of problems. Also check out [this blog post for tips if asking for help online](https://diyps.org/2017/03/19/tips-for-troubleshooting-diy-diabetes-devices-openaps-or-otherwise/).

* **Check to make sure that your pump is in absolute and not % mode for temp basals.** 
* Did you put in the right SN for the pump? Should be numbers only...
* Check and make sure your pump is near your rig. Closer is better, e.g. check if it works when the pump and rig are at most 20 inches (50 cm) apart.
* Check that your pump battery is not empty.
* Check and make sure your pump is not suspended or stuck in rewind or prime screens. If it's a test pump, you don't even have to fill a reservoir, but put your pinky finger or eraser-end of a pencil in for slight pressure when priming so the pump will "sense" it and stop. Make sure to back out of the prime screen.
* Check to make sure you have a carb ratio set manually in your Medtronic insulin pump, if it is not done, the following display will appear in your pump.log: Could not parse input data: [SyntaxError: /root/myopenaps/monitor/iob.json: Unexpected end of input]
* Check to make sure your carelink and/or radio stick is plugged in.
* Check to make sure your receiver is plugged in, if you're plugging a receiver in.
* Don't have data in Nightscout? Make sure there is no trailing slash `/` on the URL that you are entering and that the API secret is correct. Check your Nightscout URL, too - it's one of the most common errors to mistype that. (And FWIW, you shouldn't be typing things like that in the first place: that's what copy and paste are for.)
* Check and make sure your receiver is >50% charged (if battery low, it may drain the rig battery and prevent it from operating).
* A reboot may be required after running oref0-setup if the Carelink is unable to communicate with the pump (e.g. you see "Attempting to use a port that is not open" errors in pump-loop.log). Additional Carelink troubleshooting steps can be found in [Dealing with the CareLink USB Stick](http://openaps.readthedocs.io/en/latest/docs/Resources/troubleshooting.html#dealing-with-the-carelink-usb-stick).
* 512/712 users - make sure you follow the additional instructions for the 512/712 before asking for help troubleshooting. You have a few additional steps you need to do.

## Running commands manually to see what's not working from an oref0-setup.sh setup process
  
You've probably run into an error in your setup where someone has recommended "running commands manually" to drill down on an error. What to do? Some of the following:
  
 * Start by killing anything that's currently running. ` killall -g oref0-pump-loop`
 * Look and see what's running in your cron. `crontab -l`
 * If you want to do more than one command of debugging, it's best to disable your cronjobs, use `/etc/init.d/cron stop`. Don't forget to start the cronjobs afterwards or reboot your rig to make sure the cronjobs will be running.
 * Run whichever alias is failing to see what commands it is running. I.e. if the pump loop is failing, it's `openaps pump-loop`, which you can run to show what's inside it by `openaps alias show pump-loop`. 
 * Run each of those commands next individually, and that should give you a better idea of where it's failing or getting stuck. Do this, and share back (if needed) with your troubleshooter about where you think it's getting stuck.  If that still doesn't give you or your troubleshooter enough info, keep drilling down further:
   * **For example**, if your pump-loop.log always shows `Error, retrying` after `Old pumphistory:`, then you'd want to run `openaps refresh-old-pumphistory` manually to reproduce the problem and see if you can get more error details.
   * If necessary, you can drill down further.  So in this example, you might want to run `openaps alias show refresh-old-pumphistory` to see what *that* alias does, and then `openaps gather` to drill down further.
   * Don't use `2>/dev/null` or `>/dev/null ` parts of commands, because they will hide output of commands
   * If a command does not return output, check with `echo $?` if the exit code returns `0`. That means OK (no error). If it returns non-zero (e.g. `1`) then the command failed and you need to drill down further. 
   * You can keep drilling down until you get through all the aliases to the actual reports, which can be run manually using a command like `openaps report invoke monitor/status.json` to see the raw unfiltered output with full error details.

