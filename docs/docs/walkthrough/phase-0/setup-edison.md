# Setting Up Your Intel Edison

The Intel Edison system comes with a very limited Operating System. It's best to replace this with a custom version of Debian, so that the config is as-close to the Raspberry Pi as possible. This fits best with OpenAPS, and it also means you have the latest security and stability patches. (These setup instructions were pulled from the mmeowlink wiki; if you're an advanced user and want/need to use Ubilinux instead of the recommended Jubilinux, [go here](https://github.com/oskarpearson/mmeowlink/wiki/Prepare-the-Edison-for-OpenAPS).) The setup instructions also are going to assume you're using the Explorer Board that has a built in radio stick. If you're using any other base board and/or any other radio sticks (TI, ERF, Rileylink, etc.), check out [the mmeowlink wiki](https://github.com/oskarpearson/mmeowlink/wiki) for support of those hardware options.

## Prerequisites

If you’re using a Raspberry Pi to flash:

To flash the Edison using a Raspberry Pi, you’ll need a large (preferably 16GB+) SD card for your Pi.  The Edison image is almost 2GB, so you’ll not only need space for the compressed and uncompressed image, but you’ll also need to enable a large swapfile on your Pi to fit the image into virtual memory while it is being flashed.  Using an SD card as memory is very slow, so allow extra time to flash the Edison image using a Pi.

  1. Run `sudo bash -c 'echo CONF_SWAPSIZE=2000 > /etc/dphys-swapfile'` to configure a 2GB swap file.
     *Note: if you don't have enough space on the SD card for a 2G swap a 1G swap will probably work*
  2.  Run `sudo /etc/init.d/dphys-swapfile stop` and then `sudo /etc/init.d/dphys-swapfile start` to enable the new swap file.
  3.  If you installed `watchdog` on the pi, it's a good idea to stop it since loading the image into memory to flash is intensive

If you're using a Windows PC:

  1.  Go to System Properties, under Performance click on `Settings`.
  2.  Select `Advanced` and click on `Change...` to change the page size.
  3.  On Virtual Memory window uncheck `Automatically manage paging file size ...` and set the Initial size  and  Maximum size to **1024** and **2048** and reboot.

If you're using a Mac:

If you have a Mac, follow steps 1-5 of [these instructions](https://software.intel.com/en-us/node/637974#manual-flash-process) first.  

Check also to see if you have lsusb installed prior to proceeding.  If not, follow the instructions here to add: https://github.com/jlhonora/homebrew-lsusb

When you get to step 6, you'll need to cd into the Ubilinux directory instead of the Intel image one, and continue with the Linux directions below.


## Downloading image

### Jubilinux
[Jubilinux](http://www.robinkirkman.com/jubilinux/) "is an update to the stock ubilinux edison distribution to make it more useful as a server, most significantly by upgrading from wheezy to jessie."  That means we can skip many of the time-consuming upgrade steps below that are required when starting from ubilinux.

  1. Download [jubilinux.zip](http://www.robinkirkman.com/jubilinux/jubilinux.zip)
  2. In download folder, right-click on file and extract (or use `unzip jubilinux.zip` from the command line)
  3. Open a terminal window and navigate to the extracted folder: `cd jubilinux`.  This is your "flash window".

## Flashing image onto the Edison

  1. Connect a USB cable (one that carries data, not just power) to the USB console port and `sudo screen /dev/ttyUSB0 115200` or similar (on a Mac it’s `/dev/tty.usbserial-<TAB>`). On the explorer board, this is the port labeled `UART`. If you do no have screen installed you can install with ```sudo apt-get install screen``` (Linux). Once the screen comes up, press enter a few times to wake things up. This will give you a "console" view of what is happening on your Edison. [Note, this step is optional but helpful to see what is going on]
  2. Now you will see a login prompt for the edison on the console screen. Login with username root and no password. This will have us ready to reboot from the command line when we are ready.
  3. Plug USB cable (one that carries data, not just power) into the USB port that is almost in the on the bottom right (if reading the Intel logo) if setting up with the Intel board. If you are using the Sparkfun or Explorer board, it is the USB port labeled OTG. Plug the other end into your Linux box / Pi.
  4. In the "flash window" from the Download Image instructions above, run `sudo ./flashall.sh` (If you receive an `dfu-util: command not found` error, you can install dfu-util by running `sudo apt-get install dfu-util` (Linux) or by following [the Mac instructions here](https://software.intel.com/en-us/node/637974#manual-flash-process). 
  5. It will ask you to reboot the Edison. Go back to your console window and type `reboot`. Switch back to the other window and you will see the flash process begin. You can monitor both the flash and console windows throughout the rest of the flash process. If nothing else works and you are feeling brave, you can try pulling the Edison out and reconnecting it to the board to start the flash process. 
  6. It will take 10-45 minutes to flash.  The first 10-15 minutes it may appear like nothing is happening, particularly on the Pi. Eventually you will start to see a progress bar in the console. At the end when it says to give it 2 minutes, give it 5 or so.  If you open a 2nd ssh to the pi and run top you'll see `dfu-util` using all a bunch of memory.
  7. In the console you may get asked to login or type `control-D` after one or more reboots. Press `Ctrl-d` to allow it to continue. 
  8. Congratulations! You’re Edison is flashed. The default user name and password are both `edison`

If you have any difficulty with flashing, skip down to [Troubleshooting](https://github.com/oskarpearson/mmeowlink/wiki/Prepare-the-Edison-for-OpenAPS#troubleshooting)


## Initial Setup

Log in as root/edison via serial console.

    echo FIXME-thehostname-you-want > /etc/hostname

    nano /etc/hosts
        - add the host name you chose to the end of the first line 
        - old: 127.0.0.1	localhost
        - new: 127.0.0.1	localhost FIXME-thehostname-you-want
  
    nano /etc/network/interfaces
        - Uncomment 'auto wlan0'
        - Set wpa-ssid to your wifi network name
        - Set wpa-psk to the password for your wifi network

    passwd root       # set a secure password
    passwd edison     # set a secure password

    sed -i '/^deb http...ubilinux.*$/d' /etc/apt/sources.list    # remove any old ubilinux repositories

    reboot      # to set hostname and configure wifi

If you want to connect to more than one wifi network, then after rebooting and logging in via ssh, you'll want to follow one of these guides to set the WPA Supplicant process to connect to multiple access points:

http://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-wifi-network/

http://www.geeked.info/raspberry-pi-add-multiple-wifi-access-points/

http://raspberrypi.stackexchange.com/questions/11631/how-to-setup-multiple-wifi-networks


## Install packages, ssh keys, and other settings

Log in as root (with the password you just set above)

    dpkg -P nodejs nodejs-dev
    apt-get update && apt-get -y dist-upgrade && apt-get -y autoremove
    apt-get install -y sudo strace tcpdump screen acpid vim python-pip locate
    adduser edison sudo
    adduser edison dialout
    dpkg-reconfigure tzdata    # Set local time-zone

Log out, and log back in as edison (with the password you just set above), unless you're using an Explorer board (in which case you'll need to run everything that follows as root for libmraa to work right)

Next, copy your ssh key to the edison if appropriate (directions you can adapt are here: http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-0/rpi.html#mac-and-linux), and run 'reboot' to upgrade your kernels and clear out logged in sessions and IDs

* Edit /etc/logrotate.conf and set the log rotation to `daily` from `weekly` and enable log compression by removing the hash on the #compress line, to reduce the probability of running out of disk space

Then you're done!

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

### Override DNS resolvers

Some users have reported problems with connecting to internet sites.  If you are experience poor internet connections, try 'nano /etc/resolv.conf' and change the first two nameservers to: 

     nameserver 8.8.4.4
     nameserver 8.8.8.8

Also see the instructions [here](https://wiki.debian.org/NetworkConfiguration#The_resolvconf_program) to add these nameservers to your `/network/interfaces` file as the `resolv.conf` file is likely to be overwritten.
