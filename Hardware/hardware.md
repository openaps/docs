
## Required Hardware

* The Raspberry Pi 2 kit with peripherals [Amazon Link](http://www.amazon.com/CanaKit-Raspberry-Complete-Original-Preloaded/dp/B008XVAVAW/ref=sr_1_1?ie=UTF8&qid=1434523139&sr=8-1&keywords=canakit+raspberry+pi+2)
* A low-profile WiFi dongle [Amazon Link](http://www.amazon.com/BUFFALO-AirStation-N150-Wireless-Adapter/dp/B003ZM17RA/ref=sr_1_1?ie=UTF8&qid=1434523524&sr=8-1&keywords=airstation+n150)
* 2.1 Amp USB power supply [Amazon Link](http://www.amazon.com/dp/B00M6V0R2C/ref=wl_it_dp_o_pC_nS_ttl?_encoding=UTF8&colid=2OYKR43UGE0YB&coliid=IC4EHVFRTC117&psc=1)
* Medtronic CareLink USB stick [American Diabetes Wholesale Link](http://www.adwdiabetes.com/product/minimed-carelink-usb-upload_1164.htm)
* Medtronic 522/722, 515/715, or 512/712 series insulin pump
* Dexcom G4 Platinum System (Receiver and transmitter) or Dexcom G4 Platinum with Share System (receiver and transmitter)
* Two USB cables with a right-angled micro USB end [Amazon Link](http://www.amazon.com/Rerii-Micro-B-Charging-Guarantee-Fulfilled/dp/B00S9WXY5O/ref=sr_1_8?ie=UTF8&qid=1434603920&sr=8-8&keywords=micro+usb+right+angle)
* `[Optional]` Cat5 or Cat6 ethernet cable

Eventually, once you have an entire `#OpenAPS` system implemented, it is recommended that you have backup sets of equipment, in case of failure.

Additionally, for the Raspberry Pi and peripherals, verified sets of working hardware can be found [here](http://elinux.org/RPi_VerifiedPeripherals)



## Hardware Details

**Raspberry Pi 2 Model B**

The Raspberry Pi 2 (RPi2) model B is a credit-card sized single-board computer which is used as a development board, used to prototype various applications of #OpenAPS. The RPi2 primarily uses Linux kernel based operating systems, which must be installed by the user onto a micro SD card for the RPi2 to work. The RPi2 currently only supports Ubuntu, Raspbian, OpenELEC, and RISC OS. We recommend installing either Ubuntu or Raspbian. In this tutorial, you will learn how to do a "cableless" and "headless" install of Raspbian, so you may access and control the RPi2 via a SSH client on Windows/Mac OS X/Linux/iOS/Android.
 
The RPi2 has 4 USB ports, an ethernet port, an HDMI port, and a micro USB power-in jack that accepts 2.1 Amp power supplies. In this tutorial, you will need to access the USB ports, micro USB power-in jack, and possibly the Ethernet jack (if failure occurs).

**Micro SD Card**

An 8 GB micro SDHC card is recommended, that is class-4 or greater, and is a recognized name brand like SanDisk or Kingston. A list of verified working hardware (including SD cards) can be found [here](http://elinux.org/RPi_VerifiedPeripherals).

**WiFi Adapter**

A minimalistic, unobrtusive WiFi USB adapter is recommended, to avoid damage to both the RPi2 and the adapter, since the RPi2 is being transported everywhere with the patient.

**2.1 Amp USB Battery Power Supply**

A large capacity power supply that is greater than 8000 mAh (milliAmp hours) is recommended for full day use. A battery with a form-factor that minimizes size is recommended, to allow the patient to be as ambulatory as possible. When you have a full #OpenAPS system implemented and working, you will want to have acquired multiple batteries to rotate and recharge.

**CareLink USB Stick**

Currently, the only supported device for uploading pump data and interfacing on the #OpenAPS is the CareLink USB stick. We recommend you purchase at least two sticks because if one breaks, acquiring another stick will take time and will delay development.

**Dexcom G4 Platinum System -- with or without Share**

The Dexcom G4 Platinum system, with or without Share features is required to use #OpenAPS. However, the Share platform is not used in #OpenAPS as the system is designed to operate without an Internet connection. In order to get the data, a micro USB to USB cable must be connected to the RPi2 to upload the data at specified times.


**Medtronic 522/722, 515/715, or 512/712 Series Insulin Pump**

These specific models of the Medtronic Paradigm series insulin pumps are the only compatible pumps that will work with #OpenAPS. Any other pump will not work. Security features have been added to any pump after the Medtronic 522 or 722 series insulin pumps making remote adjustments in insulin unfeasible at this point of time. However, with collaboration from industry, we hope to find partners who will let us use our pumps as we want to as patients.

----------