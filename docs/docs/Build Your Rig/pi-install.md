# Setting up a Raspberry Pi rig

### Download Raspbian and write it to your microSD card ###

Following the instructions at https://www.raspberrypi.org/documentation/installation/installing-images/README.md, download Raspbian Lite (you do *not* want Raspbian Desktop) and write it to an microSD card using Etcher.

### Place your wifi and ssh configs on the new microSD card ###

Once Etcher has finished writing the image to the microSD card, remove the microSD card from your computer and plug it right back in, so the boot partition shows up in Finder / Explorer.

Create a file named wpa_supplicant.conf on the boot drive, with your wifi network(s) configured.  It should look something like:

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
network={
  ssid="MyWirelessNetwork"
  psk="MyWirelessPassword"
}
```

Also create an empty file named `ssh` (with no file extention) to enable SSH login to the Pi.

### Boot up your Pi and connect to it ###

Eject the microSD card from your computer, insert it into your Pi, and plug in power to the Pi to turn it on.  Give it a couple minutes to boot up.  Once the green LED stops blinking as much, you can try to log in.

On Mac, open Terminal and `ssh pi@raspberrypi.local`

On Windows, use PuTTY for an ssh connection. Username on all new Pi's is `pi`. The username used by everyone after this step is `root` because you have to be the super user, the user with full priviledges. To connect as `pi` use the same hostname for all new Pi's, `raspberrypi.local`. This could also be input into PuTTY as pi@raspberrypi.local. The password for logging in as `pi` is `raspberry`.

### Run openaps-install.sh ###

Once you're logged in, run the following command to start the OpenAPS install process:

`curl -s https://raw.githubusercontent.com/openaps/oref0/dev/bin/openaps-install.sh > /tmp/openaps-install.sh && sudo bash /tmp/openaps-install.sh`

You'll be prompted to set a password.  You'll want to change it to something personal so your device is secure. Make sure to write down/remember your password; this is what you'll use to log in to your rig moving forward. You'll type it twice.  There is no recovery of this password if you forget it.  You will have to start over from the top of this page if you forget your password.

* Change your hostname (a.k.a, your rig's name). **Make sure to write down your hostname; this is how you will log in in the future as `ssh root@whatyounamedit.local`**

* Pick your time zone (e.g., In the US, you'd select `US` and then scroll and find your time zone, such as `Pacific New` if you're in California).

The script will then continue to run awhile longer (~10+ minutes) before asking you to press `enter` to run oref0-setup.

Return to the [OpenAPS Install page](OpenAPS-install.md) to complete oref0-setup.
