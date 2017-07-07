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

### If you're plugging a CGM into the rig

* Make sure you plug the CGM cable into the OTG port on the explorer board
* Make sure you have a SECOND power source (another battery, or wall power) plugged in also to the rig. 
