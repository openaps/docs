# Hardware
This section describes the hardware components required for a 'typical' OpenAPS
implementation. There are numerous variations and substitutions that can be made
but the following items are recommended for getting started. The basic setup
requires a compatible Insulin Pump, CGM data acquired either directly from a
receiver or from Nightscout, then a small computer to run openaps. If you come
across something that doesn't seem to work, is no longer available, or if you
have a notable alternative, feel free to edit this document with your
suggestions.

To start, here is a high-level guide for understanding if your pump is
compatible for OpenAPS:

!["Can I do OpenAPS with this pump?"](Can_I_close_the_loop_with_this_pump_May_20_2016.jpg "Can I do OpenAPS with this pump?")

If you're interested in working on communication for another pump (Omnipod,
Animas, etc), [click here](http://bit.ly/1nTtccH) to join the collaboration
group focusing on alternative pump communication.

## Required  Hardware for a "typical" setup

* <b>An Insulin Pump</b>. One of the following Medtronic MiniMed models:
    * 512/712
    * 515/715
    * 522/722
    * 523/723 (with firmware 2.4A or lower)
    * 554/754 (European Veo, with firmware 2.6A or lower)
    * (To check firmware, hit Esc on the home screen and scroll all the way to
      the bottom. You can also go into the Utilities menu and look for a PC
      Connect option. If that is present, the pump will *not* work for looping.
      If it's absent, it should be able to receive temp basal commands.)
    * If you have one of the above mentioned pumps, but it has buttons that do
      not work, use the instructions found on this
      [Imgur photo album](http://imgur.com/a/iOXAP) to repair your pump.
* <b>A way to communicate with the pump</b>:
    * A Medtronic CareLink USB stick is the recommended option for your initial
      loop setup
    * **Note** that there are now other hardware options available to
      communicate with the pump. Some positives to an alternative include better
      range; some negatives include having to solder and the fact that they're
      not documented in this set of documentation yet. But if you're interested,
      check out some of the alternatives in
      [the mmeowlink wiki](https://github.com/oskarpearson/mmeowlink/wiki).
* <b>A Continuous Glucose Monitor (CGM)</b>. One of the following:
    * Dexcom CGM (G4 Platinum or Platinum with Share system)
    * Dexcom G5 Mobile system
    * Medtronic CGM (MiniMed Paradigm REAL-Time Revel or Enlite)
        * **Note** The Medtronic Minimed 530g Pump's Enlite CGM Sensors CAN be
          used with the older OpenAPS compatible Medtronic Pumps (Despite that
          pump originally being offered with SoftSensor CGM Sensors).
* <b>A Small Computer</b>. One of the following:
    * Raspberry Pi 2 Model B ("RPi2") with a Low-profile USB WiFi adapter (see
      "Raspberry Pi 2" section below)
    * Raspberry Pi 3 Model B (“RPi3”) with built in WiFi
    * **Note** A Raspberry Pi is what is used for the documentation; again see
      [the mmeowlink wiki](https://github.com/oskarpearson/mmeowlink/wiki) for
      some alternatives to the Raspberry Pi.
* An 8 GB (or greater) micro SD card
* <b>Additional Supplies</b>
    * Micro SD card to regular SD card converter \[optional, but recommended so
      that you can use the micro SD card in a regular sized SD card drive\]
    * 2.1 Amp (or greater) USB power supply or battery
    * Micro USB cable(s)
    * AAA batteries (for pump)
    * Case \[optional\]
    * Cat5 or Cat6 Ethernet cable \[optional\]
    * HDMI cable \[optional, used for connecting the RPi2 to a screen for
      initial setup ease\]
    * USB Keyboard \[optional, used to interact with the RPi2 via its own
      graphics interface on your TV screen\]
    * USB Mouse \[optional, for the same purpose\]

#### Raspberry Pi Starter Kits

###### Raspberry Pi 2 Starter Kit

Several #OpenAPS contributors recommend the Raspberry Pi 2 CanaKit, which
includes several essential accessories in one package and can be purchased
through
[Amazon](http://www.amazon.com/CanaKit-Raspberry-Complete-Original-Preloaded/dp/B008XVAVAW/)

Raspberry Pi 3 version is also available and allows for BLE out of the box.

The CanaKit has the RPi2, SD card, WiFi adapter, and wall power supply. It also
comes with a case, HDMI cable, and heat sink, none of which are required for an
OpenAPS build. The kit does not have a micro USB cable (required to connect a
Dexcom G4 receiver to the RPi) or a battery, which can be used in lieu of the
wall power supply for portability.

###### Raspberry Pi 3 Starter Kit

Contains components useful to get started with the Raspberry Pi.

Kit Includes:

* Latest Raspberry Pi 3 Model B (64bit Quad Core, 1GB RAM) (Required)
* 8GB or 16GB Sandisk Ultra Class 10 MicroSD (pre-imaged with NOOBS) (Required)
* Official Raspberry Pi 5.1V 2.5A International Power Supply (for UK, EU, USA &
  AUS) (Required)
* Black Raspberry Pi 3 Case (Useful)
* 2M HDMI cable (Optional)
* 2M Ethernet Cable (Optional)

This can be purchased here
[Pihut](https://thepihut.com/products/raspberry-pi-3-starter-kit)

<b>Eventually, once you have an entire OpenAPS build up and running, it is
recommended that you have backup sets of equipment in case of failure.</b>

## Hardware Details & Recommendations

### Medtronic Insulin Pump

See currently known working list of pumps above. The easiest way to navigate to
the Utilities / Connect Devices menu on your pump. If "PC Connect" is present in
this menu, your pump is _not_ compatible with OpenAPS.

Due to changes in the firmware, the openaps tools are only able to function in
full on the above pump models. Security features were added after the firmware
version 2.4 that prevent making some remote adjustments via the CareLink USB
stick. Each pump series is slightly different, and openaps functionality is
still being ironed out for some of them. For 512/712 pumps, certain commands
like Read Settings, BG Targets and certain Read Basal Profile are not available,
and requires creating a static json for needed info missing to successfully run
the loop ([see example here](http://bit.ly/1itCsRl)).

If you need to acquire an appropriate pump check CraigsList or other sites like
Medwow or talk to friends in your local community to see if there are any old
pumps lying around in their closets gathering dust.
[MedWow](http://www.medwow.com) is an eBay-like source for used pumps. Note: If
you're buying a pump online, we recommend you ask the seller to confirm the
firmware version of the pump. (You may also want to consider asking for a video
of the pump with working functionality before purchasing.)

There are several #OpenAPS participants working on ways to use other pumps
(including non-Medtronic models). If you would like to get more information on
the progress in these areas, take a look at the
[#OpenAPS Google Group](https://groups.google.com/d/forum/openaps-dev) or
[click here to join the Slack channel](http://bit.ly/1nTtccH).

### CareLink USB Stick

Currently, the primary supported device (in the OpenAPS documentation) for
uploading pump data and interfacing on the #OpenAPS is the CareLink USB stick.
We recommend you purchase at least two sticks because if one breaks, acquiring
another stick will take time and will delay development. Additionally, due to
the short range of communication between the CareLink stick and the Medtronic
pumps, some users set up multiple sticks in different locations to maximize the
chances of successful transmissions.

Some places to purchase:
[Medtronic](https://medtronicdiabetes.secure.force.com/store/remotes-parts/carelink-usb-device/usb-wireless-upload-device)
or
[American Diabetes Wholesale](http://www.adwdiabetes.com/product/minimed-carelink-usb-upload_1164.htm).

A limitation of the Carelink USB stick is the short range of radio
communications with the Medtronic pump. The radio signals are transmitted from
the end of the stick opposite the USB connector, on the flat grey side of the
stick (see this
[set of experiments](https://gist.github.com/channemann/0ff376e350d94ccc9f00)
for details). Using a USB extension cable and angling the stick appropriately
will assist in improving the connection.

[Rerii 90 Degree USB Extension Cable](http://www.amazon.com/gp/product/B00ZQVADNM)

[Mediabridge Products USB Extension Cable](https://www.mediabridgeproducts.com/product/usb-2-0-usb-extension-cable-a-male-to-a-female-6-inches/)

### CGM: Dexcom G4 Platinum System (with or without Share), Dexcom G5 Mobile OR Medtronic

The openaps tool set currently supports three different CGM systems: the Dexcom
G4 Platinum system (with or without the
[Share](http://www.dexcom.com/dexcom-g4-platinum-share) functionality), the
newer Dexcom G5 Mobile system and the
[Medtronic system](https://www.medtronicdiabetes.com/treatment-and-products/enlite-sensor).
With Dexcom G4, the Share platform is not required as communication with the
receiver is usually accomplished via USB directly to the Pi. For Dexcom G5
Mobile you can also use a compatible receiver (software upgraded G4 with Share
receiver or a G5 Mobile Receiver). You can also pull CGM data from Nightscout as
an alternative (including Dexcom G5 to iOS device + Nightscout Bridge plugin),
or use xDrip (see below). The Medtronic CGM system communicates directly with
the associated pump, so the data can be retrieved using the CareLink USB stick.

##### Using the Dexcom receiver CGM

Note: This is the Dexcom receiver hardware. Not any third party device you are
using as a receiver e.g., an iPhone or iPod. Your Dexcom should be nearly fully
charged before plugging it in to your Raspberry Pi. If, when you plug in your
receiver, it causes your WiFi dongle to stop blinking, that is a sign that it is
drawing too much power and needs to be charged. Once the receiver is fully
charged, it will stay charged when connected to the Pi.

Your OpenAPS implementation can also pull CGM data from a Nightscout site in
addition to pulling from the CGM directly. You can find more documentation about
pulling CGM data from a Nightscout site
[here](../phase-1/using-openaps-tools#pulling-blood-glucose-levels-from-nightscout).
  
* If you have an Android phone, you can use the xDrip app to get your data from
  the Dexcom to Nightscout, to then be used in OpenAPS.
* If you have a Share receiver
  [follow these directions](http://www.nightscout.info/wiki/welcome/nightscout-with-xdrip-and-dexcom-share-wireless)
  to set up your Android uploader and Nightscout website.
* You could also build a DIY receiver. Directions to build the receiver, set up
  your uploader and Nightscout can be found
  [here](http://www.nightscout.info/wiki/nightscout-with-xdrip-wireless-bridge).
* You can also use part of the DIY receiver set up - the wixel – directly to the
  raspberry pi. Learn more about the wixel setup
  [here](https://github.com/jamorham/python-usb-wixel-xdrip) and
  [here](https://github.com/ochenmiller/wixelpi_uploader).

##### Using the Medtronic CGM

Because the Medtronic pump collects data directly from the Enlite sensors,
OpenAPS will retrieve CGM data in addition to your regular pump data from your
pump. While you use the same OpenAPS commands to get it, the Medtronic CGM data
need a little special formatting after being retrieved. We'll discuss these
special circumstances as they come up later.

### Raspberry Pi

The Raspberry Pi (RPi) is a credit-card sized single-board computer. The RPi
primarily uses Linux kernel based operating systems, which must be installed by
the user onto a micro SD card for the RPi to work. The RPi currently only
supports Ubuntu, Raspbian, OpenELEC, and RISC OS. We recommend installing either
Ubuntu or Raspbian. In this tutorial, you will learn how to do a "cableless" and
"headless" install of Raspbian. You will be able to access and control the RPi
via an SSH client on Windows, Mac OS X, Linux, iOS, or Android.

The RPi has 4 USB ports, an Ethernet port, an HDMI port, and a micro USB
power-in jack that accepts 2.1 Amp power supplies. In this tutorial, you will
need to access the USB ports, micro USB power-in jack, and possibly the Ethernet
jack (if wireless failure occurs). You will not require the HDMI port or a
monitor.

##### Raspberry Pi 2
The Raspberry Pi 2 has fewer and lower spec components and so draws less
power, but requires a WiFi adapter to be also purchased. The spec makes no
difference to the OpenAPS app, so either model is suitable choice.

[Raspberry Pi 2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)

##### Raspberry Pi 3 Model B  

The Raspberry Pi 3 has higher specs and built-in WiFi and Bluetooth, so it draws
more power. As a consequence, it has a shorter battery life than the
Raspberry Pi 2. So when selecting portable battery packs bare this in mind.

[Raspberry Pi 3 Model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)

### Micro SD Card

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

### WiFi Adapter (Raspberry Pi 2 only)

A minimalistic, unobtrusive WiFi USB adapter is recommended. The low-profile
helps to avoid damage to both the RPi2 and the adapter as the RPi2 will be
transported everywhere with the user.

[Edimax EW-7811Un 150Mbps 11n Wi-Fi USB Adapter](http://www.amazon.com/Edimax-EW-7811Un-150Mbps-Raspberry-Supports/dp/B003MTTJOY/ref=sr_1_1?ie=UTF8&qid=1432614150&sr=8-1&keywords=edimax)

[Buffalo AirStation N150 Wireless USB Adapter](http://www.amazon.com/BUFFALO-AirStation-N150-Wireless-Adapter/dp/B003ZM17RA/ref=sr_1_1?ie=UTF8&qid=1434523524&sr=8-1&keywords=airstation+n150)

### 2.1 Amp USB Battery Power Supply

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

### USB Cables

USB cables with a micro connector on one end and a standard (Type A) connector
on the other are used to connect the power supply and the Dexcom receiver to the
Raspberry Pi. Most cables will work fine, but some prefer to select lengths
and/or features (such as right-angled connectors) to improve portability.

[Rerii Black Golden Plated 15 cm Length Micro-B Male Left Angle USB cable](http://www.amazon.com/Rerii-Micro-B-Charging-Guarantee-Fulfilled/dp/B00S9WXY5O/)

[Monoprice Premium USB to Micro USB Charge, Sync Cable - 3ft](http://www.monoprice.com/Product?c_id=103&cp_id=10303&cs_id=1030307&p_id=9763&seq=1&format=2)

### AAA Batteries

Repeated wireless communication with the pump drains the battery quite quickly.
With a loop running every five minutes, a standard alkaline AAA—recommended by
Medtronic—lasts somewhere between four to six days before the pump goes to a
"Low Battery" state and stops allowing wireless transmission. Lithium batteries
last significantly longer but do not give much warning when they are about to
die, but alerts can be created to provide warning about the status of the
battery. For further information on batteries, see
[this study](https://gist.github.com/channemann/0a81661b78703fcb8da6) on AAA
battery use in a looping pump.

### Cases

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

### HDMI Cable, USB Keyboard, USB Mouse

For the initial set up of the Raspberry Pi you may want to use a monitor and
keyboard/mouse to set up the WiFi connection, but all other access can be done
through a SSH Terminal (explained later). This means the monitor, mouse, and
keyboard are only used for a few minutes and generally aren't required again.
