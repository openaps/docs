# Papertrail remote monitoring of OpenAPS logs (optional) 

If you want to remotely view the rig's logs/loops, you can use Papertrail service.  For single rig monitoring, you should be able to use the free Papertrail account without a problem.  Use of this service can help you remotely troubleshoot when the rig has an error.

### Get an account at Papertrail

Go to http://papertrailapp.com and setup a new account.  Choose to setup a new system.  Notice the header at the top of the new system setup that says the path and port that your logs will go to.  You’ll need that information later.

![Papertrail hosting information](../Images/papertrail_host.png)

### Login to your rig

Assuming you are on the same wifi network as your rig, use `ssh root@<edisonhost>.local` replacing <edisonhost> with whatever you have named your edisonhost on your rig.  If not on same network, use screen mode and connect rig with a cable to your computer.  `sudo screen /dev/tty.usbserial-* 115200` 

### System logging 

Copy and paste the code that is displayed in your new system setup's shaded box, as shown in the red arrowed area in the screen shot above. This will setup papertrail for just your syslogs.  But, we now will need to add more (aggregate) your logs such as pump-loop and ns-loop.

### Aggregating logs

* Copy and paste each of these four command lines, one at a time.

`wget https://github.com/papertrail/remote_syslog2/releases/download/v0.19/remote_syslog_linux_i386.tar.gz`

`tar xzf ./remote_syslog*.tar.gz`

`cd remote_syslog`

`sudo cp ./remote_syslog /usr/local/bin`

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

![papertrail log example](../Images/papertrail.png)
