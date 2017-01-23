# Setting Up Your Intel Edison

The Intel Edison system comes with a very limited Operating System. It's best to replace this with a custom version of Debian, so that the config is as-close to the Raspberry Pi as possible. This fits best with OpenAPS, and it also means you have the latest security and stability patches. (These setup instructions were pulled from the mmeowlink wiki; if you're an advanced user and want/need to use Ubilinux instead of the recommended Jubilinux, [go here](https://github.com/oskarpearson/mmeowlink/wiki/Prepare-the-Edison-for-OpenAPS).) The setup instructions also are going to assume you're using the Explorer Board that has a built in radio stick. If you're using any other base board and/or any other radio sticks (TI, ERF, Rileylink, etc.), check out [the mmeowlink wiki](https://github.com/oskarpearson/mmeowlink/wiki) for support of those hardware options.

## Helpful notes before you get started
Your Explorer Board has 2 micro USB connectors, they both provide power. On the community developed Edison Explorer Board the port labeled OTG is for flashing, and the one labeled UART provides console login. You must connect both ports to your computer to complete the flash process.

You must use a DATA micro USB to USB cable. How do you know if your cable is for data? One good way is to plug the cable into your computer USB port and the explorer board OTG port. If your folder/window explorer shows Edison as a drive then the cable supports data.

## Prerequisites

### If you’re using a Raspberry Pi to flash:

To flash the Edison using a Raspberry Pi, you’ll need a large (preferably 16GB+) SD card for your Pi.  The Edison image is almost 2GB, so you’ll not only need space for the compressed and uncompressed image, but you’ll also need to enable a large swapfile on your Pi to fit the image into virtual memory while it is being flashed.  Using an SD card as memory is very slow, so allow extra time to flash the Edison image using a Pi.

  - Run `sudo bash -c 'echo CONF_SWAPSIZE=2000 > /etc/dphys-swapfile'` to configure a 2GB swap file.
     *Note: if you don't have enough space on the SD card for a 2G swap a 1G swap will probably work*
  -  Run `sudo /etc/init.d/dphys-swapfile stop` and then `sudo /etc/init.d/dphys-swapfile start` to enable the new swap file.
  -  If you installed `watchdog` on the pi, it's a good idea to stop it since loading the image into memory to flash is intensive

### If you're using a Windows PC:

- Install the [Intel Edison drivers for Windows]( https://software.intel.com/en-us/iot/hardware/edison/downloads). Select the "Windows standalone driver" download. You do not need to reflash the Edison or setup security or Wi-Fi with this tool because later steps in this process will overwrite those settings.
- Install [PuTTY]( http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html). Download the installation file that matches your PC's architecture (32-bit or 64-bit).

Windows PCs with less than 6 GB of RAM  may need to have the size of the page file increased to flash the Edison. Close all unnecessary programs and attempt to flash the device. If the flash operation fails follow these steps to ensure enough swap space is allocated when the computer boots, then restart and try again. Only do this if flashing the device doesn't work without changing these settings.

*Important: Write down the settings in the Virtual Memory window before you make any changes to your system. When you finish the flash process you must return these settings to their original values or Windows may become unstable.*

 - Go to the Control Panel, click All Control Panel Items, then click System. At top left click the Remote Settings link.
 - Select the Advanced tab in the System Properties window, then under Performance click Settings.
 - On the Advanced tab click the Change... button to change the page size.
 - In the Virtual Memory window uncheck "Automatically manage paging file size for all drives," click "Custom size," and set the initial size to at least 4096 MB. If you have already attempted this process at least once continue to increase this number by 1024 MB. Set the maximum size to 2048 MB higher than the initial size you used.
 - Click the Set button, then click OK until all windows are closed.
 - Reboot and attempt the flash proccess.


### If you're using a Mac:

  -  Read, but only follow steps 3-5 of, [these instructions](https://software.intel.com/en-us/node/637974#manual-flash-process) first.  When you get to step 6, you'll need to cd into the jubilinux directory (see how to create it in the Jubilinux section below if you don't already have it) instead of the Intel image one, and continue with the directions below.
  -  Check also to see if you have lsusb installed prior to proceeding.  If not, follow the instructions here to add: https://github.com/jlhonora/homebrew-lsusb



## Downloading image

### Jubilinux
[Jubilinux](http://www.robinkirkman.com/jubilinux/) "is an update to the stock ubilinux edison distribution to make it more useful as a server, most significantly by upgrading from wheezy to jessie."  That means we can skip many of the time-consuming upgrade steps below that are required when starting from ubilinux.

  - Download [jubilinux.zip](http://www.robinkirkman.com/jubilinux/jubilinux.zip)
  - In download folder, right-click on file and extract (or use `unzip jubilinux.zip` from the command line)
  - Open a terminal window and navigate to the extracted folder: `cd jubilinux`.  This is your "flash window", keep it open for later.
  
  For Windows OS:
  
     You will need an additional utility prior to flashing from Windows. 
     Download [DFU-Util](https://cdn.sparkfun.com/assets/learn_tutorials/3/3/4/dfu-util-0.8-binaries.tar.xz).
     Extract the two files, libusb-1.0.dll and dfu-util.exe, to the directory where you extracted jublinux.zip.
     (you can also extract all files to a separate folder and then copy the files to the jublinux directory)

## Connecting cables and starting console

  - Connect a USB cable (one that carries data, not just power) to the USB console port. On the Explorer board or Sparkfun base block, this is the port labeled `UART`.  On the Intel mini breakout board, this is the USB port that is labled P6 (should be the USB closest to the JST battery connector).  Plug the other end into the computer (or Pi) you want to use to connect to console.
  - Plug another USB cable (one that carries data, not just power) into the USB port labeled OTG on the Explorer board or Sparkfun base block, or the port that is almost in the on the bottom right (if reading the Intel logo) if setting up with the Intel mini breakout board.  Plug the other end into the computer (or Pi) you want to flash from.
  
### If you’re using a Raspberry Pi:
  - Open a terminal window and type `sudo screen /dev/ttyUSB0 115200` or similar.  If you do not have screen installed you can install with `sudo apt-get install screen`.
  
### If you're using a Windows PC:
  - Go to Control Panel\All Control Panel Items\Device Manager\Ports\ and look for USB Serial Port COMXX.  
  - Open PuTTY, change from SSH to Serial, and connect to that COMXX port. 
  - Make sure you change the Speed(baudrate) from 9600 to 115200. 
  - Once you've made those changes, Click on OPEN at the bottom of your Putty configuration wondow. You may need to click on Enter on your key board a few times. 

### If you're using a Mac:
  - Open a terminal window and type `sudo screen /dev/tty.usbserial-* 115200` If necessary, replace the '*' with your Edison UART serial number, obtained using lsusb.
  
### All platforms:
  - Once the screen comes up, press enter a few times to wake things up. This will give you a "console" view of what is happening on your Edison. 
  - Now you will see a login prompt for the edison on the console screen. Login with username root and no password. This will have us ready to reboot from the command line when we are ready.

## Flashing image onto the Edison

### If you’re using a Raspberry Pi:
  - In the "flash window" from the Download Image instructions above, run `sudo ./flashall.sh`.  If you receive an `dfu-util: command not found` error, you can install dfu-util by running `sudo apt-get install dfu-util`

### If you’re using a Mac
  - In the "flash window" from the Download Image instructions above, run `./flashall.sh`.  If you receive an `dfu-util: command not found` error, you can install dfu-util by following [the Mac instructions here](https://software.intel.com/en-us/node/637974#manual-flash-process). 

### If you're using a Windows PC:
  - In the "flash window" from the Download Image instructions above, run `flashall.bat`

### All platforms:
  - The flashall script will ask you to reboot the Edison. Go back to your console window and type `reboot`. Switch back to the other window and you will see the flash process begin. You can monitor both the flash and console windows throughout the rest of the flash process. If nothing else works and you are feeling brave, you can try pulling the Edison out and reconnecting it to the board to start the flash process. 
  - It will take about 10 minutes to flash from Mac or Windows.  If the step that flashall says should take up to 10 minutes completes in seconds, then the flash did not complete successfully, perhaps because you didn't set up the virtual memory / swap settings correctly.  If you’re using a Raspberry Pi, it may take up to 45 minutes, and for the first 10-15 minutes it may appear like nothing is happening, but eventually you will start to see a progress bar in the console. 
  - After flashing is complete and the Edison begins rebooting, watch the console: you may get asked to type `control-D` to continue after one or more reboots. If so, press `Ctrl-d` to allow it to continue. 
  - After several more reboots (just about when you'll start to get concerned that it is stuck in a loop), you should get a login prompt.  If so, congratulations! You’re Edison is flashed. The default password is `edison`.

If you have any difficulty with flashing, skip down to [Troubleshooting](#troubleshooting)


## Initial Edison Setup

Log in as root/edison via serial console.

Type/edit the following:

    myedisonhostname=<thehostname-you-want>

And then paste the following to rename your Edison accordingly:

    echo $myedisonhostname > /etc/hostname
    sed -i"" "s/localhost$/localhost $myedisonhostname/" /etc/hosts

Run these commands to set secure passwords:

    passwd root
    passwd edison
  
## Multiple Wifi Networks:

`vi /etc/network/interfaces`

Type 'i' to get into INSERT mode
* Uncomment 'auto wlan0'
* Edit the next two lines to read:
```
auto wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```
Comment out or delete the wpa-ssid and wpa-psk lines.

Press Esc and then type ':wq' and press Enter to write the file and quit

`vi /etc/wpa_supplicant/wpa_supplicant.conf`

Type 'i' to get into INSERT mode and add the following to the end, once for each network you want to add:

```
network={
    ssid="my network"
    psk="my wifi password"
}
```
Press Esc and then type ':wq' and press Enter to write the file and quit

Run `ifup wlan0` to make sure you can connect to wifi

`reboot` so you can connect via ssh

If you need more details on setting up wpa-supplicant, see one of these guides:

http://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-wifi-network/

http://www.geeked.info/raspberry-pi-add-multiple-wifi-access-points/

http://raspberrypi.stackexchange.com/questions/11631/how-to-setup-multiple-wifi-networks


## Install packages, ssh keys, and other settings

From a new terminal or PuTTY window, `ssh myedisonhostname.local`.

Log in as root (with the password you just set above), and run:

    dpkg -P nodejs nodejs-dev
    apt-get update && apt-get -y dist-upgrade && apt-get -y autoremove

Then:

    apt-get install -y sudo strace tcpdump screen acpid vim python-pip locate
    
And:

    adduser edison sudo
    adduser edison dialout
    dpkg-reconfigure tzdata    # Set local time-zone

Edit (with `nano` or `vi`) /etc/logrotate.conf and set the log rotation to `daily` from `weekly` and enable log compression by removing the hash on the #compress line, to reduce the probability of running out of disk space

If you're *not* using the Explorer board and want to run everything as `edison` instead of `root`, log out and log back in as edison (with the password you just set above).  (If you're using an Explorer board you'll need to stay logged in as root and run everything that follows as root for libmraa to work right.)

If you have an ssh key and want to be able to log into your Edison without a password, copy your ssh key to the edison (directions you can adapt are here: http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-0/rpi.html#mac-and-linux)

If you're *not* using the Explorer board, are running as the `edison` users, and want to be able to run sudo without typing a password, run:
```
    $ su -
    $ visudo
```    
and add to the end of the file:
``` 
 edison ALL=(ALL) NOPASSWD: ALL   
```    

You have now installed the operating system on your Edison! You can now proceed to the next step of adding yourself to [Loops in Progress](https://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-0/loops-in-progress.html)

## Configure Bluetooth Low Energy tethering on Edison running Jubilinux [optional] This is still in testing as of 1-1-2017 

The Intel Edison can be tethered to a smartphone and share the phone's internet connection. Bluetooth tethering needs to be enabled and configured on the phone device and your carrier/plan must allow tethering. 

The main advantages of using BLE tethering are that it consumes less power on the phone device than running a portable WiFi hotspot. The way the script is currently setup, the Edison will try to connect to Wifi first, if it is unable to connect, it will then try to connect with your paired phone. so once you are away from your home wifi, as long as you have the Bluetooth tethering turned on, on your Android phone, it should work.

Running this command will install all of the dependencies: `curl -s https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-packages.sh | bash -` After a complete install the last line will say: openaps 0.1.5  or similar.

Bluetooth Tethering is only availble on the dev branch of Oref0 so this command differs from the command list in Phase 2.
`mkdir -p ~/src; cd ~/src && git clone -b dev git://github.com/openaps/oref0.git || (cd oref0 && git checkout dev && git pull)`

Finally dev branches need to run `cd ~/src/oref0/ && npm run global-install` for the new _oref0-online_ to work

### Installation using iPhone 
settings>general>About>Bluetooth (the 13th line down). It is this number that will appear from the `devices` command while in the interactive program `bluetoothctl`. The digits in this number are are hexidecimal which replaces 10, 11, 12, 13, 14, 15 with A, B, C, D, E, F. Notice that Bluetooth is one larger than WiFi.

`cd && ~/src/oref0/bin/oref0-setup.sh --btmac=AA:BB:CC:DD:EE:FF` See Phase 2, step 2 for instructions. This is an interactive program. 

`hciconfig hci0 name $HOSTNAME` This will have bluetooth use the name you called Edison just after the Flash process.

`bluetoothctl` 

`help` just to make sure its working.

`power on`

`scan on`

`devices` Your iphone is listed by MAC Address and Name which you set in Settings>General>About>Name.

`agent on`

`trust `FF:00:11:99:AA:BB iPhone MAC Address can be copied and pasted from `devices` output.

`pair `FF:00:11:99:AA:BB Edison will say "not successful" because the iPhone must first accept the pairing. 

Open iPhone screen to settings>bluetooth. Look for the name you called Edison and tap its line. Then confirm on the iPhone screen when it asks: Request confirmation Confirm passkey 123456

If you put network \{iPhone\} in /etc/wpa_supplicant/wpa_supplicant.conf then remove it and `reboot`. Now when you turn on Settings>Personal Hotspot or Settings>Cellular>Personal Hotspot your iPhone will drop wifi connection, go cellular, and Edison will connect by BT within one minute.

### Installation using Android
You will need to get the Mac address from your phone or whatever device you are using.
Android -settings/about phone/ Status; you will see a Bluetooth adress looking like AA:BB:CC:DD:EE:FF 
When you run the oref0-setup you will need to add that to the install parameters replacing AA:BB:CC:DD:EE:FF with what you found above.
`cd && ~/src/oref0/bin/oref0-setup.sh --btmac=AA:BB:CC:DD:EE:FF`
The first time running the script will take quite a bit longer as it is installing Bluez on your edison.
Once you are installed and running. it may fail after installing the Bluez, just reboot your edison and run the above command again. 

note if you have rebooted the board (which you will have to on an Explorer board) you must run the following command to startup the bluetooth servies, this is needed because at this point in time, you are more than likely connected to your normal Wifi network. and the oref0-online script is run only runs this if the wifi network is not connected. so this will allow you to pair your BT to your phone while running on your home network. 

```
sudo killall bluetoothd; sudo /usr/local/bin/bluetoothd --experimental &

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

This has been tested with a Samsung Galaxy S7, and a iPhone 6s and has proven reliable. But further testing is needed. So let it be known if you are able to get this to work or if you have problems.  


## Troubleshooting

### Troubleshooting the flash process

a) If you get:
```
dfu-util: Device has DFU interface, but has no DFU functional descriptor
dfu-util: Cannot open DFU device 8087:0a99
```
that likely means you ran ./flashall.sh without sudo.

b) If you get:
```
Flashing rootfs, (it can take up to 10 minutes... Please be patient)
dfu-util -v -d 8087:0a99 --alt rootfs -D /home/pi/toFlash/edison-image-edison.ext4 -R 2>&1 | tee -a flash.log | ( sed -n '19 q'; head -n 1; cat >/dev/null )
Rebooting
U-boot & Kernel System Flash Success...
```
in something closer to 10 seconds than 10 minutes, then you likely didn't set up swap properly.  To verify, `cat flash.log` and look for `dfu-util: Cannot allocate memory of size 1610612736 bytes` near the end.

c) If you have a failed flash or have problems with the reboot, try starting the console and hitting enter a bunch of times while connecting to stop autoboot.  You'll then be at a `boot>` prompt.  Run `sudo ./flashall.sh` and when it asks you to reboot type and enter `run do_flash` at the `boot>` prompt.

d) If you get an error that says "Ready to receive application" on the Edison the problem is you don't have enough power to properly boot up the Edison. This can happen if you are powering from your Pi. You should either connect a battery to the Edison board to give it a little boost, or use a powered USB hub between the Pi and the Edison.

e) If Edison reboots correctly but never gets picked up by the flashall.sh script and the flashing process does not start, check the Edison device ID. It will probably come out automatically after the flashall.sh script fails with a list of available devices connected to the machine. On Linux, you can run lsusb to get a list of usb devices with their device ID. If the device ID is different from the one expected on flashall.sh, you can edit the script and change lines containing: USB_VID=8087 & USB_PID=0a99 to whatever the Edison has for an ID. Some users have encountered their devices ID to be 8087:0a9e

f) If you have attempted the firmware flash with Jubilinux several times and the flash will not complete successfully, it is highly recommended that you follow the mmeowlink [deprecated Ubilinux instructions](https://github.com/oskarpearson/mmeowlink/wiki/Prepare-the-Edison-for-OpenAPS#ubilinux-deprecated). Note that those instructions will have notes throughout for steps which are specific to the flash of Ubilinux. Additional steps help to align the Edison's operating system with Jubilinux. You must do these steps.

If you're having issues with a *Windows* flash of Jubilinux, try following along with the videos below. OpenAPS users have cited their instructions in successful flashes of Ubilinux. You will still need to go through the extra Ubilinux configuration steps mentioned in the linked mmeowlink wiki above.

1. [Flash Ubilinux Onto Intel Edison via Windows, 5 Part Video](https://www.youtube.com/watch?v=L57RC8POJzM) (Cygwin)
2. [uCast #21: Installing Ubilinux on the Edison (Windows)](https://www.youtube.com/watch?v=BSnXjuttSgY&t=16s) (Windows Command Prompt)

g) If none of the above has worked with the Explorer board, try swapping the two microUSB cables, or replacing them with new ones.

h) If you've attempted all of the troubleshooting steps above but still aren't successful, it's worth trying to use a different computer to flash.

### Troubleshooting rescue mode

* If your edison boots to a console and says it is in rescue mode (you can hit ctrl-d to continue or enter the root password), you may need to change a u-boot environment variable to make it boot normally.   During the boot process you will see:
```
*** Ready to receive application *** 


U-Boot 2014.04 (Feb 09 2015 - 15:40:31)

       Watchdog enabled
DRAM:  980.6 MiB
MMC:   tangier_sdhci: 0
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0 
```
1. Hit any key to drop to a prompt and type:  
`printenv bootargs_target`
2. If the answer is  
`bootargs_target=first-install`  
then type:  
`setenv bootargs_target multi-user`   
`saveenv`  
3. And to exit that firmware u-boot prompt:  
`run do_boot`

* If this doesn't fix the problem, and your boot gets stuck here:
```
[  OK  ] Mounted /home.

         Starting Rescue Shell...

[  OK  ] Started Rescue Shell.

[  OK  ] Reached target Rescue Mode.
```
You may have an issue with the flashall.sh script. (This seems to only impact mac users). 
In the "flash window" terminal where you downloaded Jubilinux

1. Edit the flashall script  
`nano flashall.sh`
2. Find the following text (around line 220) Your text may vary slightly, with additional echo statements or such  
```
echo "Flashing U-Boot Environment Backup and rebooting to apply partiton changes"
    flash-command --alt u-boot-env1 -D "${VARIANT_FILE}" -R

    dfu-wait
```
3. Modify this line to remove the -R and the dfu-wait command   
```
echo "Flashing U-Boot Environment Backup and rebooting to apply partiton changes"
    flash-command --alt u-boot-env1 -D "${VARIANT_FILE}" 
```
4. Reboot one last time - install should take a good deal longer than previous executions.  


### Override DNS resolvers

Some users have reported problems with connecting to internet sites.  If you are experience poor internet connections, try 'nano /etc/resolv.conf' and change the first two nameservers to: 

     nameserver 8.8.4.4
     nameserver 8.8.8.8

Also see the instructions [here](https://wiki.debian.org/NetworkConfiguration#The_resolvconf_program) to add these nameservers to your `/network/interfaces` file as the `resolv.conf` file is likely to be overwritten.
