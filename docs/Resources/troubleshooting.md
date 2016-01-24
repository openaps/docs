# Troubleshooting

Even those who follow this documentation precisely are bound to end up stuck at some point. This could be due to something unique to your system, a mistyped command, actions performed out of order, or even a typo in this guide. This section provides some tools to help diagnose the issue as well as some common errors that have been experienced and resolved before. If you get stuck, try re-reading the documentation again and after that, share what you've been working on, attempted steps to resolve, and other pertinent details in [#intend-to-bolus in Gitter](https://gitter.im/nightscout/intend-to-bolus) when asking for help troubleshooting.

### Generally useful linux commands

More comprehensive command line references can be found [here](http://www.computerworld.com/article/2598082/linux/linux-linux-command-line-cheat-sheet.html) and [here](http://www.pixelbeat.org/cmdline.html). For the below, since these are basic linux things, also try using a basic search engine (i.e. Google) to learn more about them and their intended use.

`$ ls -alt` (List all of the files in the current directory with additional details.)

`$ cd` (Change directory)

`$ pwd` (Show the present working directory (your current location within the filesystem).)

`$ sudo <command>`

`$ tail -f /var/log/syslog`

`$ df -h`

`$ ifconfig`

`$ cat <filename>` (Display the contents of the file.)

`$ nano <filename>` (Open and edit the file in the nano text editor.)

`$ stat <filename>`

`$ pip freeze`

`$ sudo reboot`

`$ sudo shutdown -h now` (The correct way to shut down the Raspberry Pi from the command line. Wait for the green light to stop blinking before removing the power supply.)

`$ dmesg` (Displays all the kernel output since boot. It’s pretty difficult to read, but sometimes you see things in there about the wifi getting disconnected and so forth.)

`uptime`

[add something for decocare raw logging]

### Dealing with the CareLink USB Stick

The `model` command is a quick way to verify whether you can communicate with the pump. Test this with `$ openaps use <my_pump_name> model`.

If you can't get a response, it may be a range issue. The range of the CareLink radio is not particularly good, and orientation matters; see [range testing report](https://gist.github.com/channemann/0ff376e350d94ccc9f00) for more information.

If you still can't get a response, trying unplugging and replugging the CareLink stick.

Once you're setting up your loop, you may also want to oref0-reset-usb if mm-stick warmup fails.

### Dealing with a corrupted git repository

Git corruption is a common and known problem (before people do [this](https://github.com/openaps/oref0/blob/master/bin/ns-uploader-setup.sh#L129) to help resolve it).
