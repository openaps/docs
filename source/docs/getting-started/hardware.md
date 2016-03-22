
# Hardware
This section describes the hardware components required for a 'typical' OpenAPS implementation. There are numerous variations and substitutions that can be made but the following items are recommended for getting started. If you come across something that doesn't seem to work, is no longer available, or if you have a notable alternative, feel free to edit this document with your suggestions.

If you're interested in working on communication for another pump (Omnipod, Animas, etc), email Dana (dana@OpenAPS.org) to be added to the collaboration group focusing on alternative pump communication.


## Required  Hardware

* <b>Insulin Pump</b>: Medtronic MiniMed model #:
 * 512/712
 * 515/715
 * 522/722
 * 523/723 (with firmware 2.4A or lower)
 * 554 (European Veo, with firmware 2.6A or lower)
* <b>Pump Communication</b>:
 * Medtronic CareLink USB stick
* <b>Continuous Glucose Monitor (CGM)</b>:
 * Dexcom CGM (G4 Platinum or Platinum with Share system) OR
 * Medtronic CGM (MiniMed Paradigm REAL-Time Revel or Enlite)
* <b>Other Supplies</b>:
 * Raspberry Pi 2 Model B ("RPi2")**(see note below)
 * 8 GB (or greater) micro SD card
 * Micro SD card to regular SD card converter [optional, but recommended so that you can use the micro SD card in a regular sized SD card drive]
 * Low-profile USB WiFi adapter
 * 2.1 Amp (or greater) USB power supply or battery
 * Micro USB cable(s)
 * AAA batteries (for pump)
 * Case [optional]
 * Cat5 or Cat6 Ethernet cable [optional]
 * HDMI cable [optional, used for connecting the RPi2 to a screen for initial setup ease]
 * USB Keyboard [optional, used to interact with the RPi2 via its own graphics interface on your TV screen]
 * USB Mouse [optional, for the same purpose]

\** Note: Several #OpenAPS contributors recommend the Raspberry Pi 2 CanaKit, which includes several essential accessories in one package and can be purchased through [Amazon](http://www.amazon.com/CanaKit-Raspberry-Complete-Original-Preloaded/dp/B008XVAVAW/)

The CanaKit has the RPi2, SD card, WiFi adapter, and wall power supply. It also comes with a case, HDMI cable, and heat sink, none of which are required for an OpenAPS build. The kit does not have a micro USB cable (required to connect a Dexcom G4 receiver to the RPi) or a battery, which can be used in lieu of the wall power supply for portability.

Additionally, for the Raspberry Pi and peripherals, verified sets of working hardware can be found [here](http://elinux.org/RPi_VerifiedPeripherals).

Eventually, once you have an entire OpenAPS build up and running, it is recommended that you have backup sets of equipment in case of failure.

## Hardware Details & Recommendations

### Medtronic Insulin Pump

See currently known working list of pumps above. The easiest way to navigate to the Utilities / Connect Devices menu on your pump. If "PC Connect" is present in this menu, your pump is _not_ compatible with OpenAPS.

Due to changes in the firmware, the openaps tools are only able to function in full on the above pump models. Security features were added in firmware version 2.5A that prevent making some remote adjustments via the CareLink USB stick. Each pump series is slightly different, and openaps functionality is still being ironed out for some of them. For 512/712 pumps, certain commands like Read Settings, BG Targets and certain Read Basal Profile are not available, and requires creating a static json for needed info missing to successfully run the loop ([see example here](http://bit.ly/1itCsRl)).

If you need to acquire an appropriate pump check CraigsList or other sites like Medwow or talk to friends in your local community to see if there are any old pumps lying around in their closets gathering dust. [MedWow](http://www.medwow.com) is an eBay-like source for used pumps. Note: If you're buying a pump online, we recommended you ask the seller to confirm the firmware version of the pump. (You may also want to consider asking for a video of the pump with working functionality before purchasing.)

There are several #OpenAPS participants working on ways to use other pumps (including non-Medtronic models). If you would like to get more information on the progress in these areas, email dana@OpenAPS.org to be added to the Slack communication channel.


### CareLink USB Stick

Currently, the only supported device\* for uploading pump data and interfacing on the #OpenAPS is the CareLink USB stick. We recommend you purchase at least two sticks because if one breaks, acquiring another stick will take time and will delay development. Additionally, due to the short range of communication between the CareLink stick and the Medtronic pumps, some users set up multiple sticks in different locations to maximize the chances of successful transmissions.

[Medtronic](https://medtronicdiabetes.secure.force.com/store/remotes-parts/carelink-usb-device/usb-wireless-upload-device)

[American Diabetes Wholesale](http://www.adwdiabetes.com/product/minimed-carelink-usb-upload_1164.htm)
 
A limitation of the Carelink USB stick is the short range of radio communications with the Medtronic pump. The radio signals are trasmitted from the end of the stick opposite the USB connector, on the flat grey side of the stick (see this [set of experiments](https://gist.github.com/channemann/0ff376e350d94ccc9f00) for details). Using a USB extension cable and angling the stick appropriately will assist in improving the connection.

[Rerii 90 Degree USB Extension Cable](http://www.amazon.com/gp/product/B00ZQVADNM)

[Mediabridge Products USB Extension Cable](https://www.mediabridgeproducts.com/product/usb-2-0-usb-extension-cable-a-male-to-a-female-6-inches/)

_*Note that there are a few options in progress that may become alternatives to the Carelink, although they are not documented in the OpenAPS docs yet. ["RileyLink"](https://github.com/ps2/rileylink) is another DIY piece of hardware that is in development and has potential to replace the CareLink stick & Raspberry Pi to communicate with a pump. It is not yet built out and reliable to be a part of an OpenAPS yet, and thus is not currently recommended. There are also other pieces of DIY hardware that are works in progress that may be alternatives to using the CareLink stick and Raspberry Pi, so stay tuned._
 

### CGM: Dexcom G4 Platinum System (with or without Share) OR Medtronic

The openaps tool set currently supports two different CGM systems: the Dexcom G4 Platinum system (with or without the [Share](http://www.dexcom.com/dexcom-g4-platinum-share) functionality) and the [Medtronic system](https://www.medtronicdiabetes.com/treatment-and-products/enlite-sensor). With Dexcom, the Share platform is not required as communication with the receiver is usually accomplished via USB directly to the Pi. You can also pull CGM data from Nightscout as an alternative (documentation coming soon), or use xDrip (see below). The Medtronic CGM system communicates directly with the associated pump, so the data can be retrieved using the CareLink USB stick.

<b> Using the Dexcom CGM: </b>

Note: Your Dexcom should be nearly fully charged before plugging it in to your Raspberry Pi. If, when you plug in your receiver, it causes your WiFi dongle to stop blinking, that is a sign that it is drawing too much power and needs to be charged. Once the receiver is fully charged, it will stay charged when connected to the Pi.

Your OpenAPS implementation can also pull CGM data from a Nightscout site in addition to pulling from the CGM directly. 

* You can find more documentation about pulling CGM data from a Nightscout site [here](../Log-clean-analyze-with-openaps-tools/using.md#pulling-blood-glucose-levels-from-nightscout).
* If you have an Android phone, you can use the xDrip app to get your data from the Dexcom to Nightscout, to then be used in OpenAPS. 
 * If you have a Share receiver [follow these directions](http://www.nightscout.info/wiki/welcome/nightscout-with-xdrip-and-dexcom-share-wireless) to set up your Android uploader and Nightscout website.
 * You could also build a DIY receiver. Directions to build the receiver, set up your uploader and Nightscout can be found [here](http://www.nightscout.info/wiki/nightscout-with-xdrip-wireless-bridge).
 * You can also use part of the DIY receiver set up - the wixel – directly to the raspberry pi. Learn more about the wixel setup [here](https://github.com/jamorham/python-usb-wixel-xdrip) and [here](https://github.com/ochenmiller/wixelpi_uploader).

<b> Using the Medtronic CGM: </b>

Because the Medronic pump collects data directly from the Enlite sensors, OpenAPS will retrieve CGM data in addition to your regular pump data from your pump. While you use the same OpenAPS commands to get it, the Medtronic CGM data need a little special formatting after being retrieved. We'll discuss these special circumstances as they come up later. 

### Raspberry Pi 2 Model B

The Raspberry Pi 2 (RPi2) model B is a credit-card sized single-board computer. The RPi2 primarily uses Linux kernel based operating systems, which must be installed by the user onto a micro SD card for the RPi2 to work. The RPi2 currently only supports Ubuntu, Raspbian, OpenELEC, and RISC OS. We recommend installing either Ubuntu or Raspbian. In this tutorial, you will learn how to do a "cableless" and "headless" install of Raspbian. You will be able to access and control the RPi2 via an SSH client on Windows, Mac OS X, Linux, iOS, or Android.
 
The RPi2 has 4 USB ports, an ethernet port, an HDMI port, and a micro USB power-in jack that accepts 2.1 Amp power supplies. In this tutorial, you will need to access the USB ports, micro USB power-in jack, and possibly the Ethernet jack (if wireless failure occurs). You will not require the HDMI port or a monitor.

[Raspberry Pi 2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)


### Micro SD Card

An 8 or 16 GB micro SDHC card is recommended. Get one that is class-4 or greater and is a recognized name brand, such as SanDisk, Kingston, or Sony. A list of verified working hardware (including SD cards) can be found [here](http://elinux.org/RPi_VerifiedPeripherals).

[SanDisk Ultra 16GB Ultra Micro SDHC UHS-I/Class 10 Card with Adapter](http://www.amazon.com/gp/product/B010Q57SEE)

[Sony 16GB Class 10 UHS-1 Micro SDHC](http://www.amazon.com/Sony-Class-Memory-SR16UY2A-TQ/dp/B00X1404P8)

Note: A known issue with the Raspberry Pi is that the SD card may get corrupted with frequent power cycles, such as when the system gets plugged and unplugged frequently from an external battery. Most core developers of openaps recommend purchasing extra SD cards and having them pre-imaged and ready to use with a backup copy of openaps installed, so you can swap it out on the go for continued use of the system.

### WiFi Adapter

A minimalistic, unobtrusive WiFi USB adapter is recommended. The low-profile helps to avoid damage to both the RPi2 and the adapter as the RPi2 will be transported everywhere with the user.

[Edimax EW-7811Un 150Mbps 11n Wi-Fi USB Adapter](http://www.amazon.com/Edimax-EW-7811Un-150Mbps-Raspberry-Supports/dp/B003MTTJOY/ref=sr_1_1?ie=UTF8&qid=1432614150&sr=8-1&keywords=edimax)

[Buffalo AirStation N150 Wireless USB Adapter](http://www.amazon.com/BUFFALO-AirStation-N150-Wireless-Adapter/dp/B003ZM17RA/ref=sr_1_1?ie=UTF8&qid=1434523524&sr=8-1&keywords=airstation+n150)


### 2.1 Amp USB Battery Power Supply

A large-capacity power supply that is greater than 8000 mAh (milliAmp-hours) is recommended for full day use. Make sure that the battery has at least one 2.1 Amp USB output. A battery with a form-factor that minimizes size is recommended, to allow the patient to be as ambulatory as possible. When you have a full OpenAPS implemented and working, you will want to have multiple batteries to rotate and recharge. A battery that can deliver power while it charges is ideal as you will be able to charge it on-the-fly without shutting down and restarting the RPi2.

[TeckNet® POWER BANK 9000mAh USB External Battery Backup Pack](http://www.amazon.com/gp/product/B00FBD3O2M)


### USB Cables

USB cables with a micro connector on one end and a standard (Type A) connector on the other are used to connect the power supply and the Dexcom receiver to the RPi2. Most cables will work fine, but some prefer to select lengths and/or features (such as right-angled connectors) to improve portability.

[Rerii Black Golden Plated 15 cm Length Micro-B Male Left Angle USB cable](http://www.amazon.com/Rerii-Micro-B-Charging-Guarantee-Fulfilled/dp/B00S9WXY5O/)

[Monoprice Premium USB to Micro USB Charge, Sync Cable - 3ft](http://www.monoprice.com/Product?c_id=103&cp_id=10303&cs_id=1030307&p_id=9763&seq=1&format=2)


### AAA Batteries

Repeated wireless communication with the pump drains the battery quite quickly. With a loop running every five minutes, a standard alkaline AAA—recommended by Medtronic—lasts somewhere between four to six days before the pump goes to a "Low Battery" state and stops allowing wireless transmission. Lithium batteries last significantly longer but do not give much warning when they are about to die, but alerts can be created to provide warning about the status of the battery. For further information on batteries, see [this study](https://gist.github.com/channemann/0a81661b78703fcb8da6) on AAA battery use in a looping pump. 


### Cases

The Raspberry Pi is extremely minimalistic and does not come in a protective case. This is fine for development work, but presents an issue for day-to-day use. There are hundreds of cases available, but here some examples of what others are using in their OpenAPS builds.

[JBtek® Jet Black Case for Raspberry Pi B+ & Raspberry Pi 2 Model B](http://www.amazon.com/gp/product/B00ONOKPHC)

[Raspberry Pi B+ /PI2 Acrylic Case](http://www.amazon.com/Raspberry-Pi-PI2-Acrylic-Case/dp/B00M9ZW6QU)

Additionally, for mobile use, it is helpful to have something besides a lunchbox to carry the entire rig around. The size and weight of the component set as well as the limited range of the CareLink USB stick constrains the options here, but there are still some workable solutions. Waist-worn running gear and camera cases seem to work well.

[FlipBelt](https://flipbelt.com/)

[Lowepro Dashpoint 20](http://store.lowepro.com/dashpoint-20)
