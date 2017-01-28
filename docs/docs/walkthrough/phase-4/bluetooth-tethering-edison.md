# Bluetooth tethering on Edison (optional) 

## Configure Bluetooth Low Energy tethering on Edison running Jubilinux [optional] This is still in testing as of 1-25-17 

The Intel Edison can be tethered to a smartphone and share the phone's internet connection. Bluetooth tethering needs to be enabled and configured on the phone device and your carrier/plan must allow tethering. 

The main advantages of using BLE tethering are that it consumes less power on the phone device than running a portable WiFi hotspot. The way the script is currently setup, the Edison will try to connect to Wifi first, if it is unable to connect, it will then try to connect with your paired phone. So once you are away from your home wifi, as long as you have the Bluetooth tethering turned on, on your phone, it should automatically connect and get online. 

Currently the Bluetooth Tethering is only availble on the dev branch of oref0, so clone/pull the branch by running:

`mkdir -p ~/src; cd ~/src && git clone -b dev git://github.com/openaps/oref0.git || (cd oref0 && git checkout dev && git pull)`

Install the dev branch to get the new oref0-online to work:

`cd ~/src/oref0/ && npm run global-install`

You will need to get the MAC address from your phone or whatever device you are using.
* On Android, go to Settings/About Phone/ Status; you will a Bluetooth adress looking like AA:BB:CC:DD:EE:FF 
* On iPhone, go to Settings/General/About and it will be under Bluetooth and will look like AA:BB:CC:DD:EE:FF

Now we need to re-run oref0-setup with the Bluetooth option, replacing AA:BB:CC:DD:EE:FF with what you found above.  If you have the "To run again with these same options" command-line from the last time you ran oref0-setup, you can simply run that and append `--btmac=AA:BB:CC:DD:EE:FF` to the end.  If not, you can run it interactively using:

`cd && ~/src/oref0/bin/oref0-setup.sh --btmac=AA:BB:CC:DD:EE:FF`

Copy and paste the "To run again with these same options" command into your notes for the next time you need to run oref0-setup.

The first time running the script will take quite a bit longer as it is installing Bluez on your edison.
The oref0-setup script may fail after installing the Bluez.  If so, just reboot your edison and run the command you copied to your notes. 

note if you have rebooted the board (which you will have to on an Explorer board) you must run the following command to startup the bluetooth servies, this is needed because at this point in time, you are more than likely connected to your normal Wifi network. and the oref0-online script is run only runs this if the wifi network is not connected. so this will allow you to pair your BT to your phone while running on your home network. 

```
sudo killall bluetoothd

sudo /usr/local/bin/bluetoothd --experimental &

sudo hciconfig hci0 name $HOSTNAME

bluetoothctl

power off

power on

discoverable on

scan on

agent on

default-agent
```

For Android
********************************
The adapter is now discoverable for three minutes. Search for bluetooth devices on your phone and initiate pairing. The process varies depending on the phone and the dongle in use. The phone may provide a random PIN and bluetoothctl may ask you to confirm it. Enter 'yes'. Then click 'pair' on the phone. 

For iPhone
********************************
Your iPhone must be on the Settings/Bluetooth screen, and then you must use the Edison to initiate pairing:
```
pair AA:BB:CC:DD:EE:FF
```
********************************
you will see on the edison

`Request confirmation
[agent] Confirm passkey 123456 (yes/no): yes`

You must type in **yes** not just **y** to pair

On your phone, tap the pair button that popped up.

Execute the paired-devices command to list the paired devices -

```
paired-devices
Device AA:BB:CC:DD:EE:FF Samsung S7
```

Your paired phone should be listed (in this example, a Samsung Galaxy S7). 

Now trust the mobile device 

`trust AA:BB:CC:DD:EE:FF`

Quit bluetoothctl with 'quit'.

******************************

*Testing*

Before testing your connection, first restart the Bluetooth daemon:

`sudo killall bluetoothd`

wait a moment, hit enter, and you should get a message like `[1]   Done                    sudo /usr/local/bin/bluetoothd --experimental`.  After that, or after a few more seconds, run:

`sudo /usr/local/bin/bluetoothd --experimental &`

and then

`sudo hciconfig hci0 name $HOSTNAME`

Make sure your phone's hotspot is enabled (but don't let anything connect via wifi).

Now, try to establish a Bluetooth Network connection with your phone:

`sudo bt-pan client AA:BB:CC:DD:EE:FF`

You should see an indicator on your phone (a blue bar on iPhone) that your Bluetooth network connection has established.  Next you'll need to get an IP address:

`sudo dhclient bnep0`

If that succeeds, you should be able to run `ifconfig bnep0` and see something like:

```
bnep0     Link encap:Ethernet  HWaddr 98:4f:ee:03:a6:91
          inet addr:172.20.10.4  Bcast:172.20.10.15  Mask:255.255.255.240
```
(for iPhone, the inet addr will always start with 172.20.10. - Android will likely be different)

To disconnect the connection, you can run:

`sudo bt-pan client -d AA:BB:CC:DD:EE:FF`

Next, to test that Bluetooth starts up automatically, you can shut down your wifi for 2-3 minutes by running:

`iwconfig wlan0 txpower off; sleep 120; iwconfig wlan0 txpower auto`

About 1 min later, your bluetooth network should connect.  If it doesn't, you should be able to wait 3 minutes and reconnect.  If that doesn't work, you'll either need to reboot it or use a serial console connection to your Edison to troubleshoot further.

About a minute after wifi comes back on, your Edison should automatically disconnect the Bluetooth connection.

Finally, it's time to take a walk.  About a minute after walking out of range of your wifi, you should see that a device is connected to your phone via Bluetooth. Shortly after that you should see things update on Nightscout.  About a minute afer you come home, it should reconnect to wifi and automatically disconnect Bluetooth.
