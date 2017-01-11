# Configuring and Learning to Use openaps Tools

This section provides an introduction to initializing, configuring, and using the OpenAPS toolset. The purpose is to get you familiar with how the different commands work and to get you thinking about how they may be used to build your own closed loop. Make sure you have completed the [Setting Up the Raspberry Pi 2](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-0/rpi.html) and [have installed openaps via step 0 of the setup script process](http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-2/oref0-setup.html) sections prior to starting.

If you haven't already, now that you have a working Raspberry Pi or similar system, it would be a good time to go through the [Guide to understanding the openaps toolkit](../../openaps-guide/index), which will give you a much better understanding of how the openaps tools work so you know what's happening as you follow the rest of this setup walkthrough, and know how to use the tools to investigate when something doesn't behave quite like you expect.

The [openaps readme](https://github.com/openaps/openaps/blob/master/README.md) also has detailed information on the installation and usage of OpenAPS. You should take the time to read through it in detail, even if it seems confusing at first. There are also a number of example uses available in the [openaps-example](https://github.com/bewest/openaps-example) repository.

Some familiarity with using the terminal will go a long way, so if you aren't
comfortable with what `cd` and `ls` do, take a look at some of the Linux Shell
/ Terminal links on the [Technical
Resources](../../Resources/technical-resources.md) page.

Some conventions used in this guide:
* Wherever there are `<bracketed_components>` in the the code, these are meant
  for you to insert your own information. Most of the time, it doesn't matter
  what you choose **as long as you stay consistent throughout this guide**.
  That means if you choose `Barney` as your  ` < my_pump_name > `, you must use
  `Barney` every time you see `< my_pump_name >`. Choose carefully. Do not
  include the ` < > ` brackets in your name.


``` eval_rst
.. note::
    One helpful thing to do before starting is to log your terminal session. This
    will allow you to go back and see what you did at a later date. This will also
    be immensely helpful if you request help from other OpenAPS contributors as you
    will be able to provide an entire history of the commands you used. To enable
    this, just run `script <filename>` at the beginning of your session. It will
    inform you that `Script started, file is <filename>`. When you are done, simply
    `exit` and it will announce `Script done, file is <filename>`. At that point,
    you can review the file as necessary.
```

<br>
## Configuring OpenAPS

### Initialize a new openaps environment

To get started, SSH into your Raspberry Pi. Go to your home directory:

`cd`

Create a new instance of openaps in a new directory:

`openaps init <my_openaps>`

As mentioned above, `<my_openaps>` can be anything you'd like: `myopenaps`, `awesome-openaps`, `openaps4ever`, `bob`, etc.

Now that it has been created, move into the new openaps directory:

`cd <my_openaps>`

All subsequent openaps commands must be run in this directory. If you try to run an openaps command in a different directory, you will receive an error:

`Not an openaps environment, run: openaps init`

The directory you just created and initialized as an openaps environment is mostly empty at the moment, as can been seen by running the list files command:

```
$ ls
openaps.ini
```
That `openaps.ini` file is the configuration file for this particular instance of openaps. It will contain all of your device information, plugin information, reports, and aliases. In the subsequent sections, you will be configuring your openaps instance to add these components. For now, however, it is blank. Go ahead and take a look:

`cat openaps.ini`

Didn't return much, did it? By the way, that `cat` command will be very useful as you go through these configuration steps to quickly check the contents of files (any files, not just `openaps.ini`). Similarly, if you see a command that you are unfamiliar with, such as `cat` or `cd`, Google it to understand what it does. The same goes for error messages—you are likely not the first one to encounter whatever error is holding you back.

### Add openaps-contrib
This provides us with timezone support:

```
openaps vendor add openapscontrib.timezones
openaps device add tz timezones
```

## Get Pump data
### Add pump as device

`openaps device add <my_pump_name> medtronic`

In order to communicate with the pump and cgm receiver, they must first be
added as devices to the openaps configuration. To do this for a device we'll
call `pump`:

(Depending on just how you are set up to communicate with the pump (for example, Medtronic CareLink stick vs TI Stick with MMeowLink, etc) you might need to take some additional steps here.  The instructions below assume you are using a Carelink.  If you want to use MMeowLink, and assuming you already have that software installed, you will need to:

`openaps vendor add --path . mmeowlink.vendors.mmeowlink`

to set up the MMeowLink code, and:

`openaps device add pump mmeowlink subg_rfspy /dev/ttyACM0 123456`

(instead of

`openaps device add pump medtronic`

and

`openaps use pump config --serial <my_serial_number>`

(for example):
`openaps use pump config --serial 123456`

below to add the pump device.)  Note also that the path, /dev/ttyACM0, may vary from one system to another.)

`openaps device add pump medtronic`

Then to configure the new `pump` device with its serial number:

`openaps use pump config --serial 123456`

Create bunch of reports:

`oref0 template mint reports medtronic-pump | openaps import`

(Yes, use `medtronic-pump` even if you are communicating with the pump another way.)

Here, `<my_pump_name>` can be whatever you like, but `<my_serial_number>` must
be the 6-digit serial number of your pump. You can find this either on the back
of the pump or near the bottom of the pump's status screen, accessed by hitting
the ESC key.

**Important:** Be careful when choosing to share your 6-digit pump serial
number or posting it online. If someone had access to this number, and was in
radio reach of your pump, this could be used to communicate with your pump
without your knowledge. While this is a feature when you want to build an
OpenAPS, it is a flaw and a security issue if someone else can do this to you.

## Get CGM Data
### From Dexcom CGM receiver via usb cable

Now you will do this for the Dexcom CGM receiver using a usb cable:

`openaps device add cgm dexcom`

Note this step is not required if you are using a Medtronic CGM. The pump
serves as the receiver and all of the pumping and glucose functionality are
contained in the same openaps device.

### G5 support
Support for G5 receiver is offered through the usb cable and configuring the
`cgm` device with: `openaps use cgm config --G5`.

### G4 with Share
**Note** the instructions below do not work for some users, please see the
GitHub [issue](https://github.com/openaps/openxshareble/issues/5) for details.
Affected users can still obtain glucose data via usb cable.

Install BLE helpers:
```
sudo pip install git+git://github.com/bewest/Adafruit_Python_BluefruitLE.git@wip/bewest/custom-gatt-profile
sudo pip install git+git://github.com/bewest/openxshareble.git
# adds openxshareble as vendor
openaps vendor add openxshareble
```

Then set up cgm device this way:
```
openaps device add cgm openxshareble
```

### Glucose Data
Test ability to get data.

(It would be good to explain here (or link to) how to use G4 / G4 Share -> Nightscout to get cgm data.)

```
openaps use cgm oref0_glucose  --hours 2.0
```

### for G5 consider this instead:
```
openaps use cgm oref0_glucose  --no-raw --hours 2.0
```
(Note this step is not required if you are using a Medtronic CGM. The pump serves as the receiver and all of the pumping and glucose functionality are contained in the same openaps device.)

For all Dexcom CGM systems:

Add as report:
```
openaps report add raw-cgm/glucose-raw.json JSON cgm oref0_glucose  --hours 2.0
```

### For G5:
```
openaps report add raw-cgm/glucose-raw.json JSON cgm oref0_glucose  --no-raw --hours 2.0
```

For a Dexcom G5 system, you need to configure openaps specifically for the G5:

```
openaps use <my_dexcom_name> config --G5
```

NB: The above command can also be used to change from a G4 to G5 system in an already functioning loop. If that doesn't work, update openaps.

Invoke the report and ensure that the data is zoned correctly:
```
openaps report invoke raw-cgm/glucose-raw.json
openaps use tz rezone  --date dateString --date display_time raw-cgm/glucose-raw.json
openaps report add monitor/glucose.json JSON  tz rezone  --date dateString --date display_time raw-cgm/glucose-raw.json
```

Save an alias to fetch CGM data:
```
openaps alias add monitor-cgm "report invoke raw-cgm/glucose-raw.json monitor/glucose.json"
```

Now, `openaps monitor-cgm` is available to pull in fresh CGM data from Dexcom.

## Check that the devices are all added properly

`openaps device show`

should return something like:

```
timezones://tz
medtronic://pump
dexcom://cgm
```

Here, `pump` was used for `<my_pump_name>` and `cgm` was used for
`<my_dexcom_name>`. The names you selected should appear in their place.

Your `openaps.ini` file now has some content; go ahead and take another look:

`cat openaps.ini`

Now, both of your devices are in this configuration file:

```
[device "pump"]
vendor = openaps.vendors.medtronic
extra = pump.ini

[device "cgm"]
vendor = openaps.vendors.dexcom
extra = cgm.ini
```

Again, `pump` was used for `<my_pump_name>` and `cgm` was used for `<my_dexcom_name>`. Your pump model should also match your pump.

Because your pump's serial number also serves as its security key, that
information is now stored in a separate ini file (here noted as `pump.ini`)
that was created when you created the pump device. This makes it easier for
sharing the `openaps.ini` file and also for keeping `pump.ini` and `cgms.ini`
more secure. Be careful with these files. Open the pump's ini file now (use the
name reported to you in the line labeled `extra` in the `openaps.ini` file).

`cat pump.ini`

It should show something like this:

```
[device "pump"]
serial = 123456
```

The serial number should match that of your pump.

If you made a mistake while adding your devices or simply don't like the name
you used, you can go back and remove the devices as well. For example, to
remove the pump:

`openaps device remove <my_pump_name>`

Then, you can add your pump again with a different name or serial number.

### Check that you can communicate with your pump

Now that you have added these devices, let's see if we can establish communication with them. First, the pump:

`openaps use <my_pump_name> model`

should return something like:

`"723"`

Congratulations, you just pulled data from your pump! The `model` command is a very useful one to verify whether you can communicate with the pump. It is not, however, the only thing you can do. Take a look at the help file to see all of the possibilities:

`openaps use <my_pump_name> -h`

This returns a healthy bit of useful information, including a list of all the commands that can be done with `openaps use <my_pump_name>`. Of course, each one of those uses has its own help file as well:

```
$ openaps use <my_pump_name> model -h
usage: openaps-use pump model [-h]

 Get model number


optional arguments:
  -h, --help  show this help message and exit
```

The `-h` argument is your friend. If you ever forget what a command does, what arguments it requires, or what options it has, `-h` should be your first resource.

Go ahead and try some more pump uses to find out what they do. Note that some of the commands require additional inputs; these are detailed in the specific help files.

### Check that you can communicate with your Dexcom receiver

Now let's try communicating with the Dexcom receiver.

Hint: Your Dexcom should be nearly fully charged before plugging it in to your Raspberry Pi. If, when you plug in your Dexcom, it causes your WiFi dongle to stop blinking, or if the charging icon on the Dexcom keeps cycling on and off, that is a sign that it is drawing too much power and needs to be charged.

> Workaround: If you continue to have problems, try increasing the mA output to the USB ports, you can do this by running the following command `sudo bash -c "echo -e \"#Enable Max USB power\nmax_usb_current=1\" >> /boot/config.txt"`.

> Reboot via `sudo shutdown -r now` to pick up the changes.

`openaps use <my_dexcom_name> iter_glucose 1`

should return something like:

```
[
  {
    "trend_arrow": "FLAT",
    "system_time": "2015-08-23T21:45:29",
    "display_time": "2015-08-23T13:46:21",
    "glucose": 137
  }
]
```
Hint: if this doesn't work, check to make sure that your Dexcom receiver is plugged into your Raspberry Pi ;-)

Just like with the pump, you can use the `-h` argument to call the help files. For example:

```
$ openaps use <my_dexcom_name> iter_glucose -h
usage: openaps-use cgms iter_glucose [-h] [count]

 read last <count> glucose records, default 100, eg:

positional arguments:
  count       Number of glucose records to read.

optional arguments:
  -h, --help  show this help message and exit

* iter_glucose   - read last 100 records
* iter_glucose 2 - read last 2 records
```

### Pulling blood glucose levels from Nightscout

Some people have found it more beneficial to pull blood glucose values from
Nightscout rather than directly from the Dexcom receiver.

Many people will actually setup both ways to pull the blood glucose level and
switch between the different devices depending on their needs.  If you are
going to pull it directly from Nightscout then you will have to have internet
access for the Raspberry Pi.

The `autoconfigure-device-crud` feature will allow us to create an easy to use `ns` device:

```
$ nightscout autoconfigure-device-crud https://my.nightscout.host averylongplainsecret
added process://ns/nightscout/ns NIGHTSCOUT_HOST API_SECRET
process://ns/nightscout/ns https://my.nightscout.host e6fc892e8e88235a476d197de3dfbef3f2db53d0

```
It added a new `ns` device to our uses menu:
```
openaps use ns shell get entries.json 'count=10'
openaps use ns shell upload treatments.json recently/combined-treatments.json
```

[INSERT ACTUAL INSTRUCTIONS ON HOW TO CREATE a treatments.json report before ns shell `upload`]

So we now have various uses for `ns`:

**get**, **upload**,
**latest-treatment-time**, **format-recent-history-treatments**,
**upload-non-empty-treatments**.

#### nightscout tools in openaps

    openaps use ns shell get entries.json 'count=10'
    openaps use ns shell upload treatments.json recently/combined-treatments.json
```
  -h                                  This message.
  get type args                                  Get records of type from
                                                 Nightscout matching args.

  upload endpoint file                           Upload a file to the Nightscout endpoint.
  latest-treatment-time                          - get latest treatment time from Nightscout
  format-recent-history-treatments history model - Formats medtronic pump
                                                 history and model into
                                                 Nightscout compatible
                                                 treatments.

  format-recent-type ZONE type file              - Selects elements from the
                                                 file where the elements would
                                                 satisfy a gap in the last 1000
                                                 Nightscout records.

  upload-non-empty-treatments file               - Upload a non empty treatments
                                                 file to Nightscout.
  lsgaps tz entries                              - Re-use openaps timezone device
                                                 to find gaps in a type (entries)
                                                 by default.
  upload-non-empty-type type file
  status                                         - Retrieve status
  preflight                                      - NS preflight
```
## Nightscout Endpoints

* `entries.json` - Glucose values, mbgs, sensor data.
* `treatments.json` - Pump history, bolus, treatments, temp basals.
* `devicestatus.json` - Battery levels, reservoir.
* `profile.json` - Planned rates/settings/ratios/sensitivities.
* `status.json` - Server status.

## Examples

### Get records from Nightscout

Use the get feature which takes two arguments: the name of the endpoint
(entries, devicestatus, treatments, profiles) and any query arguments to append
to the argument string. 'count=10' is a reasonable debugging value.
The query-params can be used to generate any query Nightscout can respond to.

    openaps use ns shell get $endpoint $query-params

### Unifying pump treatments in Nightscout

To upload treatments data to Nightscout, prepare your zoned glucose, and pump
model reports, and use the following two reports:

    openaps report add nightscout/recent-treatments.json JSON ns shell  format-recent-history-treatments monitor/pump-history.json model.json
    openaps report add nightscout/uploaded.json JSON  ns shell upload-non-empty-treatments  nightscout/recent-treatments.json

Here are the equivalent uses:

    openaps use ns shell format-recent-history-treatments monitor/pump-history.json model.json
    openaps use ns shell upload-non-empty-treatments nightscout/recent-treatments.json

The first report runs the format-recent-history-treatments use, which fetches
data from Nightscout and determines which of the latest deltas from openaps
need to be sent. The second one uses the upload-non-empty-treatments use to
upload treatments to Nightscout, if there is any data to upload.

The first of the above reports and uses rely upon the existence of a model report:

    openaps report add settings/model.json JSON pump model
    openaps report invoke settings/model.json

(what report needs to be defined and invoked in order to have monitor/pump-history.json defined?)

### Uploading glucose values to Nightscout

Format potential entries (glucose values) for Nightscout.

    openaps use ns shell format-recent-type tz entries monitor/glucose.json  | json -a dateString | wc -l
    # Add it as a report
    openaps report add nightscout/recent-missing-entries.json JSON ns shell format-recent-type tz entries monitor/glucose.json
    # fetch data for first time
    openaps report invoke nightscout/recent-missing-entries.json

    # add report for uploading to NS
    openaps report add nightscout/uploaded-entries.json JSON ns shell upload entries.json nightscout/recent-missing-entries.json
    # upload for fist time.
    openaps report invoke nightscout/uploaded-entries.json

If you are pulling blood glucose levels from Nightscout instead of a receiver, you will not need nightscout/recent-missing-entries.json and nightscout/uploaded-entries.json.  They may be removed from the report-nightscout alias.  

<br>
## Adding and Invoking Reports

At this point, you should be comfortable communicating with your pump and cgm receiver with the `openaps use` command. This is great for learning and for experimenting, but it lacks the ability to generate output files. You'll notice that running

`openaps use <my_dexcom_name> iter_glucose 100`

prints *a lot* of data to the terminal. It would be great to save that data somewhere so that it can be used for logging historical records, performing calculations, and verifying actions. That is what `report` does.

Generating reports involves two steps: adding the report structures to your openaps configuration and invoking the reports to produce the desired outcome.

### Adding Reports

As an example, let's suppose you would like to gather the last four hours of records from your pump. With the `use` command, that would be:

`openaps use <my_pump_name> iter_pump_hours 4`

This dumps the past four hours of pump records directly to the terminal.

Now, let's add this as a report instead:

`openaps report add last_four_pump_hours.json JSON <my_pump_name> iter_pump_hours 4`

If done correctly, the only thing returned in the terminal is:

`added pump://JSON/iter_pump_hours/last_four_pump_hours.json`

Let's take a closer look at each section. `openaps report add` is adding a report to your openaps configuration. The report name is `last_four_pump_hours.json`. The format of the report is `JSON`. The command that will be used to generate the report is `<my_pump_name> iter_pump_hours 4`. You will notice that this last section is identical to what was called above when you printed the output to the terminal window, except there it was done with the `use` command. The report is simply running that same command and writing the output to the file you specified in the format you specified.

Much like adding devices, this report configuration is saved to your `openaps.ini` file. You can view all of your reports there with `cat openaps.ini` or by using `openaps report show`. Similarly, you can remove reports with `openaps report remove <report_name>`.

### Invoking Reports

Adding the report does not actually generate the output file. To do this, you need to invoke the report:

`openaps report invoke last_four_pump_hours.json`

Again, the terminal output will be minimal:

```
pump://JSON/iter_pump_hours/last_four_pump_hours.json
reporting last_four_pump_hours.json
```

This time, however, a new file was created. Check and see using `ls`; you should see a file called `last_four_pump_hours.json` in your directory. Take a look at the file with `cat last_four_pump_hours.json`. The file's contents should look very familiar—the same data that was printed to the terminal window when you performed `openaps use <my_pump_name> iter_pump_hours 4`.

Each time you add a new report to your configuration, you should immediately invoke it and check the resulting file. This means **open the file and actually check to make sure the output is what you expect**. Don't assume that it worked just because you didn't see an error.

The reports you add are reusable—each time you would like new data, simply invoke the report again and it will overwrite the output file. If you would like to see when the file was last edited, use the command `ls -l`. This will help you make sure you are getting up-to-data data.

Go ahead and create (and check) some reports for the the commands you have been using the most.

<br>
## Aliases

Now that you have some reports added, you may notice that you end up calling some of them in combinations. For example, you might always want to get your updated pump records and your updated cgm records. To do that, you would normally run two commands each time:

```
$ openaps report invoke last_four_pump_hours.json
$ openaps report invoke last_four_cgm_hours.json
```

For this example, we assume that you have added a second report called `last_four_cgm_hours.json` that is similar to the `last_four_pump_hours.json` we walked through previously, except that it is using your `<my_dexcom_name>` device and the `iter_glucose_hours` command. Go ahead and do that so you can follow along.

Calling two sequential commands for each update is a bit annoying, but imagine calling five or ten. Luckily, openaps has a built-in way to group these commands: aliases. Aliases allow generation of single-word commands to invoke a series of reports. For this example, create an alias called `last_four_hours`:

`openaps alias add last_four_hours "report invoke last_four_pump_hours.json last_four_cgm_hours.json"`

Go ahead and execute this command:

`openaps last_four_hours`

You will see that it invokes each of the reports you specified in the order you specified. It prints each step out to the terminal window, and you will find that the corresponding output files have been created.

Just like with devices and reports, the alias is now part of your openaps configuration. You can view all of your aliases with `cat openaps.ini` or by using `openaps alias show`. Similarly, you can remove aliases with `openaps alias remove <alias_name>`.

Aliases will invoke reports and execute logic and shell commands. Aliases are not limited to reports. They can be nested. For example a top level alias is $ openaps alias1 alias2.  alias2 is for example: Run shell "program1 && something2 || alias3" (one and two or three). alias3 is for example: $ Openaps report invoke settings/settings.json settings/bg_targets.json settings/insulin_sensitivities.json settings/basal_profile.json settings/profile.json

## Putting the Pieces Together

Take a moment to consider putting these commands to work in the larger context of a closed-loop system. Components of that system that you might need to `add` and `invoke` would be recent glucose data, recent pump history, the time, battery status, pump settings, carb ratios, the current basal profile, insulin sensitivities, blood glucose targets, and the status of the pump.

Go ahead and add and invoke reports for these components of a future closed-loop system.

Are there groupings of these reports that you imagine would be called at the same time? For example, in a closed-loop setup, the pump settings, blood glucose targets, insulin sensitivities, the basal profile, and carb ratios would not need to be checked as often as the current pump status, battery status, clock, recent blood sugars, and recent pump history.

Take some time to create aliases for groups of reports that would be called at the same time and verify that they invoke the expected reports. Reports will execute the "use" command. The "use" command is -h annotated. To see the annotation use this command $ openaps use <pumpname> -h


<br>
## Backing Up Your openaps Instance

There are numerous ways to back up your system, from making a copy of the entire SD card to copying over individual files. Here, we will discuss one method of using git to back up just the openaps instance you've created. Note that this will not back up the entire system (and all the work you did in [Setting Up the Raspberry Pi 2](../phase-0/rpi.md) and [Setting Up openaps](../phase-0/openaps.md)), but it will enable you to skip all of the configuration steps above if something happens.

For this backup method, we will take advantage of the fact that your openaps
instance is a git repository. We won't go over git here, but take a look at
the references on the [Resources](../../Resources/technical-resources.md) page to
get familiar with the basics. Typically, we would do this backup using GitHub,
since that is where most of the openaps repositories are located and you should
already have an account. However, GitHub only provides free repositories if
they are public, and since this repository has your `<my_pump_name>.ini`
file—and thus your pump's serial number—in it, we want to make sure that is
private. If you are comfortable with sharing your glucose and pump history
publicly, you can make sure the secret .ini files remain so by creating a
.gitignore file listing `<my_pump_name>.ini` (and any other .ini files with
secret information).  This will prevent git from uploading those files to
GitHub, but will still allow you to backup and publicly share all your other
configuration and data.

If you wish to use a private GitHub repository, you can
[purchase a monthly plan](https://github.com/pricing) and then follow
[these instructions](https://help.github.com/articles/adding-an-existing-project-to-github-using-the-command-line/),
or use a service like Bitbucket instead.

[Bitbucket](https://bitbucket.org/) offers a similar service to GitHub, but
permits users to create free private repositories. Go ahead and sign up and
then create a repository. You can call it whatever you like, but make sure that
on the "Create a new repository" setup page you leave the "This is a private
repository" box checked. Once created, you will be directed to a "Repository
setup" page. Under the "Command line" section, click on the "I have an existing
project" option and follow the instructions.

Once you have completed this step, all of the files in your `<my_openaps>`
directory will be saved in your online Bitbucket repository. Whenever you would
like to update your backup, simply go into your `<my_openaps>` directory and `
git push`. This process can be automated, but we'll save that for another day.

[Github mkimg tool](https://github.com/zymbit/rpi-mkimg) has the ability to create a full SD card image with the advantage to shrink it to its minimum size quite different from the windows Win32DiskImager which always creates an image which is as large as the card.  Using Win32DiskImager it might not be possible to restore an image on a new card with the same size. Using Github mkimg tool instead for example a 32 GB size card can be reduced to approximately 1.9 GB.

### GitHub Authentication

You may receive the following error attempting to push to GitHub:
```
Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists. 
```
If so, you'll need to set up authentication. First, generate an SSH key and add
it the ssh-agent, following the Github
[guide](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/).

Next, add the public key to your Github account. Again, GitHub has a
[guide](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/).
If connecting to your RPi over SSH, you can replace step 1 with the following
command to copy the public key to your clipboard:
```
ssh pi@raspberrypi.local "cat /home/pi/.ssh/id_rsa.pub" | pbcopy
```
(in Cygwin, replace `| pbcopy` with `> /dev/clipboard`)
