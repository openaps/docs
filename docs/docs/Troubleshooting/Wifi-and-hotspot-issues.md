# Wifi and hotspot issues

## My wifi connection keeps dropping or I keep getting kicked out of ssh
There is a script that you can add to your root cron that will test your connection and reset it if it is down. Note, this does not have to be for an Edison, you can set this up for a Pi, etc as well.

```
cd ~/src
git clone https://github.com/TC2013/edison_wifi
cd edison_wifi
chmod 0755 /root/src/edison_wifi/wifi.sh
```
Next, add the script to your root cron. Note this is a different cron that what your loops runs on, so when you open it don't expect to see your loop and other items you have added. Here is an example that runs every two minutes (odd minutes). You could also do it every 5 minutes or less. 
  * Log in as root ```su root```
  * Edit your root cron ```crontab -e```
  * Add the following line ```1-59/2 * * * * /root/src/edison_wifi/wifi.sh google.com 2>&1 | logger -t wifi-reset```

## I forget to switch back to home wifi and it runs up my data plan
You can add a line to your cron that will check to see if `<YOURWIFINAME>` is available and automatically switch to it if you are on a different network.
  * Log in as root ```su root```
  * Edit your root cron ```crontab -e```
  * Add the following line ```*/2 * * * * ( (wpa_cli status | grep <YOURWIFINAME> > /dev/null && echo already on <YOURWIFINAME>) || (wpa_cli scan > /dev/null && wpa_cli scan_results | egrep <YOURWIFINAME> > /dev/null && sudo wpa_cli select_network $(wpa_cli list_networks | grep jsqrd | cut -f 1) && echo switched to <YOURWIFINAME> && sleep 15 && (for i in $(wpa_cli list_networks | grep DISABLED | cut -f 1); do wpa_cli enable_network $i > /dev/null; done) && echo and re-enabled other networks) ) 2>&1 | logger -t wifi-select```

## I am having trouble consistently connecting to my wifi hotspot when I leave the house
When you turn on your hotspot it will only broadcast for 90 seconds and then stop (even if it is flipped on). So, when you leave your house you need to go into the hotspot setting screen (and flip on if needed). Leave this screen open until you see your rig has connected. It may only take a few seconds or a full minute.

## I am not able to connect to my wireless access point on my iPhone 
Consider changing your iPhone's name.  In most cases iPhone will set the phone's SSID to something like "James’s iPhone"  By default Apple puts a curly apostrophe (’) into the SSID instead of a straight one (').  Your choices from here are either paste in the curly apostrophe in wpa_supplicant.conf, or change the name on the phone.  To change the name on the iPhone:
   * On your iOS device, go to Settings > General > About.
   * Tap the first line, which shows the name of your device.
   * Rename your device, then tap Done.