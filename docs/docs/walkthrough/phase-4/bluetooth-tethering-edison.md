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

agent on

default-agent
```

For Android
********************************
The adapter is now discoverable for three minutes. Search for bluetooth devices on your phone and initiate pairing. The process varies depending on the phone and the dongle in use. The phone may provide a random PIN and bluetoothctl may ask you to confirm it. Enter 'yes'. Then click 'pair' on the phone. 

For iPhone
********************************
you must use the edison to initiate pairing
```
pair AA:BB:CC:DD:EE:FF
```
********************************
you will see on the edison

`Request confirmation
[agent] Confirm passkey 123456 (yes/no): yes`

You must type in **yes** not just **y** to pair

After, the phone may ask you to enter a PIN. If so, enter '0000' and when bluetoothctl asks for a PIN, enter the same code again. Either way, bluetoothctl should inform you that pairing was successful. It will then ask you to authorize the connection - enter 'yes'.

Then on your phone you can hit the pair button that popped up.

Execute the paired-devices command to list the paired devices -

```
paired-devices
Device AA:BB:CC:DD:EE:FF Samsung S7
```

Your paired phone should be listed (in this example, a Samsung Galaxy S7). Copy the bluetooth address listed for it; we will need to provide this later.

Now trust the mobile device 

`trust AA:BB:CC:DD:EE:FF`

Quit bluetoothctl with 'quit'.

******************************
**For Testing**
Option 1 - If you are still on your home wifi you can test to see if you can pair by running (this only works with the Android)
```
sudo killall bluetoothd; sudo /usr/local/bin/bluetoothd --experimental &

sudo hciconfig hci0 name $HOSTNAME
```
then
```
sudo bt-pan client AA:BB:CC:DD:EE:FF
```
Option 2 - If you have a serial console connection to your Edison and are using wpa_supplicant, you can comment out your home wifi in `nano /etc/wpa_supplicant/wpa_supplicant.conf`, then reboot. (takes about 1 min after reboot for the Bluetooth Network to connect)

Option 3 - Take a walk, and as soon as you are out of range of your wifi, you should see that a device is connected to your personal network. Shortly after that you will see things update on nightscout.

This has been tested with a Samsung Galaxy S7, and a iPhone 6s and has proven reliable for some people - but not all. Further testing is needed. So let it be known if you are able to get this to work or if you have problems.  

