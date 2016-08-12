# Wifi Troubleshooting

## My wifi connection keeps dropping and/or I keep getting kicked out of ssh
There is a script that you can add to your root cron that will test your connection and reset it if it is down. Here is an example that runs every two minuntes (odd minutes). You could also do it every 5 minutes or less. Note, this does not have to be for an Edison, you can set this up for a Pi, etc as well.

```
cd ~/src
git clone https://github.com/TC2013/edison_wifi
cd edison_wifi
chmod 0755 /home/edison/src/edison_wifi/wifi.sh
```
Next, add the script to your root cron. Note this is a different cron that what your loops runs on, so when you open it don't expect to see your loop and other items you have added.
  * Log in as root ```su root```
  * Edit your root cron ```crontab -e```
  * Add the following line ```1-59/2 * * * * /home/edison/src/edison_wifi/wifi.sh google.com 2>&1 | logger -t wifi-reset```

## I forget to switch back to home wifi and it runs up my data plan
You can add a line to your cron that will check to see if <YOURWIFINAME> is avaiable and automatically switch to it if you are on a different network.
  * Log in as root ```su root```
  * Edit your root cron ```crontab -e```
  * Add the following line ```*/2 * * * * ( (wpa_cli status | grep <YOURWIFINAME> > /dev/null && echo already on <YOURWIFINAME>) || (wpa_cli scan > /dev/null && wpa_cli scan_results | egrep <YOURWIFINAME> > /dev/null && udo pa_cli select_network $(wpa_clilist_networks | grep jsqrd | cut -f 1) && echo switched to <YOURWIFINAME> && sleep 15 && (for i in $(wpa_cli list_networks | grep DISABLED | cut -f 1); do wpa_cli enable_network $i > /dev/null; done) && echo and re-enabled other networks) ) 2>&1 | logger -t wifi-select```

## I am having trouble consistently connecting to my wifi hotspot when I leave the house (iPhone)
When you turn on your hotspot it will only broadcast for 90 seconds and then stop (even if it is flipped on). So, when you leave your house you need to go into the hotspot setting screen (and flip on if needed). Leave this screen open until you see your rig has connected. It make only take a few seconds or a full minute.
