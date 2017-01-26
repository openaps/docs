# Offline monitoring

There are a number of ways to have an "offline" OpenAPS rig, and numerous ways to monitor offline.

## Offline looping

Medtronic CGM users can, by default, automatically loop offline because the rig will read CGM data directly from the pump.

Dexcom CGM or other CGM users will need alternative solutions, which range from plugging in a receiver into your rig (Pi, or Edison rig), or using xDrip to get BGs locally. See below for more details.

## Offline monitoring

* See Pancreabble instructions below for connecting your rig to your watch
* See xDrip instructions for seeing offline loop status (coming soon)

### Note about recovery from Camping Mode/Offline mode for Medtronic CGM users:

If you have been running offline for a significant amount of time, and use a Medtronic CGM, you may need to run

```
openaps first-upload
```
from inside your openAPS directory, before your loop will start updating correctly to your nightscout site.

### Pancreabble

_(TO DO Note - Pancreabble instructions for OpenAPS need to be re-worked to reflect the oref0-setup script way of making it work. Below is notes about Pancreabble setup prior to oref0-setup.sh being in existence.)_

[Pancreabble] is a way to monitor your loop _locally_, by pairing a Pebble smartwatch directly with the Raspberry Pi or Intel Edison.

In other words, whereas the default setup looks like this:

```
Raspberry Pi/Intel Edison -> network -> Nightscout server -> network -> smartphone
                                                                     |
                                                                     -> laptop
                                                                     |
                                                                     -> Pebble watch
```

And by default, your Pebble is paired thus:

```
               smartphone -> Bluetooth -> Pebble watch
```

With Pancreabble, the setup looks like this:

```
Raspberry Pi/Intel Edison -> Bluetooth -> Pebble watch
```

Using a Pebble watch can be especially helpful during the "open loop" phase: you can send the loop's recommendations directly to your wrist, making it easy to evaluate the decisions it would make in different contexts during the day (before/after eating, when active, etc.).

See [Pancreabble] for setup instructions.

[Pancreabble]: https://github.com/mddub/pancreabble
