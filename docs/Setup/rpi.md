# Setting Up the Raspberry Pi 2

In order to use the RPi2 with openaps development tools, the RPi2 must have an operating system installed and be set up in a very specific way. By far, the most convenient approach for setting up the RPi2 is by avoiding the use of cables. This is the quickest way to get up and running with your RPi2 and avoids frustration.

For the install, you will need:

* Raspberry Pi 2
* 8 GB micro SD Card (see note below)
* Low Profile USB WiFi Adapter
* 2.1 Amp USB Power Supply
* Micro USB cable 

Note: If you ordered the recommended CanaKit, your SD card will already come imaged and ready to install Raspian, rather than having to first getting the image in step 1.

<br>
## Download Raspbian
Raspbian is the recommended operating system for OpenAPS. You can download the latest version of Raspbian [here](http://downloads.raspberrypi.org/raspbian_latest). Make sure to extract the ZIP file.

<br>
## Write Raspbian to the Micro SD Card
If needed, use this [guide](http://elinux.org/RPi_Easy_SD_Card_Setup). Please view the sections on flashing the SD card using Windows, Mac OS X, or Linux, depending on which operating system you use.

<br>
## Configure WiFi Settings

### Windows
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

If you are unable to access this file on your computer, connect your Pi to your computer with an ethernet cable and boot your Pi (as described below in Section XXXX). Log in using PuTTY. The Host Name is `raspberrypi.local` and the Port is 22. Accept the security key in the popup window. The login is `pi` and the password is `raspberry`. In the directory `/path/to/sd/card/etc/network`, type `sudo nano interfaces` and edit the file as described in Section XXXX above. 

Boot your Pi. (Put the SD card into the RPi2. Plug in the compatible USB WiFi adapter into a RPi2 USB port. Get a micro USB cable and plug the micro USB end into the side of the RPi2 and plug the USB side into the USB power supply.) Skip to step 4. <???Where is step 4 listed???>

### Mac OS X
First boot your Pi. (Put the SD card into the RPi2. Plug in the compatible USB WiFi adapter into a RPi2 USB port. Get a micro USB cable and plug the micro USB end into the side of the RPi2 and plug the USB side into the USB power supply.)

You cannot do 3a on a Mac, aka access EXT4 partitions without using 3rd party software. The easiest alternative it is to a) get a console cable (use [this guide](https://learn.adafruit.com/downloads/pdf/adafruits-raspberry-pi-lesson-5-using-a-console-cable.pdf)) or b) temporarily connect RPi to a router with an ethernet cable, SSH in (see below), and continue setting things up as described below (here in 3b) to get the wifi running. The below method will help you set up two or more wifi networks. This is highly recommended so you can add your home wifi network and your phone's hotspot network to use on the go.

Type `sudo bash` and hit enter

Input `wpa_passphrase "<my_SSID_hotspot>" "<my_hotspot_password>" >> /etc/wpa_supplicant/wpa_supplicant.conf` and hit enter (where `<my_SSID_hotspot>` is the name of your phone's hotspot and `<my_hotspot_password>` is the password).

(It should look like: `wpa_passphrase "OpenAPS hotspot" "123loveOpenAPS4ever" >> /etc/wpa_supplicant/wpa_supplicant.conf`)

Input your home wifi next: `wpa_passphrase "<my_SSID_home>" "<my_home_network_password>" >> /etc/wpa_supplicant/wpa_supplicant.conf` (and hit enter)

<br>
## Test SSH Access

### Windows

Make sure that the computer is connected to the same WiFi router that the RPi2 is using. Download PuTTY [here](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html). Hostname is `pi@raspberrypi.local` and default password for the user `pi` is `raspberry`. The port should be set to 22 (by default), and the connection type should be set to SSH. Click `Open` to initiate the SSH session.

### Mac OS X

Make sure that the computer is connected to the same WiFi router that the RPi2 is using.

Open Terminal and enter this command:

  `ssh pi@raspberrypi.local`

  Default password for the user `pi` is `raspberry`

### Linux 

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
Secure your RPi2. Log out by executing

`exit`

and copy your public SSH key into your RPi2 by entering

`ssh-copy-id pi@raspberrypi.local`

Now you should be able to log in without a password. Repeat `step 4` and try to SSH into the RPi2 without a password.

*Don't have an SSH key?* Follow [this guide](https://help.github.com/articles/generating-ssh-keys/) from GitHub to obtain one.

### Mac and Linux
First `ssh-keygen` (keep hitting enter to accept all the defaults)

Next  `scp ~/.ssh/id_rsa.pub pi@raspberrypi.local:~/.ssh/authorized_keys`

Finally `ssh pi@raspberrypi.local`

### All Systems
Since we have no password, we need to disable password login. Open the `sshd_config` file in nano text editor as follows

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
