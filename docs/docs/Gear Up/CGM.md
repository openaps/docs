# Information about compatible CGMs
OpenAPS currently primarily supports these different CGM systems: 
* the Dexcom G4 Platinum system (with or without the Share functionality), 
* the Dexcom G5 system
* the Dexcom G6 system
* the older Medtronic CGM system (MiniMed Paradigm REAL-Time Revel or Enlite),  
* and other CGM or CGM-like devices (Abbott's FreeStyle Libre) if the data is uploaded to Nightscout and the OpenAPS rig has Internet connectivity.

### Using a Dexcom CGM

With Dexcom G4, the Share platform is not required; but is valuable for uploading BG data to the cloud (and into Nightscout, which can then send BGs to the rig). However, without Share, a G4 receiver can instead be plugged in directly to the OpenAPS rig. For Dexcom G5 you can also use a compatible receiver (software upgraded G4 with Share receiver or a G5 Mobile Receiver), or also pull data from the Dexcom Share servers into Nightscout for use with an Internet-connected OpenAPS rig. The same applies for G6 as it does for a G5. 

Also note that an easy way to [loop offline](https://openaps.readthedocs.io/en/latest/docs/Customize-Iterate/offline-looping-and-monitoring.html#c-send-g5-or-g6-bgs-direct-to-rig-xdrip-js-lookout-logger) is to choose the `xdrip-js` setup option during `oref0-setup` (in 0.7.0 and later versions) to have the rig pull directly from a G5 or G6 receiver. 

### Using the Medtronic CGM

As the Medtronic pump collects data directly from the Enlite sensors, OpenAPS will retrieve CGM data in addition to your regular pump data from your pump. This CGM setup means you can loop offline without any extra setup steps.

### Pulling CGM data from the cloud

Your OpenAPS implementation can also pull CGM data from a Nightscout site in addition to pulling from the CGM directly, when your rig has internet connectivity. You can find more documentation about pulling CGM data from a Nightscout site [here](https://openaps.readthedocs.io/en/latest/docs/While%20You%20Wait%20For%20Gear/nightscout-setup.html).
  
* If you have an Android phone, you can use the xDrip app to get your data from the Dexcom to Nightscout, to then be used in OpenAPS.
* If you have a Dexcom G4 Share receiver or Dexcom G5/G6 paired with your phone, you can send that data to Nightscout to be used by OpenAPS.
* You could also build a DIY receiver. Directions to build the receiver, set up your uploader and Nightscout can be found [here](http://www.nightscout.info/wiki/nightscout-with-xdrip-wireless-bridge).
* You can also use part of the DIY receiver set up - the wixel – directly to the Raspberry Pi. Learn more about the wixel setup [here](https://github.com/jamorham/python-usb-wixel-xdrip) and [here](https://github.com/ochenmiller/wixelpi_uploader).
* If you are using Abbott Freestyle Libre in combination with Sony SmartWatch 3 and xdrip+ (or possibly other combinations of technology to get Libre data up into the cloud), you can also pull CGM data directly from Nightscout.

### Offline looping options

See [this page for much more detail on all of your offline looping options](https://openaps.readthedocs.io/en/latest/docs/Customize-Iterate/offline-looping-and-monitoring.html) with various CGM types. 
