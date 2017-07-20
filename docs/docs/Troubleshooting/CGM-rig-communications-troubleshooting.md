# Troubleshooting problems between CGM and the rig

## First, know how you get data from BG to your rig
There are a few ways to get your BG data to your rig:

* Medtronic CGM users: you just upload your BG data with the other pump information to the rig.
* Dexcom CGM users:
  * G4/G5 -> Share Servers -> Nightscout -> rig
  * G4/G5 -> plug the receiver in to the rig with a second power source
  * xdrip+ -> Nightscout -> rig
  * xdrip+ -> xdripAPS -> rig

Depending on how you're getting BG to the rig, you'll need to do some basic troubleshooting.

## Second, troubleshoot the specific components of that setup

### Medtronic CGM users

* If you haven't been uploading CGM data for a while, or looping for a while, you may need to run `openaps first-upload` to get Nightscout to show CGM readings again.

### If you're using Nightscout:

* **Make sure your BGs are getting TO Nightscout**. If you're using something to upload, check the uploader. If you're using the Share bridge to Nightscout, the #1 reason BGs don't get to Nightscout is because of Share. Make sure a) that you are getting BGs from the receiver/transmitter to the Share app; then b) that the Share app is open (i.e. re-open the app after your phone is restarted); then c) make sure the *Dexcom follow* app is getting data. Checking all of those usually resolves data to Nightscout.
* To get data FROM Nightscout, the most common problem is if your rig is offline. If your rig is not connected to the internet, it can't pull BGs from Nightscout. Troubleshoot your internet connectivity (i.e. ping google.com and do what you need to do to get the rig online). After that, also make sure your NS URL and API secret are correct. If they're not, re-run the setup script with those things corrected.
  
### If you're using xdrip+ or xdripAPS
* **For Xdrip+ users** If you have no data in Nightscout - first check your uploader phone for data in xdrip+ - If you uploader phone has data then there is a likley problem getting data from the uploader phone to Night Scout - check wifi and/or cellular connectivity of the phone/device similarly to the section above outlining getting BGs to Nightscout.  Also, make sure your Xdripbridge-wixel has a charge - you should see a flashing red light on the wixel if it is searching to connect to the uploader device.
* If the Xdrip+ app on your uploader shows stale data (greater than 5 minutes since your last data point), go to 'System Status' to see the status of the connection between your xbridge-wixel and your uploader phone.  If you show 'connected', but you do not have data, you may wish to use the 'Restart Collector' button and see if your data restarts.  Be mindful that your CGM data is broadcast in 5 minute intervals - so you will see data appear on the '5's' if reconnect works.
* It is possible that 'Restart Collector' button will not work - in this case you will need to 'Forget Device' to reset the connection between the phone and your Xbridge-wixel setup.  Once forgetting the connection is done, you will need to go into the menu and select 'Bluetooth Scan' - you can now SCAN and select your Xbridge-wixel device. In some cases you will need a complete power-off of your wixel to successfully reset your system - this may require you to unplug your battery if you have not installed a power switch on your Xbridge-wixel device.  If you wish to do a hard reboot of your system, turn off/unplug your wixel.  Turn back on or replug, then rescan via 'Bluetooth Scan', select your Xbridge-wixel in blutooth selection window.  Once selected, your wixel name will disappear from the bluetooth scan options.  You may wish to do a double check of your system status to ensure you have a connection to your wixel device.
* Infrequently, in addition to the above, you may find your uploader phone needs a complete poweroff and restart as well to get you back up and running.
* Finally, increased frequency in difficulties with no data may indicate a troubled wire in your Xbridge-wixel - carefully double check all your soldered joints and ensure they continue to be good.

### If you're plugging a CGM into the rig

* Make sure you plug the CGM cable into the OTG port on the explorer board
* Make sure you have a SECOND power source (another battery, or wall power) plugged in also to the rig. 
