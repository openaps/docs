# Setting Up the Raspberry Pi 2

In order to use the RPi2 with openaps development tools, the RPi2 must have an operating system installed and be set up in a very specific way. There are two paths to the intial operating system instalation and WIFI setup.  Path 1 is reccomended for beginners that are very new to using command prompts or "terminal" on the Mac. 
Path 2 is considered the most convenient approach for those with more experience with coding and allows the RPi2 to be set up without the use of cables, which is also known as a headless install. Either path will work and the path you choose is a matter of personal preference.
Either way, it is recomended that you purchase your RPi2 as a CanaKit, which includes everything you will need for a GUI install. 

For the Path 1 GUI install you will need:

* A Raspberry Pi 2 CanaKit, which includes several essential accessories in one package (See e.g. http://www.amazon.com/CanaKit-Raspberry-Complete-Original-Preloaded/dp/B008XVAVAW)
* USB Keyboard 
* USB Mouse 
* A TV or other screen with HDMI input  

For the Path 2 Headless install, you will need:

* Raspberry Pi 2
* 8 GB micro SD Card [and optional adapter so that you can plug in the micro SD Card into your computer]
* Low Profile USB WiFi Adapter
* 2.1 Amp USB Power Supply
* Micro USB cable 
* Raspberry Pi 2 CanaKit

## Path 1: GUI Setup

1:  **Plug in Applicable peripherals**
* First, insert your USB keyboard and USB mouse into the RPi2.
* Then insert the included USB WIFI into the RPi2.
* Next, connect your RPi2 to a monitor or T.V. using the included HDMI cable.
* Next, insert the Micro SD Card included with your CanaKit into the RPi2.
* Finally connect your RPi2 using the power adapter.
* You should see the GUI appear on sceen.  

2:  **Install Raspbian and Connect WIFI**

At this point you can consult the color instruction pamphlet included with your CanaKit, which will walk you through installing Raspbian and connecting the RPi2 to your WIFI router.  

Once you have installed Rasbian and connected to WIFI, you can disconnect the mouse, keyboard and HDMI cable.  You can now skip to "Test SSH Access" and SSH into your RPi2.  Remember to keep your RPi2 plugged in, just disconnect peripherals.  Also remember to never disconnect your RPi2 without shutting it down properly using the `sudo shutdown -h now` command.  If you are unable to access the Pi and must power it off without a shutdown, wait until the green light has stopped flashing (indicating the Pi is no longer writing to the SD card).

## Path 2: Headless Install

Note: If you ordered the recommended CanaKit, your SD card will already come imaged and ready to install Raspian, rather than having to Download and Write Raspbian to the MicroSD card.

### Download Raspbian
Raspbian is the recommended operating system for OpenAPS. You can download the latest version of Raspbian [here](http://downloads.raspberrypi.org/raspbian_latest).
Make sure to extract the disk .img from the ZIP file.

### Write Raspbian to the Micro SD Card
Erase (format) your SD card using https://www.sdcard.org/downloads/formatter_4/

Write the Raspbian .img you extracted from the ZIP file above to the SD card using the instructions at https://www.raspberrypi.org/documentation/installation/installing-images/

### Configure WiFi Settings

#### Headless WiFi configuration (Windows)
Keep the SD card in the reader in your computer. In this step, the WiFi interface is going to be configured in Raspbian, so that we can SSH in to the RPi2 and access the device remotely, such as on a computer or a mobile device via an SSH client, via the WiFi connection that we configure. Go to the directory where your SD card is with all of the files for running Raspbian on your RPi2, and open this file in a text editor.

`/path/to/sd/card/etc/network/interfaces`

Edit the file so it looks like this: 

```
auto lo
iface lo inet loopback
iface eth0 inet dhcp

auto wlan0
allow-hotplug wlan0
iface wlan0 inet dhcp
wpa-ssid <your-network-name>
wpa-psk <your-password>
```

Replace `<your-network-name>` and `<your-password>` with your own credentials. Save the file (without adding any additional extensions to the end of the filename).

Boot your Pi. (Put the SD card into the RPi2. Plug in the compatible USB WiFi adapter into a RPi2 USB port. Get a micro USB cable and plug the micro USB end into the side of the RPi2 and plug the USB side into the USB power supply.)

If you are unable to access this file on your computer:
* Connect your Pi to your computer with an ethernet cable and boot your Pi
* Log in using PuTTY. The Host Name is `raspberrypi.local` and the Port is 22.  The login is `pi` and the password is `raspberry`.
* Type `sudo nano /etc/network/interfaces` and edit the file as described above, or follow the OS X directions below. 

#### Logged-in WiFi configuration (Mac OS X)
First boot your Pi. (Put the SD card into the RPi2. Plug in the compatible USB WiFi adapter into a RPi2 USB port. Get a micro USB cable and plug the micro USB end into the side of the RPi2 and plug the USB side into the USB power supply.)

On a Mac, you cannot access EXT4 partitions (like the Raspberry Pi uses) without using 3rd party software. To log into the Raspberry Pi and configure wi-fi, you'll need to use one of these methods:
* Get a console cable (use [this guide](https://learn.adafruit.com/downloads/pdf/adafruits-raspberry-pi-lesson-5-using-a-console-cable.pdf))
* temporarily connect RPi to a router with an ethernet cable and SSH in (see below)
* use a keyboard, mouse, and monitor (see Path 1 above)

Once you connect to the Pi, you'll want to set up your wifi network(s). It is recommended to add both your home wifi network and your phone's hotspot network if you want to use OpenAPS on the go.

To configure wifi:

Type `sudo bash` and hit enter

Input `wpa_passphrase "<my_SSID_hotspot>" "<my_hotspot_password>" >> /etc/wpa_supplicant/wpa_supplicant.conf` and hit enter (where `<my_SSID_hotspot>` is the name of your phone's hotspot and `<my_hotspot_password>` is the password).

(It should look like: `wpa_passphrase "OpenAPS hotspot" "123loveOpenAPS4ever" >> /etc/wpa_supplicant/wpa_supplicant.conf`)

Input your home wifi next: `wpa_passphrase "<my_SSID_home>" "<my_home_network_password>" >> /etc/wpa_supplicant/wpa_supplicant.conf` (and hit enter)

<br>
## Test SSH Access

### Windows

Make sure that the computer is connected to the same WiFi router that the RPi2 is using. Download PuTTY [here](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html). Hostname is `pi@raspberrypi.local` and default password for the user `pi` is `raspberry`. The port should be set to 22 (by default), and the connection type should be set to SSH. Click `Open` to initiate the SSH session.

### Mac OS X / Linux

Make sure that the computer is connected to the same WiFi router that the RPi2 is using.

Open Terminal and enter this command:

  `ssh pi@raspberrypi.local`

  Default password for the user `pi` is `raspberry`

### iOS
You probably want to make your phone a hotspot and configure the WiFi connection in `step 3` to use the hotspot. Make sure that the iOS device is connected to the same WiFi network that the RPi2 is using. Download Serverauditor or Prompt 2 (use this if you have a visual impairment). Hostname is `pi@raspberrypi.local` and the default password for the user `pi` is `raspberry`. The port should be set to 22 (by default), and the connection type should be set to SSH. 

### Android
You probably want to make your phone a hotspot and configure the WiFi connection in `step 3` to use the hotspot. Make sure that the Android device is connected to the same WiFi network that the RPi2 is using. Download an SSH client in the Google Play store. Hostname is `pi@raspberrypi.local` and the default password for the user `pi` is `raspberry`. The port should be set to 22 (by default), and the connection type should be set to SSH.

Note: If connecting to the RPi2 fails at this point, the easiest alternative it is to temporarily connect RPi to router with ethernet cable, and SSH in, given both the computer and the RPi2 are connected to the same router.

<br>
## Configure the Raspberry Pi

Run

`sudo raspi-config` 

to expand filesystem, change user password and set timezone (in internationalization options). This will take effect on the next reboot, so it is a good idea to go ahead and run `sudo reboot` now.

<br>
## Update the Raspberry Pi

Update the RPi2.

`sudo apt-get update && sudo apt-get -y upgrade`

The packages will take some time to install.

<br>
## Setup Password-less Login [optional]

### Windows

If you don't already have an SSH key, follow [this guide](https://help.github.com/articles/generating-ssh-keys/) from GitHub to create one.

Create a .ssh directory on the Pi: run `mkdir .ssh`

Log out by typing `exit`

and copy your public SSH key into your RPi2 by entering

`ssh-copy-id pi@raspberrypi.local`

Now you should be able to log in without a password. Try to SSH into the RPi2 again, this time without a password.


### Mac and Linux
If you don't already have an ssh key, then on your local computer ( *not* on the Pi ), by running `ssh-keygen` (keep hitting enter to accept all the defaults)

Next create a .ssh directory on the Pi: `ssh pi@raspberrypi.local`, enter your password, and run `mkdir .ssh`

Next copy your public key to the Pi: `scp ~/.ssh/id_rsa.pub pi@raspberrypi.local:~/.ssh/authorized_keys`

Finally `ssh pi@raspberrypi.local` to make sure you can log in without a password.

### Disabling password login [optional]
To secure the Pi, you should either set a password (using `sudo raspi-config` above, or with `sudo passwd`), or disable password login completely. If you want to disable password login (so you can only log in with your ssh key), open the `sshd_config` file in nano text editor on the Pi as follows

`sudo nano /etc/ssh/sshd_config`

Change the following

```
PermitRootLogin yes
# PasswordAuthentication yes
```

to

```
PermitRootLogin no
PasswordAuthentication no
```

Note that the second line was previously commented out.

From now on you will be able to SSH in with your private SSH key only.

<br>
## Watchdog [optional]

Now you can consider installing watchdog, which restarts the RPi2 if it becomes unresponsive.

Enter in:

`sudo apt-get install watchdog`

Then enter:

`sudo modprobe bcm2708_wdog`


Create a new file 8192cu.conf in /etc/modprobe.d/:

`sudo nano /etc/modprobe.d/8192cu.conf`

Add this line to the file (paste it in):
`options 8192cu rtw_power_mgnt=0 rtw_enusbss=0` (Look at hints on bottom of screen; Control x to exit, yes to save, enter)

Then enter this line to open up the following file:

`sudo nano /etc/modules`

At the bottom of the file copy and paste:

`bcm2708_wdog` (Look at hints on bottom of screen; Control x to exit, yes to save, enter)

Next, add watchdog to startup applications:

`sudo update-rc.d watchdog defaults`

Edit the config file by opening up nano text editor

`sudo nano /etc/watchdog.conf`  

Uncomment the following: (remove the # from the following lines, scroll down as needed to find them):

```
max-load-1
watchdog-device
```

Finally, start watchdog by entering:

`sudo service watchdog start`
