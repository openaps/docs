# Learning to Use openaps Tools


This section provides and introduction to intializing, configuring, and using the openaps toolset. The purpose is to get you familiar with how the different commands work and to get you thinking about how they may be used to build your own closed loop.

The [openaps readme](https://github.com/openaps/openaps/blob/master/README.md) has detailed information on the installation and usage of openaps. You should take the time to read through it in detail, even if it seems confusing at first. There are also a number of example uses available in the [openaps-example](https://github.com/bewest/openaps-example) repository.

Some notes on conventions used in this guide:
* Wherever there are `<bracketed_components>` in the the code, these are meant for you to insert your own information. Most of the time, it doesn't matter what you choose **as long as you stay consistent throughout this guide**. That means if you choose `Barney` as your  `<my_pump_name>`, you must use `Barney` every time you see `<my_pump_name>`. Choose carefully ...
* You will see a `$ ` at the beginning of many of the lines of code. This indicates that it is to be entered and executed at the terminal prompt. Do not type in the `$`.  

<br>
## Configure openaps

### Initialize a new openaps environment

`$ openaps init <my_openaps>`

Now that it has been created, move into the new openaps directory

`$ cd <my_openaps>`

This folder is mostly empty at the moment, 

### Add pump as device

`$ openaps device add <my_pump_name> medtronic <my_serial_number>`

### Add Dexcom CGM receiver as device
Note: this step not required if using a Medtronic CGM

`$ openaps device add <my_dexcom_name> dexcom`

### Check that the devices are all added properly

`$ openaps device show`

should return something like:

```
medtronic://pump
dexcom://cgms
```
Here, `pump` was used for `<my_pump_name>` and 'cgms' was used for `<my_dexcom_name>`. The names you selected should appear in their place.

### Check that you can talk with your pump

`$ openaps use <my_pump_name> model`

should return something like:

`"723"`

### Check that you can talk with your Dexcom receiver

`$ openaps use <my_dexcom_name> iter_glucose 1`

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

<br>
### Usage

    usage: openaps [-h] [-c C C] [-C CONFIG] [--version] [command] ...

#### openaps - openaps: a toolkit for DIY artificial pancreas system

##### positional arguments:
  * command
  * args

optional arguments:

    -h, --help            show this help message and exit
    -c C C
    -C CONFIG, --config CONFIG
    --version             show program's version number and exit

  Utilities for developing an artificial pancreas system.
  openaps helps you manage and structure reports for various devices.


All of the `device` and `report` `add` and `show` commands modify
`openaps.ini` in the current working directory, which is assumed to be
a git repo explicitily dedicated to helping develop and configure a
`DIY` artificial pancreas system.  This means `openaps` is an SDK for
an artificial pancreas system, not an artificial pancreas system.

See `openaps init` for setting up a brand new instance of your own
`openaps`, or see the notes below for details on how to convert an
existing git repo into an instance of `openaps`.

## Common workflows:

    openaps init
    openaps device <cmd>
      
      Device commands allow you to match a device driver, with a name
      and a configuration.
      
      add     - add device config to `openaps.ini`
      remove  - remove device from `openaps.ini`
      show    - print device uri, list all by default

    openaps use [--format <json,stdout,text>]
                [--output <filename>]
            <device>
            <use>
            [use-args...]

      For each device registered, the vendor implementation provides a
      number of uses.  This allows users to experiment with reports.

    openaps report <cmd>

      Reports match a device use to a format and filename.

      add     - add report config to `openaps.ini`
      remove  - remove report from `openaps.ini`
      show    - print report uri, list all by default
      invoke  - run and save report in file

### Init new openaps environment

Do not use `openaps` commands in the the openaps repo.  Only use the
`openaps` directory for hacking on the core library, or for managing
upgrades through git.  Instead change to a new directory, not managed
by git: `cd ~/Documents`.

Setup of new instance:  

    openaps init myopenaps    - this creates an instance of openaps in a new
                                directory, called myopenaps
    

    cd myopenaps - change directory to root of new repo

A valid instance of openaps is a git repo with a file called
`openaps.ini` present.

`openaps` will track configuration and some status information inside of
`openaps.ini`.

### Init existing git repo as openaps-environment 

If you already have a git repo which you would like to
become a valid openaps environent, in the root of your repo, run:

    touch openaps.ini
    git add openaps.ini
    git commit -avm 'init openaps'

Now, wth a valid `openaps` environment, you can register **device**s for
use.  A **device** is implemented by a **vendor**.  `openaps` provides a
modular, language and process independent environment for creating
vendors and devices.

### Managing devices

To register devices for use, see `openaps device` commands:

    openaps device -h
    openaps device add <name> <vendor> [opts...]
    eg:
    # register a medtronic device named pump
    openaps device add pump medtronic 665455
    # register a dexcom device named cgm
    openaps device add cgm dexcom

### Using devices
Now that devices are known, and we have a variety of commands
available.  We can explore how to produce reports by using devices
with the `openaps use` command:

    openaps use <device-name> <use-name> [opts]

`openaps use` commands can only be used after devices have been added to
the `openaps.ini` config using `openaps device add`.
Eg:

    openaps use pump -h        - show available commands for the
                                 device known as "pump"
    openaps use pump iter_pump 100 - get last 100 pump history records
                                 from the device called pump
    openaps use cgm -h         - show available commands for the
                                 device known as "cgm"
    openaps use cgm glucose

### Save reports
After experimenting with `openaps use` commands, users can save reports
using the `openaps report` commands.
`openaps report` commands map `openaps use` commands to filenames:

#### `openaps report add`

Adding a report means configuring a `use` command with a format and a
output, most commonly, a filename is used as the output.

    openaps report add <report-name> <report-formatter> <device> <use> [opts]

    # add a report, saved in a file called pump-history.json, which is
    # JSON format, from device pump using use iter_pump.
    openaps report add pump-history.json JSON pump iter_pump 100

    # add a report, saved in a file called glucose.json, which is
    # JSON format, from device cgm using use glucose.
    openaps report add glucose.json JSON cgm glucose

### `invoke` reports to run and save the results of the `use`

#### `openaps report invoke`

Invoking a report means running a `use` command according to it's
configuration.

    # invoke the report to create glucose.json
    openaps report invoke glucose.json

    # invoke the report to create pump-history.json
    openaps report invoke pump-history.json

All commands support tab completion, and -h help options to help
explore the live help system.


### Sample `use` commands

#### `medtronic`

Assuming device is named `pump`:

    usage: openaps-use pump [-h]
                            {Session, bolus, iter_glucose, iter_pump,
                            model, mytest, read_basal_profile_A,
                            read_basal_profile_B,
                            read_basal_profile_std, read_carb_ratios,
                            read_clock, read_current_glucose_pages,
                            read_current_history_pages,
                            read_glucose_data, read_history_data,
                            read_selected_basal_profile,
                            read_settings, read_status,
                            read_temp_basal, reservoir, resume_pump,
                            scan, set_temp_basal, settings, status,
                            suspend_pump}
                            ...

    positional arguments:
      {Session, bolus, iter_glucose, iter_pump, model, mytest,
      read_basal_profile_A, read_basal_profile_B,
      read_basal_profile_std, read_carb_ratios, read_clock,
      read_current_glucose_pages, read_current_history_pages,
      read_glucose_data, read_history_data,
      read_selected_basal_profile, read_settings, read_status,
      read_temp_basal, reservoir, resume_pump, scan, set_temp_basal,
      settings, status, suspend_pump}
                            Operation
        Session             session for pump
        bolus               Send bolus.
        iter_glucose        Read latest 100 glucose records
        iter_pump           Read latest 100 pump records
        model               Get model number
        mytest              Testing read_settings
        read_basal_profile_A
                            Read basal profile A.
        read_basal_profile_B
                            Read basal profile B.
        read_basal_profile_std
                            Read default basal profile.
        read_carb_ratios    Read carb_ratios.
        read_clock          Read date/time of pump
        read_current_glucose_pages
                            Read current glucose pages.
        read_current_history_pages
                            Read current history pages.
        read_glucose_data   Read pump glucose page
        read_history_data   Read pump history page
        read_selected_basal_profile
                            Fetch the currently selected basal profile.
        read_settings       Read settings.
        read_status         Get pump status
        read_temp_basal     Read temporary basal rates.
        reservoir           Get pump remaining insulin
        resume_pump         resume pumping.
        scan                scan for usb stick
        set_temp_basal      Set temporary basal rates.
        settings            Get pump settings
        status              Get pump status (alias for read_status)
        suspend_pump        Suspend pumping.

    optional arguments:
      -h, --help            show this help message and exit

Some commands like `read_glucose_data`, `read_history_data` take a
`page` parameter, describing which page to fetch.

Some commands like `bolus`, `set_temp_basal`, take an `input`
parameter which may be `-` for `stdin` or a filename containing a json
data structure which represents the request.

All commands support `-h` and `--help` output.

#### `dexcom`


    usage: openaps-use cgm [-h] {glucose,iter_glucose,scan} ...

    positional arguments:
      {glucose,iter_glucose,scan}
                            Operation
        glucose             glucose (will pull all records)
        iter_glucose <n>       glucose ('n' for the number of records you want)
        scan                scan for usb stick

    optional arguments:
      -h, --help            show this help message and exit



#### Further integration:

In order to have a fully operating OpenAPS, you will need to execute OpenAPS with your preprogrammed scripts, either in Python or JavaScript, as a bash shell script, using cron, to schedule the OpenAPS to make dosing changes at a specified time. See this tutorial on [cron](https://en.wikipedia.org/wiki/Cron). A tutorial on bash shell scripts is [here](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html)

You can create and support plugins for OpenAPS, specifically, as a "process" type of plugin. So by typing for example 

`openaps device add calciob process --require input node iob.js` 

tells OpenAPS that `iob.js` is a "node script". This also means that it takes a single input, which we will call `input` and to internally name that as a device called `calciob`. So now the plugin shows up under `openaps use calciob -h` and if your run the use case there, as stated in the getting started guide, it actually runs the node script with the required arguments.
