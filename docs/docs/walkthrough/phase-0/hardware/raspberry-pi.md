# Hardware information for Raspberry Pi setups


The Raspberry Pi (RPi) is a credit-card sized single-board computer. The RPi
primarily uses Linux kernel based operating systems, which must be installed by
the user onto a micro SD card for the RPi to work. The RPi currently only
supports Ubuntu, Raspbian, OpenELEC, and RISC OS. We recommend installing either
Ubuntu or Raspbian. Later in the docs under recommended setup, you will learn how to do a "cableless" and
"headless" install of Raspbian. You will be able to access and control the RPi
via an SSH client on Windows, Mac OS X, Linux, iOS, or Android.

The RPi has 4 USB ports, an Ethernet port, an HDMI port, and a micro USB
power-in jack that accepts 2.1 Amp power supplies. In this tutorial, you will
need to access the USB ports, micro USB power-in jack, and possibly the Ethernet
jack (if wireless failure occurs). You will not require the HDMI port or a
monitor.

High level list of supplies needed for a Pi-based setup:
* One of the following:
    * Raspberry Pi 2 Model B ("RPi2") with a Low-profile USB WiFi adapter (see
      "Raspberry Pi 2" section below)
    * Raspberry Pi 3 Model B (“RPi3”) with built in WiFi
* A Carelink USB or alternative radio stick    
* An 8 GB (or greater) micro SD card
* <b>Additional Supplies</b>
    * Micro SD card to regular SD card converter \[optional, but recommended so
      that you can use the micro SD card in a regular sized SD card drive\]
    * 2.1 Amp (or greater) USB power supply or battery
    * Micro USB cable(s)
    * Case \[optional\]
    * Cat5 or Cat6 Ethernet cable \[optional\]
    * HDMI cable \[optional, used for connecting the RPi2 to a screen for
      initial setup ease\]
    * USB Keyboard \[optional, used to interact with the RPi2 via its own
      graphics interface on your TV screen\]
    * USB Mouse \[optional, for the same purpose\]

## Raspberry Pi 2
The Raspberry Pi 2 has fewer and lower spec components and so draws less
power, but requires a WiFi adapter to be also purchased. The spec makes no
difference to the OpenAPS app, so either model is suitable choice.

[Raspberry Pi 2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)

## Raspberry Pi 3 Model B  

The Raspberry Pi 3 has higher specs and built-in WiFi and Bluetooth, so it draws
more power. As a consequence, it has a shorter battery life than the
Raspberry Pi 2. So when selecting portable battery packs bear this in mind.

[Raspberry Pi 3 Model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)

## CareLink USB Stick

Currently, the primary supported device (in the OpenAPS documentation) for
uploading pump data and interfacing on the #OpenAPS is the CareLink USB stick for the Pi.
We recommend you purchase at least two sticks because if one breaks, acquiring
another stick will take time and will delay development. Additionally, due to
the short range of communication between the CareLink stick and the Medtronic
pumps, some users set up multiple sticks in different locations to maximize the
chances of successful transmissions. Some places to purchase: [Medtronic](https://medtronicdiabetes.secure.force.com/store/remotes-parts/carelink-usb-device/usb-wireless-upload-device) or [American Diabetes Wholesale](http://www.adwdiabetes.com/product/minimed-carelink-usb-upload_1164.htm).

A limitation of the Carelink USB stick is the short range of radio
communications with the Medtronic pump. The radio signals are transmitted from
the end of the stick opposite the USB connector, on the flat grey side of the
stick (see this [set of experiments](https://gist.github.com/channemann/0ff376e350d94ccc9f00)
for details). Using a USB extension cable and angling the stick appropriately will assist in improving the connection. See [Rerii 90 Degree USB Extension Cable](http://www.amazon.com/gp/product/B00ZQVADNM) or [Mediabridge Products USB Extension Cable](https://www.mediabridgeproducts.com/product/usb-2-0-usb-extension-cable-a-male-to-a-female-6-inches/).

## Alternative to Carelink USB - Use a TI stick

A [TI stick](http://www.ti.com/tool/cc1111emk868-915) has improved range compared to a carelink stick. However, the main setup docs refer to a carelink stick, so if you pick a TI stick you'll want to head over to [the mmeowlink wiki](https://github.com/oskarpearson/mmeowlink/wiki) for information about preparing and using the TI stick. Then, come back to Phase 1 docs to continue your setup process.

## Micro SD Card

An 8 or 16 GB micro SDHC card is recommended. Get one that is class-4 or greater
and is a recognized name brand, such as SanDisk, Kingston, or Sony. A list of
verified working hardware (including SD cards) can be found
[here](http://elinux.org/RPi_VerifiedPeripherals).

[SanDisk Ultra 16GB Ultra Micro SDHC UHS-I/Class 10 Card with Adapter](http://www.amazon.com/gp/product/B010Q57SEE)

[Sony 16GB Class 10 UHS-1 Micro SDHC](http://www.amazon.com/Sony-Class-Memory-SR16UY2A-TQ/dp/B00X1404P8)

Note: A known issue with the Raspberry Pi is that the SD card may get corrupted
with frequent power cycles, such as when the system gets plugged and unplugged
frequently from an external battery. Most core developers of openaps recommend
purchasing extra SD cards and having them pre-imaged and ready to use with a
backup copy of openaps installed, so you can swap it out on the go for continued
use of the system.

## WiFi Adapter (Raspberry Pi 2 only)

A minimalistic, unobtrusive WiFi USB adapter is recommended. The low-profile
helps to avoid damage to both the RPi2 and the adapter as the RPi2 will be
transported everywhere with the user.

[Edimax EW-7811Un 150Mbps 11n Wi-Fi USB Adapter](http://www.amazon.com/Edimax-EW-7811Un-150Mbps-Raspberry-Supports/dp/B003MTTJOY/ref=sr_1_1?ie=UTF8&qid=1432614150&sr=8-1&keywords=edimax)

[Buffalo AirStation N150 Wireless USB Adapter](http://www.amazon.com/BUFFALO-AirStation-N150-Wireless-Adapter/dp/B003ZM17RA/ref=sr_1_1?ie=UTF8&qid=1434523524&sr=8-1&keywords=airstation+n150)

## 2.1 Amp USB Battery Power Supply

A large-capacity power supply that is greater than 8000 mAh (milliAmp-hours) is
recommended for full day use. Make sure that the battery has at least one 2.1
Amp USB output. A battery with a form-factor that minimizes size is recommended,
to allow the patient to be as ambulatory as possible. When you have a full
OpenAPS implemented and working, you will want to have multiple batteries to
rotate and recharge. A battery that can deliver power while it charges is ideal
as you will be able to charge it on-the-fly without shutting down and restarting
the Raspberry Pi.

[TeckNet® POWER BANK 9000mAh USB External Battery Backup Pack](http://www.amazon.com/gp/product/B00FBD3O2M)

[Zendure® 2nd Gen A3 Portable Charger 10000mAh - 2.1a Dual USB - in-line charging](http://www.amazon.com/Zendure-2nd-Portable-Charger-10000mAh/dp/B014RBEAQC/ref=sr_1_1)

## USB Cables

USB cables with a micro connector on one end and a standard (Type A) connector
on the other are used to connect the power supply and the Dexcom receiver to the
Raspberry Pi. Most cables will work fine, but some prefer to select lengths
and/or features (such as right-angled connectors) to improve portability.

[Rerii Black Golden Plated 15 cm Length Micro-B Male Left Angle USB cable](http://www.amazon.com/Rerii-Micro-B-Charging-Guarantee-Fulfilled/dp/B00S9WXY5O/)

[Monoprice Premium USB to Micro USB Charge, Sync Cable - 3ft](http://www.monoprice.com/Product?c_id=103&cp_id=10303&cs_id=1030307&p_id=9763&seq=1&format=2)

## Cases

The Raspberry Pi is extremely minimalistic and does not come in a protective
case. This is fine for development work, but presents an issue for day-to-day
use. There are hundreds of cases available, but here is an example of what
others are using in their OpenAPS builds:

[JBtek® Jet Black Case for Raspberry Pi B+ & Raspberry Pi 2 Model & Raspberry Pi 3 Model B](http://www.amazon.com/gp/product/B00ONOKPHC)

Additionally, for mobile use, it is helpful to have something besides a lunchbox
to carry the entire rig around. The size and weight of the component set as well
as the limited range of the CareLink USB stick constrains the options here, but
there are still some workable solutions. Waist-worn running gear and camera
cases seem to work well. Two options: [FlipBelt](https://flipbelt.com/) and
[Lowepro Dashpoint 20](http://store.lowepro.com/dashpoint-20).

## HDMI Cable, USB Keyboard, USB Mouse

For the initial set up of the Raspberry Pi you may want to use a monitor and
keyboard/mouse to set up the WiFi connection, but all other access can be done
through a SSH Terminal (explained later). This means the monitor, mouse, and
keyboard are only used for a few minutes and generally aren't required again.
