# Offline monitoring

There are a number of ways to have an "offline" OpenAPS rig, and numerous ways to monitor offline.

## Offline looping

Medtronic CGM users can, by default, automatically loop offline because the rig will read CGM data directly from the pump.

Dexcom CGM or other CGM users will need alternative solutions, which range from plugging in a receiver into your rig (Pi, or Edison rig), or using xDrip to get BGs locally. See below for more details.

## Offline monitoring

* See [Pancreabble] for connecting your rig to your watch
* See xDrip instructions for seeing offline loop status (coming soon)

### Note about recovery from Camping Mode/Offline mode for Medtronic CGM users

If you have been running offline for a significant amount of time, and use a Medtronic CGM, you may need to run

```
openaps first-upload
```
from inside your openAPS directory, before your loop will start updating correctly to your nightscout site.

