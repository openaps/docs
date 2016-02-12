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

Once you're setting up your loop, you may also want to oref0-reset-usb (`oref0-reset-usb.sh`) if mm-stick warmup fails, to reset the USB connection. It can help in some cases of CareLink stick not responding. Just note that during USB reset you will loose your Wi-Fi connection as well.

### Dealing with a corrupted git repository

OpenAPS uses git as the logging mechanism, so it commits report changes on each report invoke. Sometimes, due to "unexpected" power-offs (battery dying, unplugging, etc.),the git repository gets broken. When it happens you will receive exceptions when running any report from openaps. As git logging is a safety/security measure, there is no way of disabling these commits.

To fix a corrupted git repository you can run `oref0-fix-git-corruption.sh`, it will try to fix the repository, and in case when repository is definitly broken it copies the remainings in a safe place (`tmp`) and initializes a new git repo.

### Environment variables

If you are getting your BG from Nightscout or you want to upload loop status/resuts to Nightscout, among other things you'll need to set 2 environment variabled: `NIGHTSCOUT_HOST` and `API_SECRET`. If you do not set and export these variables you will receive errors while running `openaps report invoke monitor/ns-glucose.json` and while executing `ns-upload.sh` script which is most probably part of your `upload-recent-treatments` alias.Make sure your `API_SECRET` is in hashed format. Please see [this page](https://github.com/openaps/oref0#ns-upload-entries) for details. Additionally, your `NIGHTSCOUT_HOST` should be in a format like `http://yourname.herokuapp.com` (without trailing slash). For the complete visualization guide use [this page](https://github.com/openaps/docs/blob/master/docs/Automate-system/vizualization.md) from the OopenAPS documentation.

### Common errors found while running openaps commands

#### Don't have permission, permission not allowed, etc

The command you are running likely needs to be run with root permissions, try the same command again with ```sudo ``` in front of it

#### json: error: input is not JSON
```
json: error: input is not JSON: Unexpected '<' at line 1, column 1:
        <head><title>Document Moved</title></head>
```
        
  This error usually comes up when you have pulled a file down from Nightscount that was an invalid file. Typcially you might see this when trying to pull down treatments. Make sure that you have your HOST and API_KEY set correctly at the top of your cron, in your ~/.profile and finally
  
  

