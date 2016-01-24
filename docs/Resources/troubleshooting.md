# Troubleshooting

Even those who follow this documentation precisely are bound to end up stuck at some point. This could be due to something unique to your system, a mistyped command, actions performed out of order, or even a typo in this guide. This section provides some tools to help diagnose the issue as well as some common errors that have been experienced and resolved before.

## Useful linux commands

More comprehensive command line references can be found [here](http://www.computerworld.com/article/2598082/linux/linux-linux-command-line-cheat-sheet.html) and [here](http://www.pixelbeat.org/cmdline.html).

`$ ls -alt`

List all of the files in the current directory with additional details.

`$ cd`

`$ pwd`

Show the present working directory (your current location within the filesystem).

`$ sudo <command>`

`$ tail -f /var/log/syslog`

`$ df -h`

`$ ifconfig`

`$ cat <filename>`

Display the contents of the file.

`$ nano <filename>`

Open and edit the file in the nano text editor.

`$ stat <filename>`

`$ pip freeze`

`$ sudo reboot`

`$ sudo shutdown -h now`

The correct way to shut down the Raspberry Pi from the command line. Wait for the green light to stop blinking before removing the power supply.

`$ dmesg`

Displayss all the kernel output since boot. It’s pretty difficult to read, but sometimes you see things in there about the wifi getting disconnected and so forth.

`uptime`

[add something for decocare raw logging]

## CareLink USB Stick

The `model` command is a quick way to verify whether you can communicate with the pump. Test this with `$ openaps use <my_pump_name> model`.

If you can't get a response, it may be a range issue. The range of the CareLink radio is not particularly good, and orientation matters; see [range testing report](https://gist.github.com/channemann/0ff376e350d94ccc9f00) for more information.

If you still can't get a response, trying unplugging and replugging the CareLink stick.

There is also a tool, `oref0-reset-usb.sh` that reset USB connection, it can help in some cases of CareLink stick not responding. Just notice that during USB reset you will loose your Wi-Fi connection too.

## Git repository broken

OpenAPS uses git as the logging mechanism, so it commits report changes on each report invoke. Sometimes, due to "unexpected" power-offs, git repository gets broken. When it happens you will receive exceptions when running any report from openaps.
As git logging is a safety/security measure, there is no way of disabling these commits.
To fix git repository you can run `oref0-fix-git-corruption.sh` , it will try to fix the repository, and in case when repository is definitly broken it copies the remainings in a safe place (`tmp`) and initializes a new git repo.

## Environment variables

If you are getting your BG from Nightscoutr or you want to upload loop status/resuts to Nightscout, among other things you'll need to set 2 environment variabled: `NIGHTSCOUT_HOST` and `API_SECRET`. If you will not set and export these variables you will receive errors while running `openaps report invoke monitor/ns-glucose.json` and while executing `ns-upload.sh` script which is most probably part of your `upload-recent-treatments` alias.
Please also note tat `API_SECRET` should be in hashed format. Please see [this page](https://github.com/openaps/oref0#ns-upload-entries)
Your `NIGHTSCOUT_HOST` should be in a format like `http://yourname.herokuapp.com` (without trailing slash)
For complete visualization guide use [this](https://github.com/openaps/docs/blob/master/docs/Automate-system/vizualization.md) link.
