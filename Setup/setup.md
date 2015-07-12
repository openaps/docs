Setting up the Raspberry Pi 2
-------------
In order to use the RPi2 with #OpenAPS development tools, the RPi2 must have an operating system installed and be set up in a very specific way. By far, the most convenient approach for setting up the RPi2 is by avoiding the use of cables, which is also known as a headless install. This is the quickest way to get up and running with your RPi2 and avoids frustration.

For the install, you will need:

>* Raspberry Pi 2
<br />
>* 8 GB SD Card
<br />
>* Low Profile USB WiFi Adapter
<br />
>* 2.1 Amp USB Power Supply
<br />
>* Micro USB cable 

1. **Getting Raspbian.** Raspbian is the recommended operating system for `#OpenAPS`. You can download the latest version of Raspbian [here](http://downloads.raspberrypi.org/raspbian_latest). Make sure to extract the ZIP file.

2. **Writing Raspbian to the Micro SD Card.** Please read this [excellent guide](http://elinux.org/RPi_Easy_SD_Card_Setup). Please view the sections on flashing the SD card using Windows, Mac OS X, or Linux, depending on which operating system you use.

3. **Configuring WiFi Settings** Mac users: You can’t access EXT4 partitions without using 3rd party software. The easiest alternative it is to temporarily connect RPi to router with ethernet cable, SSH in (see below) and continue setting things up in /etc/network/interfaces to get the wifi running.     <br />
Keep the SD card in the reader in your computer. In this step, the WiFi interface is going to be configured in Raspbian, so that we can SSH in to the RPi2 and access the device remotely, such as on a computer or a mobile device via an SSH client, via the WiFi connection that we configure. Go to the directory where your SD card is with all of the files for running Raspbian on your RPi2, and open this file in a text editor.

>`/path/to/sd/card/etc/network/interfaces`

Edit the file so it looks like this: 

>auto lo
<br />
>iface lo inet loopback
<br />
>iface eth0 inet dhcp
<br />

>auto wlan0
<br />
>allow-hotplug wlan0
<br />
>iface wlan0 inet dhcp
<br />
>wpa-ssid "your-network-name"
<br />
>wpa-psk "password-here"
<br />

Obviously the quotes are removed when you enter your configuration information. Save the file (without adding any additional extensions to the end of the filename).

Now, put the SD card into the RPi2. Plug in the compatible USB WiFi adapter into a RPi2 USB port. Get a micro USB cable and plug the micro USB end into the side of the RPi2 and plug the USB side into the USB power supply. 

4.: **Testing SSH Access**

**Windows:** Make sure that the computer is connected to the same WiFi router that the RPi2 is using. Download PuTTY [here](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html). Hostname is `pi@raspberrypi.lan` and default password for the user `pi` is `raspberry`. The port should be set to 22 (by default), and the connection type should be set to SSH. Click `Open` to initiate the SSH session.

**Mac OS X:** Make sure that the computer is connected to the same WiFi router that the RPi2 is using.

Open Terminal and enter this command:

>`ssh pi@raspberrypi.lan`

Default password for the user `pi` is `raspberry`

**Linux:** Make sure that the computer is connected to the same WiFi router that the RPi2 is using.

Open Terminal and enter this command:

>`ssh pi@raspberrypi.lan`

Default password for the user `pi` is `raspberry`

**iOS:** First, you need to make your phone a hotspot and configure the WiFi connection in `step 3` to use the hotspot. Make sure that the iOS device is connected to the same WiFi network that the RPi2 is using. Download Serverauditor or Prompt 2 (use this if you have a visual impairment). Hostname is `pi@raspberrypi.lan` and the default password for the user `pi` is `raspberry`. The port should be set to 22 (by default), and the connection type should be set to SSH. 

**Android:** First, you need to make your phone a hotspot and configure the WiFi connection in `step 3` to use the hotspot. Make sure that the Android device is connected to the same WiFi network that the RPi2 is using. Download an SSH client in the Google Play store. Hostname is `pi@raspberrypi.lan` and the default password for the user `pi` is `raspberry`. The port should be set to 22 (by default), and the connection type should be set to SSH.

**Note:** If connecting to the RPi2 fails at this point, the easiest alternative it is to temporarily connect RPi to router with ethernet cable, and SSH in, given both the computer and the RPi2 are connected to the same router.

5.: **raspi-config**

Run

>`sudo raspi-config` 

to expand filesystem, change user password and set timezone (in internalization options)

6.: **Password-less login**

Secure your RPi2. Log out by executing

>`exit`

and copy your public SSH key into your RPi2 by entering

>`ssh-copy-id pi@raspberrypi.lan`

Now you should be able to log in without a password. Repeat `step 4` and try to SSH into the RPi2 without a password.

**Don't have an SSH key?** Follow this guide from GitHub to obtain one. [Link](https://help.github.com/articles/generating-ssh-keys/)

7.: **sshd configuration**

Since we have no password, we need to disable password login. Open this file in nano text editor

>`sudo nano /etc/ssh/sshd_config`

Change the following

>`# change it to no`
<br />
>`PermitRootLogin yes`
<br />
>`# uncomment and change it to no (remove the # sign in the following line)`
<br />
>`# PasswordAuthentication yes`
<br />

From now on you will be able to SSH in with your private SSH key only!

8.: **Update** Update the RPi2.

> `sudo apt-get update && sudo apt-get upgrade`

Be patient while the packages install.

9.: **Watchdog** Now we are going to install watchdog, which restarts the RPi2 if it becomes unresponsive.

Enter in:

>`sudo apt-get install watchdog`

Then enter:

>`sudo modprobe bcm2708_wdog`

Then enter this line to open up the following file:

>`sudo nano /etc/modules`

At the bottom of the file add

>`bcm2708_wdog`

Add watchdog to startup applications

>`sudo update-rc.d watchdog defaults`

Edit its config file by opening up nano text editor

>`sudo nano /etc/watchdog.conf`  <br />
<br />

Make these lines look like this:

>`# uncomment the following: (remove the # from the following lines)`
<br />
>`max-load-1`
<br />
>`watchdog-device`

Start watchdog by entering

>`sudo service watchdog start`

----------


Setting up OpenAPS
--------------------

1.: Install Git

Type in 

>`sudo apt-get install git`

and press enter

2.: Installing Python packages, system wide

Type in 

>`sudo apt-get install python python-dev python-setuptools python-software-properties python-numpy`

and press enter

3.: Install PyPi and OpenAPS

>`sudo apt-get install python python-dev python-setuptools python-software-properties python-numpy && sudo easy_install -ZU openaps`

and press enter

4.: Install udev-rules

Type in 

>`sudo openaps-install-udev-rules`

and press enter

5.: Enable tab completion for efficiency.

Type in

>`sudo activate-global-python-argcomplete`

and press enter

6.: In the future, in order to update OpenAPS, type in

>`sudo easy_install -ZU openaps`

and press enter
