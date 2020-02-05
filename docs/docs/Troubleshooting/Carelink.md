# Dealing with the CareLink USB Stick

**Note:** Generally, the Carelink stick is no longer supported. We *highly* recommend moving forward with a different radio stick. See [the hardware currently recommended in the docs](<../Gear Up/rig-options>), or ask on Gitter. 

The `model` command is a quick way to verify whether you can communicate with the pump. Test this with `openaps use <my_pump_name> model` (after you do a `killall -g oref0-pump-loop`).

If you can't get a response, it may be a range issue. The range of the CareLink radio is not particularly good, and orientation matters; see [range testing report](https://gist.github.com/channemann/0ff376e350d94ccc9f00) for more information.

Sometimes the Carelink will get into an unresponsive state that it will not recover from without help. You can tell this has happened if the pump is within range of the Carelink and you see a repeating series of "Attempting to use a port that is not open" or "ACK is 0 bytes" errors in pump-loop.log. When this happens the Carelink can be recovered by rebooting or physically unplugging and replugging the CareLink stick.

Once you're setting up your loop, you may want to detect these errors and recover the Carelink programmatically. This can be done by running oref0-reset-usb (`oref0-reset-usb.sh`) to reset the USB connection. For example, you could create a cron job that would run `openaps use <my_pump_name> model`, or tail the 100 most recent lines in pump-loop.log, and grep the output looking for the errors noted above. If grep finds the errors, the cron job would run oref0-reset-usb. Just note that during USB reset you will lose the connection to all of your USB peripherals. This includes your Wi-Fi connection if your rig uses a USB Wi-Fi dongle.
