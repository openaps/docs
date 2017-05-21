# Understanding all the ways to monitor your rigs

* Papertrail
* Accessing via SSH
* NS
* Pebble
* Pushover



## Papertrail remote monitoring of OpenAPS logs (RECOMMENDED) 

If you want to remotely view the rig's logs/loops, you can use Papertrail service.  We highly recommend setting up this service for at least the first month of your OpenAPS use to help remotely and quickly troubleshoot your rig, if you have problems.  The first month of Papertrail comes with a very generous amount of free data.  If you decide you like the service, you can sign up for monthly plan.  Typically, the monthly cost for using Papertrail with OpenAPS is approximately $5-7 depending on how many rigs you use and how long you'd want to save old data.

### Get an account at Papertrail

Go to http://papertrailapp.com and setup a new account.  Choose to setup a new system.  Notice the header at the top of the new system setup that says the path and port that your logs will go to.  You’ll need that information later.

![Papertrail hosting information](../../Images/papertrail_host.png)

### Login to your rig

Assuming you are on the same wifi network as your rig, use `ssh root@<edisonhost>.local` replacing <edisonhost> with whatever you have named your edisonhost on your rig.  If not on same network, use screen mode and connect rig with a cable to your computer.  `sudo screen /dev/tty.usbserial-* 115200` 

### System logging 

Copy and paste the code that is displayed in your new system setup's shaded box, as shown in the red arrowed area in the screen shot above. This will setup papertrail for just your syslogs.  But, we now will need to add more (aggregate) your logs such as pump-loop and ns-loop.

### Aggregating logs

* Copy and paste each of these four command lines, one at a time.  The screenshot below shows the successful results of each command.  The first command will run for a short time and end with similar information to the green box.  The remaining three commands will not display anything specific as a result of the command.

`wget https://github.com/papertrail/remote_syslog2/releases/download/v0.19/remote_syslog_linux_i386.tar.gz`

`tar xzf ./remote_syslog*.tar.gz`

`cd remote_syslog`

`sudo cp ./remote_syslog /usr/local/bin`

![Papertrail aggregating](../../Images/aggregating_logs.png)

* Create the file that will store all the logs you'd like to aggregate:

`vi /etc/log_files.yml`

* press "i" to enter INSERT mode, and then copy and paste the following (updating your host and port on the lines shown to match what your new system info shows as described above):

```
files:
 -  /var/log/openaps/pump-loop.log
 -  /var/log/openaps/autosens-loop.log
 -  /var/log/openaps/ns-loop.log
 -  /var/log/openaps/network.log
 -  /var/log/openaps/autotune.log
destination:
  host: logs5.papertrailapp.com # NOTE: change this to YOUR papertrail host!
  port: 12345   # NOTE: change to your Papertrail port
  protocol: tls
```
type ESC and ":wq" to save changes and exit.

* Start a new aggregate

`sudo remote_syslog`

Now you should be able to see your new logs in your papertrail, but we need to make it so this runs automatically when the rig is restarted.

### Install auto restart at reboot

* Create a new file that will restart the papertrail logging at reboot

`vi /etc/systemd/system/remote_syslog.service`

* press "i" to enter INSERT mode, and then copy and paste the following:

```
[Unit]
Description=remote_syslog2
Documentation=https://github.com/papertrail/remote_syslog2
After=network-online.target

[Service]
ExecStartPre=/usr/bin/test -e /etc/log_files.yml
ExecStart=/usr/local/bin/remote_syslog -D
Restart=always
User=root
Group=root

[Install]
WantedBy=multi-user.target
```

type ESC and ":wq" to save changes and exit.

* enable the reboot service by using these two commands, one at a time.

`systemctl enable remote_syslog.service`

`systemctl start remote_syslog.service`

* reboot your rig to test the papertrail

`reboot`

and then go to your papertrailapp website to see the log

![papertrail log example](../../Images/papertrail.png)

### Optimize Papertrail use

To make the most of your Papertrail logs, setting up some of your account settings and filters will help streamline your troubleshooting

#### Account Filters

Adding filters to your incoming Papertrail logs will help minimize unuseful data (and help keep you below your data caps) and streamline your review of your relevant OpenAPS logs.  You can go to your Papertrail account's `Settings` and then choose the `Log Destinations`. Click on `Log Filters` to go to the screen where you can add specific filters.

![papertrail log destinations](../../Images/log_destinations.png)

Click on the `Add Log Filter` button and add three filters for `CRON`, `libmraa`, and `sudo`.  Save the changes and within 60 seconds, your logs will be filtered.  The CRON, libmraa, and sudo logs usually provide very little help for troubleshooting OpenAPS problems.  You can always undo these filters, if you want to see what those provide in the future.

![papertrail log filters](../../Images/log_filters.png)

#### Saved Filters

Unfortunately, Papertrail does not currently have an app for use on mobile devices.  Instead, you will be using an internet browser to view your papertrail.  Setting up saved filters, in advance, can help you sort through your logs more efficiently.  Most OpenAPS troubleshooting will involve either wifi connection issues or pump communications.  Some helpful filters to find those issues fastest are:

* `pump-loop.log` to see just your pump loop...similar to using the `l` command when logged into your rig.  If you see that pump history is having errors, look at your pump tuning results (filter below).  If you have good tuning results (tuning in the -80s or lower), but the pump is still not responding with a pump history...wait about 15 minutes.  If it still doesn't respond, try rebooting the rig or changing your pump battery if it is low.

* `pump-loop.log 916` will show just your pump tuning results.  If you see `916, 0, -99` tuning results, then you know that your rig is not getting a useable communication with your pump.  Try moving your pump and rig closer together.  Check if your pump battery is good.

* `network` will show just your oref0-online results and whether/which wifi network your rig is connected to.  If you see results of `192.168.1.XX`, then your rig is likely connected to a wifi network.  If you see results of `172.20.10.XX` then your rig is likely connected to your phone's personal hotspot.

* `pump-loop.log adjust` will show your basal and ISF adjustments being made by autosens, if enabled.

If you are running multiple rigs, you can also setup these filters to include the hostname of a particular rig, if you want to filter just for that rig.  For example, this screenshot below would be setting and saving up a filter for a particular rig with the hostname of `edison1` and only for its pump-loop.log.  

![papertrail log filters](../../Images/save_filter.png)

Once you get your desired filters saved, it is an easy process to make them more accessible on your mobile device by using the `add to homescreen` button.  For example, below are the quick links to the saved filters for an OpenAPS user with three rigs...

![papertrail homescreen buttons](../../Images/papertrail_home_buttons.png)

