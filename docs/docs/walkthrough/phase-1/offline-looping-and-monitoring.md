# Offline monitoring

There are a number of ways to have an "offline" OpenAPS rig, and numerous ways to monitor offline.

## Offline looping

Medtronic CGM users can, by default, automatically loop offline because the rig will read CGM data directly from the pump.

Dexcom CGM users and users of other CGMs will have alternatives to input blood glucose values localy.  
* 1.) Use xDrip see: http://stephenblackwasalreadytaken.github.io/xDrip/ 
* 2.) Hardwire (plugging CGM receiver into) your rig. 

  * Explorer boards built prior to late January of 2017 are not always working well/automatically with a CGM receiver plugged in. This can be fixed with a signal trace cut, but doing so will break the ability to re-flash your Edison. Please make sure you have a second Explorer board or another base block or breakout board that you can use to re-flash the Edison if needed before considering this modification. For more details, see [this issue](https://github.com/EnhancedRadioDevices/915MHzEdisonExplorer/issues/14), and if you decide to make the cut, see [this document for details on how to cut the copper trace from pin 61 of the 70 pin connector](https://github.com/EnhancedRadioDevices/915MHzEdisonExplorer/wiki#usb-otg-flakiness). Cut in two places and dig out the copper between. Cut by poking a razor point in. Avoid the narrow trace above the one being cut.
  * Explorer Boards that shipped the end of February 2017/first week of March 2017 should enable users to simply plug in the CGM receiver and a second battery (in addition to the lipo) in order to run offline and pull BGs from the receiver. 


## Offline monitoring

* See Pancreabble instructions below for connecting your rig to your watch
* See xDrip instructions below for seeing offline loop status
* See HotButton instructions below for setting temp targets and controlling your rig offline via an Android

### Note about recovery from Camping Mode/Offline mode for Medtronic CGM users:

If you have been running offline for a significant amount of time, and use a Medtronic CGM, you may need to run

```
openaps first-upload
```
from inside your openAPS directory, before your loop will start updating correctly to your nightscout site.

### Pancreabble

_(TO DO Note - Pancreabble instructions for OpenAPS need to be re-worked to reflect the oref0-setup script way of making it work. Below is notes about Pancreabble setup prior to oref0-setup.sh being in existence.)_

[Pancreabble] is a way to monitor your loop _locally_, by pairing a Pebble smartwatch directly with the Raspberry Pi or Intel Edison.

In other words, whereas the default setup looks like this:

```
Raspberry Pi/Intel Edison -> network -> Nightscout server -> network -> smartphone
                                                                     |
                                                                     -> laptop
                                                                     |
                                                                     -> Pebble watch
```

And by default, your Pebble is paired thus:

```
               smartphone -> Bluetooth -> Pebble watch
```

With Pancreabble, the setup looks like this:

```
Raspberry Pi/Intel Edison -> Bluetooth -> Pebble watch
```

Using a Pebble watch can be especially helpful during the "open loop" phase: you can send the loop's recommendations directly to your wrist, making it easy to evaluate the decisions it would make in different contexts during the day (before/after eating, when active, etc.).

See [Pancreabble] for initial setup instructions.

[Pancreabble]: https://github.com/mddub/pancreabble

Once you've done the first stages above, you'll need to do generate a status file that can be passed over to the Pebble Urchin watch face. Fortunately, the core of this is available in oref0.

Go to `~src/oref0/bin` and look for `peb-urchin-status.sh`. This gives you the basic framework to generate output files that can be used with Pancreabble. To use it, you'll need to install jq using:

`apt-get install jq`

If you get errors, you may need to run `apt-get update` ahead of attempting to install jq.

Once jq is installed, the shell script runs and produces the `urchin-status.json` file which is needed to update the status on the pebble. It can be incorporated into an alias that regularly updates the pebble. You can modify it to produce messages that you want to see there.

When installing the oref0-setup you will need to replace all instances of AA:BB:CC:DD:EE:FF with the Pebble MAC address. This can be found in Settings/System/Information/BT Address.

Once you've installed, you will need to pair the watch to your Edison.
### Bluetooth setup

* Restart the Bluetooth daemon to start up the bluetooth services.  (This is normally done automatically by oref0-online once everything is set up, but we want to do things manually this first time):

`sudo killall bluetoothd`

* Wait a few seconds, and run it again, until you get `bluetoothd: no process found` returned.  Then start it back up again:

`sudo /usr/local/bin/bluetoothd --experimental &`

* Wait at least 10 seconds, and then run:

`sudo hciconfig hci0 name $HOSTNAME`

* If you get a `Can't change local name on hci0: Network is down (100)` error, start over with `killall` and wait longer between steps.

* Now launch the Bluetooth control program: `bluetoothctl`

* And run: `power off`

* then `power on`

* and each of the following:

```
discoverable on

scan on

agent on

default-agent
```

On Pebble
********************************
Settings/BLUETOOTH to make sure Pebble is in pairing mode

from terminal 

`trust AA:BB:CC:DD:EE:FF`
`pair AA:BB:CC:DD:EE:FF`

you might need to do this several times before it pairs

you will see on the edison

`Request confirmation
[agent] Confirm passkey 123456 (yes/no): yes`

* (WARNING: You must type in **yes** not just **y** to pair)

Once paired, type quit to exit.


Currently the `peb-urchin-status.sh` has 1 notification and 3 different options for urchin messages.
in you APS directory there is a file called 'pancreoptions.json' 
```
"urchin_loop_on": true,  <--- to turn on or off urchin watchface update
"urchin_loop_status": false, <--- Gives a message on urchin watchface that it's running
"urchin_iob": true,   <--- Gives a message on urchin watchface of current IOB
"urchin_temp_rate": false, <--- Gives a message on urchin watchface of current temp basal
"notify_temp_basal": false <--- Notificaiton of temp basal when one shows up in enact/suggested.json
```
note only one of the messages for the urchin watchface can be true at once

the `peb-urchin-status.sh` gets called from the crontab and will run automatically.
By default the urchin_loop_on, and urchin_iob is set to true. You must manually change notify_temp_basal to true to start getting temp basal notifications. 
you can edit this file using `nano pancreoptions.json` from your APS directory.

### xDripAPS for offline BGs

This is a REST microservice designed to allow xDrip CGM data to be used in OpenAPS. **Note as of 1/26/17:** The below documentation is WIP and needs additional testing.

Do you use OpenAPS and xDrip? Until now, this usually means you need an internet connection to upload your CGM data to Nightscout and then have OpenAPS download it from there to use in your loop. This repository allows you to get your CGM data from xDrip into OpenAPS without the need for an internet connection.

xDripAPS is a lightweight microservice intended to be used on Raspberry Pi or Intel Edison OpenAPS rigs. Users of the xDrip Android app can use the "REST API Upload" option to send CGM data to this service. The service stores the data in a SQLite3 database. The service can be invoked from within OpenAPS to retrieve CGM data. This approach allows for offline/camping-mode looping. No internet access is required, just a local, or "personal" network between the Android phone and the OpenAPS rig (using either WiFi hotspotting or bluetooth tethering).

As of oref0 v0.4.0 (Jan 2017), support for xDripAPS is now included in the OpenAPS oref0-setup.sh script. When running the oref0-setup.sh script, you will be prompted to specify a CGM type (e.g. MDT, G4). You can specify "xdrip" (without the quotes). This will install xDripAPS and all dependencies. Alternatively, manual installation instructions can be found at the bottom of this page.

#### Overview of xDripAPS
With xDripAPS, the flow of data is as follows -

(1) CGM transmitter --> (2) xDrip/xDrip+ Android app --> (3) OpenAPS rig (e.g. Edison) --> (4) Nightscout

1. Usually a Dexcom G5, or G4 plus xDrip wireless bridge.
2. Either xDrip or xDrip+ can be used. In the app, the REST API Upload feature is normally used to upload CGM data to Nightscout. Instead, we use this feature to upload to xDripAPS on your OpenAPS rig (further details below).
3. Your OpenAPS rig - usually a Raspberry Pi or an Intel Edison.
4. The xDrip app is now uploading your data to xDripAPS on your OpenAPS rig rather than to Nightscout. OpenAPS will now upload your CGM data to Nightscout as well as treatments, pump status, etc. So your Nightscout site will still be updated. Note that it will take a couple of minutes longer for CGM data to reach Nightscout, compared with when uploading directly from xDrip.

#### Setup Steps (using oref0-setup.sh script)

##### Setting up your OpenAPS rig
Install OpenAPS as per the documentation. When running the oref0-setup script, you will be prompted to specify a CGM source. Enter "xdrip" (without the quotes).

##### Connect your Android phone and your OpenAPS rig
For the xDrip app on your Android phone to be able to send CGM data to xDripAPS on your OpenAPS rig, they need to be connected to the same "personal" network. Note that an internet connection is not required - this solution allows you to loop without internet connectivity. Data which is 'missing' from Nightscout will be uploaded when you regain internet connectivity.

There are two approaches for establishing a "personal" network between your phone and your OpenAPS rig. The first is to run a WiFi hotspot on your phone and connect your OpenAPS rig to the WiFi network your phone exposes. This is the easiest option, but there are two drawbacks - it drains your phone battery quickly, and your phone cannot connect to a normal WiFi network while the WiFi hotspot is enabled (it can connect to the internet via 3G/4G when coverage is available).

The other option is to enable bluetooth tethering on your phone and have your OpenAPS rig connect to it. This does not drain the phone's battery as quickly and means that the phone can still connect to a normal WiFi network for internet access when available (and to 3G/4G networks when WiFi is not available). I use this approach 24/7 - my OpenAPS rig is permanently tethered to my Nexus 6P phone. I can get a full day of phone usage without running out of battery, unless I make a lot of calls or have a lot of screen-on time.

Instructions on both approaches can be found in the main OpenAPS documentation.

##### Configuring the xDrip Android app
First, determine your OpenAPS rig's IP address within your "personal" network. If you can open a terminal session to your rig via serial, then `ifconfig wlan0` (when using the WiFi hostpost option) or `ifconfig bnep0` (when using bluetooth tethering) will display your IP address. Alternatively, you can use an Android app - there are lots of "Network IP Scanner" apps in the Play store. The Hurricane Electric Network Tools app works with both the WiFi hotspot and BT tethering options.

Then, open xDrip or xDrip+ settings and in the REST API Upload setting, configure the following URL -

`http://<api_secret>@<rig_ip_address>:5000/api/v1/`

Note: ensure you enter http:// (NOT https://). <api_secret> is the plain-text API secret you used when you set up OpenAPS/Nightscout and <rig_ip_address> is the IP address of your OpenAPS rig (starting 192.168). For example, this is the value I have configured (I have obscured my API secret) -

![REST API Upload setting](https://github.com/colinlennon/xDripAPS/blob/master/xDrip_REST_API_cropped.png "REST API Upload setting")

If using xDrip+ you also need to navigate to Settings > Cloud Upload > MongoDB and ensure that the "Skip LAN uploads" option is NOT selected. If you don't have this setting, update to a recent version of the xDrip+ app. (This option was added to a nightly build around December 2016).

#### Manual installation steps

##### N.B. It is recommended that you use the oref0-setup script as described above, rather than installing manually.

1. Install SQLite3 -

  a. Raspbian -
    ```
    apt-get install sqlite3
    ```

  b. Yocto -
    ```
    cd ~
    wget https://sqlite.org/2016/sqlite-tools-linux-x86-3150200.zip
    unzip sqlite-tools-linux-x86-3150200.zip
    mv sqlite-tools-linux-x86-3150200 sqlite
    ```

2. Get dependencies -
  ```
  pip install flask
  pip install flask-restful
  ```

3. Clone this repo -
  ```
  cd ~
  git clone https://github.com/colinlennon/xDripAPS.git .xDripAPS
  ```

4. Create directory for database file -
  ```
  mkdir -p ~/.xDripAPS_data
  ```

5. Add cron entry to start the microservice at startup -
  e.g. -
  `@reboot         python /home/root/.xDripAPS/xDripAPS.py`

6. Cofigure the xDrip Android app -
  `xDrip > Settings > REST API Upload > Set Enabled and enter Base URL: http://[API_SECRET]@[Pi/Edison_IP_address]:5000/api/v1/`
 
  (Note: Enter your plain-text API_SECRET in the Android app, not the hashed version of it).


7. Use the microservice within OpenAPS
  e.g.
  ```
  openaps device add xdrip process 'bash -c "curl -s http://localhost:5000/api/v1/entries?count=288"'
  openaps report add monitor/glucose.json text xdrip shell
  ```

### Hot Button

#### Purpose
[Hot Button app](https://play.google.com/store/apps/details?id=crosien.HotButton) can be used to monitor and control OpenAPS using SSH commands. It is especialy useful for offline setups. Internet connection is not required, it is enough to have the rig connected to your android smartphone using bluetooth tethering.

#### App Setup 
To setup the button you need to long click. Setup the Server Settings and set them as default. For every other button you can load them.

#### Basic commands
To the Command part of the button setup you can write any command which you would run in the ssh session. For example to show the automatic sensitivity ratio, you can set:
`cat /root/myopenaps/settings/autosens.json`

After button click the command is executed and the results are displayed in the black text area bellow the buttons. 

#### Temporary targets
It is possible to use Hot Button application for setup of temporary targets.  This [script](https://github.com/lukas-ondriga/openaps-share/blob/master/start-temp-target.sh) generates the custom temporary target starting at the time of its execution. You need to edit the path to the openaps folder inside it.

To setup activity mode run:
`./set_temp_target.sh "Activity Mode" 130`

To setup eating soon mode run:
`./set_temp_target.sh "Eating Soon" 80`

The script is currently work in progress. The first parameter is probably not needed, it is there to have the same output as Nightscout produces. It is not possible to set different top and bottom target, but this could be easily added in the future. 
To be able to use the script, the most straigtforward solution is to disable the download of temporary targets from Nightscout. To do that edit your openaps.ini and remove `openaps ns-temptargets` from ns-loop. 

#### SSH Login Speedup
To speed up the command execution you can add to the `/etc/ssh/sshd_config` the following line:
`UseDNS no`
