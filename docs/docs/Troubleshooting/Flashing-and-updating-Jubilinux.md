# Troubleshooting problems flashing your Edison, and updating Jubilinux

See also [the in-line troubleshooting steps](https://openaps.readthedocs.io/en/latest/docs/Resources/Edison-Flashing/all-computers-flash.html#troubleshooting)

For different reasons, users may come to need to re-flash, or build a new rig. These tips may also help first timers.

Here is a list of some things that can go wrong and how you can troubleshoot them.

* __Jubilinux won't flash over Jubilinux__ (for people trying to flash a rig that had Jubilinux / OpenAPS set up previously)
* __Jubilinux flashing fails constantly at rootfs, but gets further each time__
* __Other tips and tricks___

## Jubilinux won't flash over Jubilinux (for people trying to flash a rig that had Jubilinux / OpenAPS set up previously)

From a flashed and updated Jubilinux i.e. one that has been set up and used previously, you can't reflash with flashall. You must get the Intel flash tool and flash on one of the Intel OEM images, before attempting to clean flash Jubilinux. This is not a big deal for seasoned users. But the Intel flash app and files are becoming hard to find. I wasted days finding out how to progress past this step and sourcing the files.

## Jubilinux flashing fails constantly at rootfs, but gets further each time

This can mean you have a bad usb cable, or port connection at either end of the cable (computer or radioboard). See [Other tips and tricks](#Other-tips-and-tricks) below...

## Other tips and tricks
* If you are struggling to maintain a serial connection, don't reboot the board if you can help it, by pulling out the USB. Apart from unessisarily wearing out the port, you have to throw caution to the wind about whether you'll get back on. Instead, gently long-press the tiny black power button on the board until the light between the USB ports turns off. Wait a few seconds, then press it again to boot your Edison. The serial connection will remain up right through the reboot.
* Unplug your rig battery if you have one connected. Some users' rigs heat up when charging a battery at higher rates through the OTG USB port (closest to the JST battery port, where the charging circuitry is). This can cause unexpected reboots during flashing, or at any time.
* USB cables and ports - This is much more important than you think. Poor USB connections can cause issue getting a serial connection over the UART port, or flashing over the OTG port. What might work one time, might not work again. Work through these steps...
** For troubleshooting serial connections...
*** If you can't get a serial connection, it may be beneficial to forget your second flashing (OTG) USB port for the time being. Especially if you are not sure both your USB cables are good quality data cables. For now, focus on getting a serial connection with a single cable.
*** Take your best data USB micro cable
*** If possible, make sure you are on a good USB2 port (USB3 are often blue on the inside). USB ports on the front of desktop PCs are notoriously bad.
*** Make sure you are connected to UART on your radio board.

* Which Jubilinux? Check Linux Version Using lsb_release Command (from within Linux) `lsb_release -a` (e.g. Debian 9.13 = jubilinux-v9+0.4.1, Debin 9.12 = jubilinux-v0.3.0)

