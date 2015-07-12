
# Hardware
This section describes the hardware components required for a 'typical' OpenAPS implementation. There are numerous variations and substitutions that can be made, but the following items are recommended for getting started. If you come across something that doesn't seem to work, is no longer available, or have a notable alternative, feel free to edit this document with your suggestions.


## Recommended Hardware

Required
* Raspberry Pi 2 Model B
* 8 GB (or greater) micro SD card
* Low-profile USB WiFi adapter
* 2.1 Amp (or greater) USB power supply
* Medtronic CareLink USB stick
* Medtronic insulin pump: 512/712, 515/715, 522/722, or 523/723 (with firmware 2.4A or lower) 
* Dexcom CGM (G4 Platinum or Platinum with Share system) OR Medtronic CGM (MiniMed Paradigm REAL-Time Revel or Enlite)
* Micro USB cable(s)

Optional
* Battery with USB output
* Cat5 or Cat6 ethernet cable
* HDMI cable

A mostly complete kit recommended by several #OpenAPS contributors can be purchased through [Amazon](http://www.amazon.com/CanaKit-Raspberry-Complete-Original-Preloaded/dp/B008XVAVAW/ref=sr_1_1?ie=UTF8&qid=1434523139&sr=8-1&keywords=canakit+raspberry+pi+2). This kit has the RPi2, SD card, WiFi adapter, and wall power supply. It also comes with a case, HDMI cable, and heat sink, none of which are required for an OpenAPS build. The kit does not have a micros USB cable (required to connect a Dexcom G4 receiver to the RPi) or a battery, which can be used in lieu of the wall power supply for portability.

Additionally, for the Raspberry Pi and peripherals, verified sets of working hardware can be found [here](http://elinux.org/RPi_VerifiedPeripherals)

Eventually, once you have an entire OpenAPS build up and running, it is recommended that you have backup sets of equipment in case of failure.

## Hardware Details & Recommendations

**Raspberry Pi 2 Model B**

The Raspberry Pi 2 (RPi2) model B is a credit-card sized single-board computer which is used as a development board, used to prototype various applications of #OpenAPS. The RPi2 primarily uses Linux kernel based operating systems, which must be installed by the user onto a micro SD card for the RPi2 to work. The RPi2 currently only supports Ubuntu, Raspbian, OpenELEC, and RISC OS. We recommend installing either Ubuntu or Raspbian. In this tutorial, you will learn how to do a "cableless" and "headless" install of Raspbian, so you may access and control the RPi2 via a SSH client on Windows/Mac OS X/Linux/iOS/Android.
 
The RPi2 has 4 USB ports, an ethernet port, an HDMI port, and a micro USB power-in jack that accepts 2.1 Amp power supplies. In this tutorial, you will need to access the USB ports, micro USB power-in jack, and possibly the Ethernet jack (if failure occurs).

[Raspberry Pi 2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)


**Micro SD Card**

An 8 or 16 GB micro SDHC card is recommended, that is class-4 or greater, and is a recognized name brand like SanDisk Kingston. A list of verified working hardware (including SD cards) can be found [here](http://elinux.org/RPi_VerifiedPeripherals).

[Sony 16GB Class 10 UHS-1 Micro SDHC](http://www.amazon.com/Sony-Class-Memory-SR16UY2A-TQ/dp/B00X1404P8/ref=dp_ob_title_ce)


**WiFi Adapter**

A minimalistic, unobrtusive WiFi USB adapter is recommended, to avoid damage to both the RPi2 and the adapter, since the RPi2 is being transported everywhere with the patient.

[Buffalo AirStation N150 Wireless USB Adapter](http://www.amazon.com/BUFFALO-AirStation-N150-Wireless-Adapter/dp/B003ZM17RA/ref=sr_1_1?ie=UTF8&qid=1434523524&sr=8-1&keywords=airstation+n150)

[Edimax EW-7811Un 150Mbps 11n Wi-Fi USB Adapter](http://www.amazon.com/Edimax-EW-7811Un-150Mbps-Raspberry-Supports/dp/B003MTTJOY/ref=sr_1_1?ie=UTF8&qid=1432614150&sr=8-1&keywords=edimax)


**2.1 Amp USB Battery Power Supply**

A large capacity power supply that is greater than 8000 mAh (milliAmp-hours) is recommended for full day use. A battery with a form-factor that minimizes size is recommended, to allow the patient to be as ambulatory as possible. When you have a full #OpenAPS system implemented and working, you will want to have multiple batteries to rotate and recharge.

 [Power Bank 12000mAh Vinsic Genius External Mobile Battery Charger Pack](http://www.amazon.com/dp/B00M6V0R2C/ref=wl_it_dp_o_pC_nS_ttl?_encoding=UTF8&colid=2OYKR43UGE0YB&coliid=IC4EHVFRTC117&psc=1)
 
 [Anker 2nd Gen Astro E3 Ultra Compact 10000mAh External Battery](http://www.amazon.com/gp/product/B009USAJCC/ref=od_aui_detailpages00?ie=UTF8&psc=1)


**CareLink USB Stick**

Currently, the only supported device for uploading pump data and interfacing on the #OpenAPS is the CareLink USB stick. We recommend you purchase at least two sticks because if one breaks, acquiring another stick will take time and will delay development.

[Medtronic](https://medtronicdiabetes.secure.force.com/store/carelink-usb--remotes/usb-wireless-upload-device)

 [American Diabetes Wholesale](http://www.adwdiabetes.com/product/minimed-carelink-usb-upload_1164.htm)
 

**Dexcom G4 Platinum System -- with or without Share**

The Dexcom G4 Platinum system, with or without Share features is required to use #OpenAPS. However, the Share platform is not used in #OpenAPS as the system is designed to operate without an Internet connection. In order to get the data, a micro USB to USB cable must be connected to the RPi2 to upload the data at specified times.


**Medtronic 522/722, 515/715, or 512/712 Series Insulin Pump**

These specific models of the Medtronic Paradigm series insulin pumps are the only compatible pumps that will work with #OpenAPS. Any other pump will not work. Security features have been added to any pump after the Medtronic 522 or 722 series insulin pumps making remote adjustments in insulin unfeasible at this point of time. However, with collaboration from industry, we hope to find partners who will let us use our pumps as we want to as patients.


**USB Cables**

Two USB cables with a right-angled micro USB end

[Amazon Link](http://www.amazon.com/Rerii-Micro-B-Charging-Guarantee-Fulfilled/dp/B00S9WXY5O/ref=sr_1_8?ie=UTF8&qid=1434603920&sr=8-8&keywords=micro+usb+right+angle)