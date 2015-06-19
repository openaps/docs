# Introduction 


`#OpenAPS` is a development tool, which provides an interface for users to build custom apps. A basic structure in to which a user can drop modules and content is provided. This tool fosters creativity as we collaborate and evaluate our work, by programming a custom solution to fit our needs, with the creation of an open source artificial pancreas, as patients with diabetes. A command-line interface is used and a graphical user interface (GUI) is unnecessary and not recommended. In this tutorial, you will learn all the information you need to use the Linux interface.


# Required Hardware 

1. The Raspberry Pi 2 kit with peripherals [http://www.amazon.com/CanaKit-Raspberry-Complete-Original-Preloaded/dp/B008XVAVAW/ref=sr_1_1?ie=UTF8&qid=1434523139&sr=8-1&keywords=canakit+raspberry+pi+2]
2. A low-profile WiFi dongle [http://www.amazon.com/BUFFALO-AirStation-N150-Wireless-Adapter/dp/B003ZM17RA/ref=sr_1_1?ie=UTF8&qid=1434523524&sr=8-1&keywords=airstation+n150]
3. 2.1 Amp USB power supply [http://www.amazon.com/Anker-10000mAh-Portable-External-Technology/dp/B009USAJCC/ref=sr_1_8?ie=UTF8&qid=1434523594&sr=8-8&keywords=intocircuit+compact+battery]
4. Medtronic CareLink USB stick [http://www.adwdiabetes.com/product/minimed-carelink-usb-upload_1164.htm]
5. Medtronic 522/722, 515/715, or 512/712 series insulin pump
6. Dexcom G4 Platinum System (Receiver and transmitter) or Dexcom G4 Platinum with Share System (receiver and transmitter)
7. Two USB cables with a right-angled micro USB end [http://www.amazon.com/Rerii-Micro-B-Charging-Guarantee-Fulfilled/dp/B00S9WXY5O/ref=sr_1_8?ie=UTF8&qid=1434603920&sr=8-8&keywords=micro+usb+right+angle]

Eventually, once you have an entire #OpenAPS system implemented, it is recommended that you have backup sets of equipment, in case of failure.

Additionally, for the Raspberry Pi and peripherals, verified sets of working hardware can be found here [http://elinux.org/RPi_VerifiedPeripherals]

# Hardware Details


*** Raspberry Pi 2 Model B ***

The Raspberry Pi 2 (RPi2) model B is a credit-card sized single-board computer which is used as a development board, used to prototype various applications of #OpenAPS. The RPi2 primarily uses Linux kernel based operating systems, which must be installed by the user onto a micro SD card for the RPi2 to work. The RPi2 currently only supports Ubuntu, Raspbian, OpenELEC, and RISC OS. We recommend installing either Ubuntu or Raspbian. In this tutorial, you will learn how to do a "cableless" and "headless" install of Raspbian, so you may access and control the RPi2 via a SSH client on Windows/Mac OS X/Linux/iOS/Android.
 
The RPi2 has 4 USB ports, an ethernet port, an HDMI port, and a micro USB power-in jack that accepts 2.1 Amp power supplies. In this tutorial, you will need to access the USB ports, micro USB power-in jack, and possibly the Ethernet jack (if failure occurs).

*** Micro SD Card ***

An 8 GB micro SDHC card is recommended, that is class-4 or greater, and is a recognized name brand like SanDisk or Kingston. A list of verified working hardware (including SD cards) can be found here [http://elinux.org/RPi_VerifiedPeripherals].

*** WiFi Adapter ***

A minimalistic, unobrtusive WiFi USB adapter is recommended, to avoid damage to both the RPi2 and the adapter, since the RPi2 is being transported everywhere with the patient.

*** 2.1 Amp USB Battery Power Supply ***

A large capacity power supply that is greater than 8000 mAh (milliamp hours) is recommended for full day use. A battery with a form-factor that minimizes size is recommended, to allow the patient to be as ambulatory as possible. When you have a full `#OpenAPS` system implemented and working, you will want to have acquired multiple batteries to rotate and recharge.

*** CareLink USB Stick ***

Currently, the only supported device for uploading pump data and interfacing on the `#OpenAPS` is the CareLink USB stick. We recommend you purchase at least two sticks because if one breaks, acquiring another stick will take time and will delay development.

*** Dexcom G4 Platinum System -- with or without Share ***

The Dexcom G4 Platinum system, with or without Share features is required to use #OpenAPS. However, the Share platform is not used in #OpenAPS as the system is designed to operate without an Internet connection. In order to get the data, a micro USB to USB cable must be connected to the RPi2 to upload the data at specified times.


*** Medtronic 522/722, 515/715, or 512/712 Series Insulin Pump ***

These specific models of the Medtronic Paradigm series insulin pumps are the only compatible pumps that will work with `#OpenAPS`. Any other pump will not work. Security features have been added to any pump after the Medtronic 522 or 722 series insulin pumps making remote adjustments in insulin unfeasible at this point of time. However, with collaboration from industry, we hope to find partners who will let us use our pumps as we want to as patients.


#Setting up the Raspberry Pi 2

In order to use the RPi2 with #OpenAPS development tools, the RPi2 must have an operating system installed and be set up in a very specific way. By far, the most convenient approach for setting up the RPi2 is by avoiding the use of cables, which is also known as a headless install. This is the quickest way to get up and running with your RPi2 and avoids frustration.

For the install, you will need:

* Raspberry Pi 2
* 8 GB SD Card
* Low Profile USB Adapter
* 2.1 Amp USB Power Supply 

1. Getting Raspbian

Raspbian is the recommended operating system for #OpenAPS. You can download the latest version of Raspbian here [http://downloads.raspberrypi.org/raspbian_latest]. Make sure to extract the ZIP file.

2. Writing Raspbian to the Micro SD Card

Please read this excellent guide [http://elinux.org/RPi_Easy_SD_Card_Setup]. Please view the sections on flashing the SD card using Windows, Mac OS X, or Linux, depending on which operating system you use.

3. Configuring WiFi Settings

Mac users: You can’t access EXT4 partitions without using 3rd party software. The easiest alternative it is to temporarily connect RPi to router with ethernet cable, ssh in (see below) and continue setting things up in /etc/network/interfaces to get the wifi running.

Keep the SD card in the reader in your computer. In this step, the WiFi interface is going to be configured in Raspbian, so that we can SSH in to the RPi2 and access the device remotely, such as on a computer or a mobile device via an SSH client, via the WiFi connection that we configure.

Go to the directory where your SD card is with all of the files for running Raspbian on your RPi2, and open this file in a text editor.

`/path/to/sd/card/etc/network/interfaces`

Edit the file so it looks like this: 

`auto lo

iface lo inet loopback
iface eth0 inet dhcp

auto wlan0
allow-hotplug wlan0
iface wlan0 inet dhcp
wpa-ssid "your-network-name"
wpa-psk "password-here"`

Obviously the quotes are removed when you enter your configuration information. Save the file (without adding any additional extensions to the end of the filename).

Now, put the SD card into the RPi2. Plug the compatible USB WiFi adapter in to the RPi2. Get a micro USB cable and plug the micro USB end into the side of the RPi2 and plug the USB side into the USB power supply. 

4. Testing SSH Access

Windows: Make sure that the computer is connected to the same WiFi router that the RPi2 is using. Download PuTTY here [http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html]. Hostname is `pi@raspberrypi.lan` and default password for the user `pi` is `raspberry`. The port should be set to 22 (by default), and the connection type should be set to SSH. Click `Open` to initiate the SSH session.

Mac OS X: Make sure that the computer is connected to the same WiFi router that the RPi2 is using.

Open Terminal and enter this command:

`ssh pi@raspberrypi.lan`

Default password for the user `pi` is `raspberry`

Linux: Make sure that the computer is connected to the same WiFi router that the RPi2 is using.

Open Terminal and enter this command:

`ssh pi@raspberrypi.lan`

Default password for the user `pi` is `raspberry`

iOS: First, you need to make your phone a hotspot and configure the WiFi connection in `step 3` to use the hotspot. 

Android: First, you need to make your phone a hotspot and configure the WiFi connection in `step 3` to use the hotspot.  
