# Setting Up Your Intel Edison - Flashing instructions for all computer types

The Intel Edison system comes with a very limited Operating System. It's best to replace this with a custom version of Debian, as this fits best with OpenAPS, and it also means you have the latest security and stability patches. (These setup instructions were pulled from the mmeowlink wiki; if you're an advanced user and want/need to use Ubilinux instead of the recommended Jubilinux, [go here](https://github.com/oskarpearson/mmeowlink/wiki/Prepare-the-Edison-for-OpenAPS).) The setup instructions also are going to assume you're using the Explorer Board that has a built in radio stick. If you're using any other base board and/or any other radio sticks (TI, ERF, Rileylink, etc.), check out [the mmeowlink wiki](https://github.com/oskarpearson/mmeowlink/wiki) for support of those hardware options.

## Helpful notes before you get started
Your Explorer Board has 2 micro USB connectors, they both provide power. On the community developed Edison Explorer Board the port labeled OTG is for flashing, and the one labeled UART provides console login. You must connect both ports to your computer to complete the flash process.

You must use a DATA micro USB to USB cable. How do you know if your cable is for data? One good way is to plug the cable into your computer USB port and the explorer board OTG port. If your folder/window explorer shows Edison as a drive then the cable supports data.

The steps outlined below include instructions for the various build-platforms (Windows PC, Mac, and Raspberry Pi). Linux users in general should be able to follow the steps for the Raspberry Pi. If you'd prefer to follow directions specific to one platform you are using, you can use the [Windows PC cheat sheet](http://openaps.readthedocs.io/en/latest/docs/Resources/Edison-Flashing/PC-flash.html) or the [Mac OSX cheat sheet](http://openaps.readthedocs.io/en/latest/docs/Resources/Edison-Flashing/mac-flash.html).

## Prerequisites

### If you’re using a Raspberry Pi - prerequisites:

To flash the Edison using a Raspberry Pi, you’ll need a large (preferably 16GB+) SD card for your Pi.  The Edison image is almost 2GB, so you’ll not only need space for the compressed and uncompressed image, but you’ll also need to enable a large swapfile on your Pi to fit the image into virtual memory while it is being flashed.  Using an SD card as memory is very slow, so allow extra time to flash the Edison image using a Pi.

  - Run `sudo bash -c 'echo CONF_SWAPSIZE=2000 > /etc/dphys-swapfile'` to configure a 2GB swap file.
     *Note: if you don't have enough space on the SD card for a 2G swap a 1G swap will probably work*
  -  Run `sudo /etc/init.d/dphys-swapfile stop` and then `sudo /etc/init.d/dphys-swapfile start` to enable the new swap file.
  -  If you installed `watchdog` on the pi, it's a good idea to stop it since loading the image into memory to flash is intensive

### If you're using a Windows PC - prerequisites:

- Install the [Intel Edison drivers for Windows](https://downloadcenter.intel.com/download/26993/Intel-Edison-Configuration-Tool?product=84572). Select the "Windows standalone driver" download. You do not need to reflash the Edison or setup security or Wi-Fi with this tool because later steps in this process will overwrite those settings.

******

Note: Intel has announced the Edison will be discontinued at the end of 2017.  As part of this, apparently, the old link to Edison drivers has been removed.  We are unsure if this is a temporary issue or long term.  Therefore, if the link above for Intel Edison Drivers is not working, you can use [this link](https://www.dropbox.com/s/d5ooojru5jxsilp/IntelEdisonDriverSetup1.2.1.exe?dl=0) to download them directly from an OpenAPS user's dropbox.  Obviously screenshots below will be different if Intel has not fixed or repaired their driver downloads page for Edisons.

********

- Install [PuTTY]( http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html). Download the installation file that matches your PC's architecture (32-bit or 64-bit).

Windows PCs with less than 6 GB of RAM  may need to have the size of the page file increased to flash the Edison. Close all unnecessary programs and attempt to flash the device. If the flash operation fails follow these steps to ensure enough swap space is allocated when the computer boots, then restart and try again. Only do this if flashing the device doesn't work without changing these settings.

*Important: Write down the settings in the Virtual Memory window before you make any changes to your system. When you finish the flash process you must return these settings to their original values or Windows may become unstable.*

 - Go to the Control Panel, click All Control Panel Items, then click System. At top left click the Remote Settings link.
 - Select the Advanced tab in the System Properties window, then under Performance click Settings.
 - On the Advanced tab click the Change... button to change the page size.
 - In the Virtual Memory window uncheck "Automatically manage paging file size for all drives," click "Custom size," and set the initial size to at least 4096 MB. If you have already attempted this process at least once continue to increase this number by 1024 MB. Set the maximum size to 2048 MB higher than the initial size you used.
 - Click the Set button, then click OK until all windows are closed.
 - Reboot and attempt the flash process.


### If you're using a Mac to flash - prerequisites:

  -  Read, but only follow steps 3-5 of, [these instructions](https://software.intel.com/en-us/node/637974#manual-flash-process) first.  When you get to step 6, you'll need to cd into the jubilinux directory (see how to create it in the Jubilinux section below if you don't already have it) instead of the Intel image one, and continue with the directions below.
  -  Check also to see if you have lsusb installed prior to proceeding.  If not, follow the instructions here to add: https://github.com/jlhonora/homebrew-lsusb
  - Read the [Mac instructions for flashing](mac-flash.html) too, but note that they are now a little older than this.


## Downloading image

### Jubilinux
[Jubilinux](http://www.jubilinux.org/) "is an update to the stock ubilinux edison distribution to make it more useful as a server, most significantly by upgrading from wheezy to jessie."  That means we can skip many of the time-consuming upgrade steps that are required when starting from ubilinux.

  - Download Jubilinux [jubilinux.zip](http://www.jubilinux.org/dist/) - the 	jubilinux-v0.2.0.zip is known to work.
  - In download folder, right-click on file and extract (or use `unzip jubilinux.zip` from the command line) You will access this directory from a command prompt in the next step. It is a good idea to create the Jubilinux in your root directory to make this easier to access.
  - Open a terminal window and navigate to the extracted folder: `cd jubilinux`. If using Windows OS use the command prompt (cmd). This is your "flash window", keep it open for later.
  
  For Windows OS:
  
     You will need an additional utility prior to flashing from Windows. 
     Download [DFU-Util](https://cdn.sparkfun.com/assets/learn_tutorials/3/3/4/dfu-util-0.8-binaries.tar.xz).
     Extract the two files, libusb-1.0.dll and dfu-util.exe, to the directory where you extracted jublinux.zip.
     (you can also extract all files to a separate folder and then copy the files to the jublinux directory)

## Connecting cables and starting console

  - Connect a USB cable (one that carries data, not just power) to the USB console port. On the Explorer board or Sparkfun base block, this is the port labeled `UART`.  On the Intel mini breakout board, this is the USB port that is labeled P6 (should be the USB closest to the JST battery connector).  Plug the other end into the computer (or Pi) you want to use to connect to console.
  - Plug another USB cable (one that carries data, not just power) into the USB port labeled OTG on the Explorer board or Sparkfun base block, or the port that is almost in the on the bottom right (if reading the Intel logo) if setting up with the Intel mini breakout board.  Plug the other end into the computer (or Pi) you want to flash from.
  
### If you’re using a Raspberry Pi for console:
  - Open a terminal window and type `sudo screen /dev/ttyUSB0 115200` or similar.  If you do not have screen installed you can install with `sudo apt-get install screen`.
  
### If you're using a Windows PC for console:
  - Go to Control Panel\All Control Panel Items\Device Manager\Ports\ and look for USB Serial Port COMXX. If you have multiple and unsure of which is the port you need: Make note of existing ports. Unplug the cable from the Explorer board. Notice which port disappears. this is the port you are looking for.
  - Open PuTTY, change from SSH to Serial. It normally defaults to COM1 and speed of 9600. Change the COM number to the number you found when you plugged into the Explorer board. Change the speed (baud rate) to 115200. 
  - Once you've made those changes, Click on OPEN at the bottom of your Putty configuration window. 
  - Continue with the All platforms section below.

### If you're using a Mac for console:
  - Open a terminal window and type `sudo screen /dev/tty.usbserial-* 115200` If necessary, replace the '*' with your Edison UART serial number, obtained using lsusb.
  
### All platforms:
  - Once the screen comes up, press enter a few times to wake things up. This will give you a "console" view of what is happening on your Edison. 
  - Now you will see a login prompt for the edison on the console screen. Login using the username "root" (all lowercase) and no password. This will have us ready to reboot from the command line when we are ready.
  - Don't resize your console window: it will likely mess up your terminal's line wrapping.  (Once you get wifi working and connect with SSH you can resize safely.)

## Flashing image onto the Edison

### If you’re using a Raspberry Pi - starting flash:
  - In the "flash window" from the Download Image instructions above, run `sudo ./flashall.sh`.  If you receive an `dfu-util: command not found` error, you can install dfu-util by running `sudo apt-get install dfu-util`

### If you’re using a Mac - starting flash:
  - In the "flash window" from the Download Image instructions above, run `./flashall.sh`.  
    - If you receive an `dfu-util: command not found` error, you can install dfu-util by following [the Mac instructions here](https://software.intel.com/en-us/node/637974#manual-flash-process). 
    - If you receive an `Error: Running Homebrew as root is extremely dangerous and no longer supported. As Homebrew does not drop privileges on installation you would be giving all build scripts full access to your system.` see the troubleshooting section below.

### If you're using a Windows PC - starting flash:
  - In the "flash window" from the Download Image instructions above, run `flashall.bat`

### All platforms:
  - The flashall script will ask you to reboot the Edison. Go back to your console window and type `reboot`. Switch back to the other window and you will see the flash process begin. You can monitor both the flash and console windows throughout the rest of the flash process. If nothing else works and you are feeling brave, you can try pulling the Edison out and reconnecting it to the board to start the flash process. 
  - It will take about 10 minutes to flash from Mac or Windows.  If the step that flashall says should take up to 10 minutes completes in seconds, then the flash did not complete successfully, perhaps because you didn't set up the virtual memory / swap settings correctly.  If you’re using a Raspberry Pi, it may take up to 45 minutes, and for the first 10-15 minutes it may appear like nothing is happening, but eventually you will start to see a progress bar in the console. 
  - After flashing is complete and the Edison begins rebooting, watch the console: you may get asked to type `control-D` to continue after one or more reboots. If so, press `Ctrl-d` to allow it to continue. 
  - After several more reboots (just about when you'll start to get concerned that it is stuck in a loop), you should get a login prompt.  If so, congratulations! Your Edison is flashed. The default password is `edison`.

If you have any difficulty with flashing, skip down to [Troubleshooting](#troubleshooting)


## Initial Edison Setup

Log in as root/edison via serial console.

Type/edit the following:

    myedisonhostname=<thehostname-you-want>     #Do not type the <>

And then paste the following to rename your Edison accordingly:

    echo $myedisonhostname > /etc/hostname
    sed -r -i"" "s/localhost( jubilinux)?$/localhost $myedisonhostname/" /etc/hosts

Run these commands to set secure passwords.  It will ask you to enter your new password for each user 2 times. Type the password in the same both times.  To use SSH (which you will need to do shortly) this password needs to be at least 8 characters long.  Do not use a dictionary word or other easy-to-guess word/phrase as the basis for your passwords.  Do not reuse passwords you've already used elsewhere.

    passwd root
    passwd edison
  
## Set up Wifi:

`vi /etc/network/interfaces`

Type 'i' to get into INSERT mode
* Uncomment 'auto wlan0' (remove the `#` at the beginning of the line)
* Edit the next two lines to read:
```
auto wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```
Comment out or delete the wpa-ssid and wpa-psk lines.

After editing, your file should look like:

```
# interfaces(5) file used by ifup(8) and ifdown(8)
auto lo
iface lo inet loopback

auto usb0
iface usb0 inet static
    address 192.168.2.15
    netmask 255.255.255.0

auto wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```

Press Esc and then type ':wq' and press Enter to write the file and quit

`vi /etc/wpa_supplicant/wpa_supplicant.conf`

Type 'i' to get into INSERT mode and add the following to the end, once for each network you want to add.  Be sure to include the quotes around the network name and password.

```
network={
    ssid="my network"
    psk="my wifi password"
}
```

If you want to add open networks to your list, then add:

```
network={
        key_mgmt=NONE
        priority=-999
}
```

If you have a hidden wifi network add the line `scan_ssid=1`.

Some wifi networks require you to accept a terms and conditions prior to allowing access.  For example, Starbucks coffee shops and many hotels.  These networks are termed "captive" networks and connecting your rig to them is currently not an option.

Other wifi networks may require you to enter a login name and password at an initial screen before allowing access (such as many school district wifi networks).  Some users have success in using the following wpa network settings for those types of networks:

```
network={
   scan_ssid=1
   ssid="network name"
   password="wifi password"
   identity="wifi username"
   key_mgmt=WPA-EAP
   pairwise=CCMP TKIP
   group=CCMP TKIP WEP104 WEP40
   eap=TTLS PEAP TLS
   priority=1
}
```

Press Esc and then type ':wq' and press Enter to write the file and quit

`reboot` to apply the wifi changes and (hopefully) get online

After rebooting, log back in and type `iwgetid -r` to make sure you successfully connected to wifi. It should print out your network name.

Run `ifconfig wlan0` to determine the IP address of the wireless interface, in case you need it to SSH below.

Leave the serial window open in case you can't get in via SSH and need to fix your wifi config.
 
If you need more details on setting up wpa_supplicant.conf, see one of these guides:

* [http://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-wifi-network/](http://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-wifi-network/)
* [http://www.geeked.info/raspberry-pi-add-multiple-wifi-access-points/](http://www.geeked.info/raspberry-pi-add-multiple-wifi-access-points/)
* [http://raspberrypi.stackexchange.com/questions/11631/how-to-setup-multiple-wifi-networks](http://raspberrypi.stackexchange.com/questions/11631/how-to-setup-multiple-wifi-networks)
* [http://www.cs.upc.edu/lclsi/Manuales/wireless/files/wpa_supplicant.conf](http://www.cs.upc.edu/lclsi/Manuales/wireless/files/wpa_supplicant.conf)


## Install packages, ssh keys, and other settings

From a new terminal or PuTTY window, `ssh root@myedisonhostname.local`. If you can't connect via `youredisonhostname.local` (for example, on a Windows PC without iTunes), you can instead connect directly to the IP address you found with `ifconfig` above.

Log in as root (with the password you just set above), and run:

    dpkg -P nodejs nodejs-dev
    apt-get update && apt-get -y dist-upgrade && apt-get -y autoremove
    apt-get install -y sudo strace tcpdump screen acpid vim python-pip locate
    
And:

    adduser edison sudo
    adduser edison dialout
    dpkg-reconfigure tzdata    # Set local time-zone
       Use arrow button to choose zone then arrow to the right to make cursor highlight <OK> then hit ENTER

Edit (with `nano` or `vi`) /etc/logrotate.conf and change the log rotation to `daily` from `weekly` and enable log compression by removing the hash on the #compress line, to reduce the probability of running out of disk space

If you're *not* using the Explorer board and want to run everything as `edison` instead of `root`, log out and log back in as edison (with the password you just set above).  (If you're using an Explorer board you'll need to stay logged in as root and run everything that follows as root for libmraa to work right.)

If you have an ssh key and want to be able to log into your Edison without a password, copy your ssh key to the Edison ([directions you can adapt are here](http://openaps.readthedocs.io/en/latest/docs/Resources/Deprecated-Pi/Pi-setup.html#mac-and-linux)).  For Windows/Putty users, you can use these instructions: [https://www.howtoforge.com/ssh_key_based_logins_putty](https://www.howtoforge.com/ssh_key_based_logins_putty).

If you're *not* using the Explorer board, are running as the `edison` users, and want to be able to run sudo without typing a password, run:
```
    $ su -
    $ visudo
```    
and add to the end of the file:
``` 
 edison ALL=(ALL) NOPASSWD: ALL   
```    

You have now installed the operating system on your Edison! You can now proceed to the next step of adding yourself to [Loops in Progress](https://openaps.readthedocs.io/en/latest/docs/While You Wait For Gear/loops-in-progress.html)


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

c) If you recieve an `Error: Running Homebrew as root is extremely dangerous and no longer supported. As Homebrew does not drop privileges on installation you would be giving all build scripts full access to your system.` it means that you have a recent copy of homebrew (that's good) which doesn't allow sudo to even do a `brew list`. 

   * The _easiest_ - but perhaps not so forward compatible - thing is to figure out what the brew command was trying to do and edit the `flashall.sh` script accordingly.
   ** The v0.2.0 version of `flashapp.sh` has `$(brew list gnu-getopt | grep bin/getopt)`.
   ** Running `brew list gnu-getopt | grep bin/getopt` for me (Dec 2017) gave me `/usr/local/Cellar/gnu-getopt/1.1.6/bin/getopt`
   * Edit the `flashall.sh` from ```:bash

        GETOPTS="$(which getopt)"
        if [[ "$OSTYPE" == "darwin"* ]] ; then READLINK=greadlink; GETOPTS="$(brew l    ist gnu-getopt | grep bin/getopt)"; else READLINK=readlink;fi;
     ``` to ```:bash
      
        GETOPTS="$(which getopt)"
        if [[ "$OSTYPE" == "darwin"* ]]
        then
                READLINK=greadlink
                GETOPTS=/usr/local/Cellar/gnu-getopt/1.1.6/bin/getopt
        else
                READLINK=readline
        fi
```

d) If you have a failed flash or have problems with the reboot, try starting the console and hitting enter a bunch of times while connecting to stop autoboot.  You'll then be at a `boot>` prompt.  Run `sudo ./flashall.sh` and when it asks you to reboot type and enter `run do_flash` at the `boot>` prompt.

e) If you get stuck on an error that says "Ready to receive application" on the Edison the problem is you don't have enough power to properly boot up the Edison. This can happen if you are powering from your Pi. You should either connect a battery to the Edison board to give it a little boost, or use a powered USB hub between the Pi and the Edison.

f) If Edison reboots correctly but never gets picked up by the flashall.sh script and the flashing process does not start, check that you have DATA micro USB to USB cables - both of them. A large proportion of USB cables are not "data" - just power - and even cables previously used for data can degrade to no longer reliably carry data. How do you know if each cable is for data? One good way is to unplug both cables from the Edison, plug each cable in turn into your computer USB port and the explorer board OTG port. If your folder/window explorer shows Edison as a drive then the cable supports data. You need both to be data cables.

g) If Edison reboots correctly but never gets picked up by the flashall.sh script and the flashing process does not start, and you've re-confirmed that the two cables you are using are indeed good data cables, check the Edison device ID. It will probably come out automatically after the flashall.sh script fails with a list of available devices connected to the machine. On Linux, you can run lsusb to get a list of usb devices with their device ID. If the device ID is different from the one expected on flashall.sh, you can edit the script and change lines containing: USB_VID=8087 & USB_PID=0a99 to whatever the Edison has for an ID. Some users have encountered their devices ID to be 8087:0a9e

h) If you have attempted the firmware flash with Jubilinux several times and the flash will not complete successfully, it is highly recommended that you follow the mmeowlink [deprecated Ubilinux instructions](https://github.com/oskarpearson/mmeowlink/wiki/Prepare-the-Edison-for-OpenAPS#ubilinux-deprecated). Note that those instructions will have notes throughout for steps which are specific to the flash of Ubilinux. Additional steps help to align the Edison's operating system with Jubilinux. You must do these steps.

If you're having issues with a *Windows* flash of Jubilinux, try following along with the videos below. OpenAPS users have cited their instructions in successful flashes of Ubilinux. You will still need to go through the extra Ubilinux configuration steps mentioned in the linked mmeowlink wiki above.

1. [Flash Ubilinux Onto Intel Edison via Windows, 5 Part Video](https://www.youtube.com/watch?v=L57RC8POJzM) (Cygwin)
2. [uCast #21: Installing Ubilinux on the Edison (Windows)](https://www.youtube.com/watch?v=BSnXjuttSgY&t=16s) (Windows Command Prompt)

i) If none of the above has worked with the Explorer board, try swapping the two microUSB cables, or replacing them with new ones. See "f)" above too.

j) If you've attempted all of the troubleshooting steps above but still aren't successful, it's worth trying to use a different computer to flash.
     
     
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

Alternatively, add the nameservers you want to see in `resolv.conf` to `/etc/resolvconf/resolv.conf.d/tail` and they'll be automatically added to `resolv.conf`. (You may need to create the folder by running this command first: `mkdir -p /etc/resolvconf/resolv.conf.d`)


### IP address conflicts (able to ping external but not LAN addresses)

Some users have reported problems where the local router uses the same IP block as that of usb0 config.  The default configuration for usb0 in `/etc/network/interfaces` uses 192.168.2.15, so if your local router also uses 192.168.2.xx you may not be able to properly connect to your Edison using SSH, and external connectivity may intermittently fail.

To check which IP address your router is using, you can run `ipconfig` on Windows or `ifconfig` on Mac/Linux.  If you're getting an address starting with 192.168.2.x, you'll want to edit your Edison's configuration to use a different subnet for usb0:

Use `vi /etc/network/interfaces` to edit the static usb0 interface address from 192.168.2.15 to another valid private IP, like 192.168.29.29.  The resulting config should look like:

```
# interfaces(5) file used by ifup(8) and ifdown(8)
auto lo
iface lo inet loopback

auto usb0
iface usb0 inet static
    address 192.168.29.29
    netmask 255.255.255.0

auto wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```

Once that looks correct, save the file and `reboot` your rig for the changes to take effect.


### Interrupting Kernel Messages in Console/Screen Mode

![Example kernel message](https://user-images.githubusercontent.com/24418738/27111189-17c4acd8-5074-11e7-8873-54470e94c638.jpg)

#### Fix for individual console/screen session:

Type this at the prompt:   `dmesg -D`

#### Permanent solution:

`vi /etc/rc.local`
press i for insert mode

add this line:    sudo dmesg -n 1

![adding dmesg](https://user-images.githubusercontent.com/24418738/27111188-17c46c3c-5074-11e7-8a5f-d29c85873293.jpg)

(remember to save and exit the vi editor by using esc and then :wq)


