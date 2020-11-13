# Troubleshooting problems flashing your Edison, and updating Jubilinux

See also [the in-line troubleshooting steps](https://openaps.readthedocs.io/en/latest/docs/Resources/Edison-Flashing/all-computers-flash.html#troubleshooting)

For different reasons, users come to need to reflash from time to time, or build an install on hardware that may have been acquired second hand from another user.  With both Jubilinux, Edison Intel Tools, and OpenAPS getting less and less updates we are starting to see more and more issues cropping up getting a clean install. These tips may also help first timers.

Important: Try to have two rigs, and only attempt to reflash and reinstall one if you have another working rig nearby looping. Give yourself time. If problems occur it can take hours (or days, especially if you are relying on community members advice online in different time zones!). So start early on a day you have some free time up your sleeve.

Here is a list of some things that can go wrong and how you can troubleshoot them.

* __Jubilinux won't flash over Jubilinux__ (for people trying to flash a rig that had Jubilinux / OpenAPS set up previously)
* __Jubilinux flashing fails constantly at rootfs, but gets further each time__
* __Other tips and tricks__

## Jubilinux won't flash over Jubilinux (for people trying to flash a rig that had Jubilinux / OpenAPS set up previously)

From a flashed and updated Jubilinux i.e. one that has been set up and used previously, you can't reflash with flashall. You must get the official Intel flash tool and flash  one of the Intel OEM images, before attempting to clean flash Jubilinux. This is not a big deal for experienced users. But the Intel flash app, and firmware files are becoming increasingly hard to find<!--(to do, link to files)-->. This can be a big source of frustration with users taking days to even get in the right state to commence flashing and running install.

Thankfully there is a simple way around this...

Go to the u-boot console. This is what you get after hitting enter a few times as the Edison boots while connected to serial e.g. "Press any key to load app", or something to that effect.

With a terminal emulator (Putty or Mac OS Terminal) connected to the Edison serial port, hit return immediately after startup. Once in the u-boot console,  use the command:

Warning: this will zapp any previous Jubilinux install, including your old OpenAPS install, and any files or config on your old Edison OS, ready to reflash your Edison. Be sure you don't need anything off your rig first.

`gpt write mmc 0 $partitions`

Then you can run flashall via the OTG port normally without Intel tools.

## Jubilinux flashing fails constantly at rootfs, but gets further each time

This can mean you have a bad usb cable, or port connection at either end of the cable (computer or radioboard OTG). See [Other tips and tricks](#Other-tips-and-tricks) below...

## Other tips and tricks
* **Red light / Green light** - Some radio boards seem to have red power LEDs (between the USB ports). Others have green. Users used to having one and not the other sometimes get concerned with the difference when they acquire new hardware. See also [what rig lights mean](https://openaps.readthedocs.io/en/latest/docs/While%20You%20Wait%20For%20Gear/understanding-your-Explorer-Board-rig.html?highlight=lights#what-the-lights-mean-and-where-they-are).
* **Soft reboot the board** - If you are struggling to maintain a serial connection, don't reboot the board by pulling out the USB, if you can help it. Apart from unnecessarily wearing out the port, you have to throw caution to the wind about whether you'll get back on. Instead, gently long-press the tiny black power button on the board until the light between the USB ports turns off. Wait a few seconds, then press it again to boot your Edison. The serial connection will remain up right through the reboot.
* **Battery charging and heat** - Unplug your rig battery if you have one connected. Some users' rigs heat up when charging a battery at higher rates through the OTG USB port (closest to the JST battery connector, where the charging circuitry is). This can cause unexpected reboots during flashing, or at any time.
* **USB cables and ports** - This is much more important than you think. Poor USB connections can cause issue getting a serial connection over the UART port, or flashing over the OTG port. What might work one time, might not work again. Work through these steps.
  * **General** - If you are having headaches getting a serial connection or successful flash on the OTG port. Try using ONE known good data USB. USB connections are the source of many issues. Some cables only carry power, some are internally faulty because the wires are very thin and fatigued. While it may charge, it may not carry data reliably. At a high level, start by preparing the Edison with a serial connection, then moving the USB to the OTG port for flashing, then back to serial to log in and set things up. NOTE: make sure to wait five minutes after flashing hits 100%, because the first time Linux boots quite a lot happens, and you won't see this not having an active serial connection. See below for more detail.
  * **For troubleshooting serial connections**
    * If you can't get a serial connection, it may be beneficial to forget your second flashing (OTG) USB port for the time being. Especially if you are not sure both your USB cables are good quality data cables. For now, focus on getting a serial connection with a single cable.
    * Take your best data USB micro cable - Label cables that have worked before so you can access them again in a hurry.
    * If possible, make sure you are on a good USB2 port (USB3 are often blue on the inside). USB ports on the front of desktop PCs are notoriously bad.
    * Make sure you are connected to UART on your radio board. Simple mistake to make. Only the UART USB will accept serial connections
    * If you're on Windows, check you're using the right COMM port number in Putty (per device manager)
    * Swap USB ports on your computer
    * Restart your computer. Oddly enough, this can apparently free up stuck system resources. Particularly on Mac's, multiple attempts at a serial connection, even after successful ones, seem to lock you out of getting subsequent successful ones.
    * Restart your board with the power button (see above)
    * Hit enter a few times. This can wake the connection sometimes.
  * **For troubleshooting OTG port connections (for flashing, running flashall)**
    * Click in the terminal/CMD window, hit enter, after executing the flashall command. Sometimes the command doesn't fire if it doesn't immediately find the board. This is especially common if you are rebooting or replugging things.

<!-- To Do: For  aditional troubleshooting steps installing OpenAPS via Bootstrap, Runagain or Setup click here -->

<!--To Do: Which Jubilinux? Check Linux Version Using lsb_release Command (from within Linux) `lsb_release -a` (e.g. Debian 9.13 = jubilinux-v9+0.4.1, Debin 9.12 = jubilinux-v0.3.0)-->
