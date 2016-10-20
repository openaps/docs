# Information about compatible CGMs

* Dexcom G4 Platinum System (with or without Share)
* Dexcom G5 Mobile
* Medtronic (MiniMed Paradigm REAL-Time Revel or Enlite)

The openaps tool set currently supports three different CGM systems: the Dexcom
G4 Platinum system (with or without the
[Share](http://www.dexcom.com/dexcom-g4-platinum-share) functionality), the
newer Dexcom G5 Mobile system and the
[Medtronic system](https://www.medtronicdiabetes.com/treatment-and-products/enlite-sensor).

With Dexcom G4, the Share platform is not required as communication with the
receiver is usually accomplished via USB directly to the Pi. For Dexcom G5
Mobile you can also use a compatible receiver (software upgraded G4 with Share
receiver or a G5 Mobile Receiver). 

NOTE: You can also pull CGM data from Nightscout as
an alternative (including Dexcom G5 to iOS device + Nightscout Bridge plugin),
or use xDrip (see below). The Medtronic CGM system communicates directly with
the associated pump, so that data can be retrieved using the CareLink USB stick. The Medtronic Minimed 530g Pump's Enlite CGM Sensors CAN be used with the older OpenAPS compatible Medtronic Pumps (Despite that pump originally being offered with SoftSensor CGM Sensors).

### Using the Dexcom receiver CGM

This refers to the Dexcom receiver hardware. Note that your Dexcom should be nearly fully
charged before plugging it in to a Raspberry Pi. If, when you plug in your
receiver, it causes your WiFi dongle to stop blinking, that is a sign that it is
drawing too much power and needs to be charged. Once the receiver is fully
charged, it will stay charged when connected to the Pi.

### Pulling CGM data from the cloud

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

### Using the Medtronic CGM

Because the Medtronic pump collects data directly from the Enlite sensors,
OpenAPS will retrieve CGM data in addition to your regular pump data from your
pump. While you use the same OpenAPS commands to get it, the Medtronic CGM data
need a little special formatting after being retrieved. We'll discuss these
special circumstances as they come up later.
