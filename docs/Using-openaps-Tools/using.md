# Configuring and Learning to Use openaps Tools


This section provides an introduction to intializing, configuring, and using the openaps toolset. The purpose is to get you familiar with how the different commands work and to get you thinking about how they may be used to build your own closed loop. Make sure you have completed the [Setting Up the Raspberry Pi 2](./docs/Setup/rpi.md) and [Setting Up openaps](./docs/Setup/openaps.md) sections prior to starting.

The [openaps readme](https://github.com/openaps/openaps/blob/master/README.md) has detailed information on the installation and usage of openaps. You should take the time to read through it in detail, even if it seems confusing at first. There are also a number of example uses available in the [openaps-example](https://github.com/bewest/openaps-example) repository.

Some familiarity with using the terminal will go a long way, so if you aren't comfortable with what `cd` and `ls` do, take a look at some of the Linux Shell / Terminal links on the [Resources](./docs/Resources/resources.md) page.

Some conventions used in this guide:
* Wherever there are `<bracketed_components>` in the the code, these are meant for you to insert your own information. Most of the time, it doesn't matter what you choose **as long as you stay consistent throughout this guide**. That means if you choose `Barney` as your  `<my_pump_name>`, you must use `Barney` every time you see `<my_pump_name>`. Choose carefully. Do not include the `< >` brackets in your name.
* You will see a `$ ` at the beginning of many of the lines of code. This indicates that it is to be entered and executed at the terminal prompt. Do not type in the `$`.  

One helpful thing to do before starting is to log your terminal session. This will allow you to go back and see what you did at a later date. This will also be immensely helpful if you request help from other OpenAPS contributors as you will be able to provide an entire history of the commands you used. To enable this, just run `$ script <filename>` at the beginning of your session. It will inform you that `Script started, file is <filename>`. When you are done, simply `$ exit` and it will announce `Script done, file is <filename>`. At that point, you can review the file as necessary.

<br>
## Configuring openaps

### Initialize a new openaps environment

To get started, SSH into your Raspberry Pi. Go to your home directory:

`$ cd`

Create a new instance of openaps in a new directory:

`$ openaps init <my_openaps>`

As mentioned above, `<my_openaps>` can be anything you'd like: `myopenaps`, `awesome-openaps`, `openaps4ever`, `bob`, etc.

Now that it has been created, move into the new openaps directory:

`$ cd <my_openaps>`

All subsequent openaps commands must be run in this directory. If you try to run an openaps command in a different directory, you will receive an error:

`Not an openaps environment, run: openaps init`

The directory you just created and initialized as an openaps environment is mostly empty at the moment, as can been seen by running the list files command:

```
$ ls
openaps.ini
```
That `openaps.ini` file is the configuration file for this particular instance of openaps. It will contain all of your device information, plugin information, reports, and aliases. In the subsequent sections, you will be configuring your openaps instance to add these components. For now, however, it is blank. Go ahead and take a look:

`$ cat openaps.ini`

Didn't return much, did it? By the way, that `cat` command will be very useful as you go through these configuration steps to quickly check the contents of files (any files, not just `openaps.ini`). Similarly, if you see a command that you are unfamiliar with, such as `cat` or `cd`, Google it to understand what it does. The same goes for error messages—you are likely not the first one to encounter whatever error is holding you back.

### Add pump as device

In order to communicate with the pump and cgm receiver, they must first be added as devices to the openaps configuration. To do this for the pump:

`$ openaps device add <my_pump_name> medtronic <my_serial_number>`

Here, `<my_pump_name>` can be whatever you like, but `<my_serial_number>` must be the 6-digit serial number of your pump. You can find this either on the back of the pump or near the bottom of the pump's status screen, accessed by hitting the ESC key.

**Important:** Never share your 6-digit pump serial number and never post it online. If someone had access to this number, and was in radio reach of your pump, this could be used to communicate with your pump without your knowledge. While this is a feature when you want to build an OpenAPS, it is a flaw and a security issue if someone else can do this to you.

### Add Dexcom CGM receiver as device

Now you will do this for the Dexcom CGM receiver:

`$ openaps device add <my_dexcom_name> dexcom`

Note this step is not required if you are using a Medtronic CGM. The pump serves as the receiver and all of the pumping and glucose functionality are contained in the same openaps device.

### Check that the devices are all added properly

`$ openaps device show`

should return something like:

```
medtronic://pump
dexcom://cgms
```
Here, `pump` was used for `<my_pump_name>` and `cgms` was used for `<my_dexcom_name>`. The names you selected should appear in their place.

Your `openaps.ini` file now has some content; go ahead and take another look:

`$ cat openaps.ini`

Now, both of your devices are in this configuration file:

```
[device "pump"]
serial = 123456
vendor = openaps.vendors.medtronic
expires = 2015-09-17T23:21:06.310008
model = 723

[device "cgms"]
vendor = openaps.vendors.dexcom
```

Again, `pump` was used for `<my_pump_name>` and `cgms` was used for `<my_dexcom_name>`. Your pump model should also match your pump.

Remember that, because your pump's serial number also serves as its security key, you must be careful with the `openaps.ini` file. If you need to share it for some reason, be sure and remove your serial number first.

If you made a mistake while adding your devices or simply don't like the name you used, you can go back and remove the devices as well. For example, to remove the pump:

`$ openaps device remove <my_pump_name>`

Then, you can add your pump again with a different name or serial number.

### Check that you can communicate with your pump

Now that you have added these devices, let's see if we can establish communication with them. First, the pump:

`$ openaps use <my_pump_name> model`

should return something like:

`"723"`

Congratulations, you just pulled data from your pump! The `model` command is a very useful one to verify whether you can communicate with the pump. It is not, however, the only thing you can do. Take a look at the help file to see all of the possibilities:

`$ openaps use <my_pump_name> -h`

This returns a healthy bit of useful information, including a list of all the commands that can be done with `$ openaps use <my_pump_name>`. Of course, each one of those uses has its own help file as well:

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

Now let's try communicating with the Dexcom receiver:

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

<br>
## Adding and Invoking Reports

At this point, you should be comfortable communicating with your pump and cgm receiver with the `openaps use` command. This is great for learning and for experimenting, but it lacks the ability to generate output files. You'll notice that running

`$ openaps use <my_dexcom_name> iter_glucose 100`

prints *a lot* of data to the terminal. It would be great to save that data somewhere so that it can be used for logging historical records, performing calculations, and verifying actions. That is what `report` does.

Generating reports involves two steps: adding the report structures to your openaps configuration and invoking the reports to produce the desired outcome.

### Adding Reports

As an example, let's suppose you would like to gather the last four hours of records from your pump. With the `use` command, that would be:

`$ openaps use <my_pump_name> iter_pump_hours 4`

This dumps the past four hours of pump records directly to the terminal.

Now, let's add this as a report instead:

`$ openaps report add last_four_pump_hours.json JSON <my_pump_name> iter_pump_hours 4`

If done correctly, the only thing returned in the terminal is:

`added pump://JSON/iter_pump_hours/last_four_pump_hours.json`

Let's take a closer look at each section. `openaps report add` is adding a report to your openaps configuation. The report name is `last_four_pump_hours.json`. The format of the report is `JSON`. The command that will be used to generate the report is `<my_pump_name> iter_pump_hours 4`. You will notice that this last section is identical to what was called above when you printed the output to the terminal window, except there it was done with the `use` command. The report is simply running that same command and writing the output to the file you specified in the format you specified.

Much like adding devices, this report configuration is saved to your `openaps.ini` file. You can view all of your reports there with `$ cat openaps.ini` or by using `$ openaps report show`. Similarly, you can remove aliases with `$ openaps report remove <report_name>`.

### Invoking Reports

Adding the report does not actually generate the output file. To do this, you need to invoke the report:

`$ openaps report invoke last_four_pump_hours.json`

Again, the terminal output will be minimal:

```
pump://JSON/iter_pump_hours/last_four_pump_hours.json
reporting last_four_pump_hours.json
```

This time, however, a new file was created. Check and see using `$ ls`; you should see a file called `last_four_pump_hours.json` in your directory. Take a look at the file with `$ cat last_four_pump_hours.json`. The file's contents should look very familiar—the same data that was printed to ther terminal window when you performed `$ openaps use <my_pump_name> iter_pump_hours 4`.

Each time you add a new report to your configuration, you should immediately invoke it and check the resulting file. This means **open the file and actually check to make sure the output is what you expect**. Don't assume that it worked just because you didn't see an error.

The reports you add are reusable—each time you would like new data, simply invoke the report again and it will overwrite the output file. If you would like to see when the file was last edited, use the command `$ ls -l`. This will help you make sure you are getting up-to-data data.

Go ahead and create (and check) some reports for the the commands you have been using the most.

<br>
## Aliases

Now that you have some reports added, you may notice that you end up calling some of them in combinations. For example, you might always want to get your updated pump records and your updated cgm records. To do that, you would normally run two commands each time:

```
$ openaps report invoke last_four_pump_hours.json
$ openaps report invoke last_four_cgm_hours.json
```

For this example, we assume that you have added a second report called `last_four_cgm_hours.json` that is similar to the `last_four_pump_hours.json` we walked through previously, except that it is using your `<my_dexcom_name>` device and the `iter_glucose_hours` command. Go ahead and do that so you can follow along.

Calling two sequential commands for each update is a bit annoying, but imagine calling five or ten. Alternatively, you can concatenate additional reports onto a single `invoke` call:

`$ openaps report invoke last_four_pump_hours.json last_four_cgm_hours.json`

This will invoke both reports in sequence, just like the two commands above.

A further simplification of repeated commands is available in openaps: aliases. Aliases allow generation of single-word commands to invoke a series of reports. For this example, create an alias called `last_four_hours`:

`$ openaps alias add last_four_hours "report invoke last_four_pump_hours.json last_four_cgm_hours.json"`

Go ahead and execute this command:

`$ openaps last_four_hours`

You will see that it invokes each of the reports you specified in the order you specified. It prints each step out to the terminal window, and you will find that the corresponding output files have been created.

Just like with devices and reports, the alias is now part of your openaps configuration. You can view all of your aliases with `$ cat openaps.ini` or by using `$ openaps alias show`. Similarly, you can remove aliases with `$ openaps alias remove <alias_name>`.

Aliases are not limited to reports, but we will leave that up to you to explore.

<br>
## Backing Up Your openaps Instance

There are numerous ways to back up your system, from making a copy of the entire SD card to copying over individual files. Here, we will discuss one method of using git to back up just the openaps instance you've created. Note that this will not back up the entire sysem (and all the work you did in [Setting Up the Raspberry Pi 2](./docs/Setup/rpi.md) and [Setting Up openaps](./docs/Setup/openaps.md)), but it will enable you to skip all of the configuration steps above if something happens.

For this backup method, we will take advantage of the fact that your openaps instanace is a git repository. We won't go over git here, but take a look at the references on the [Resources](./docs/Resources/resources.md) page to get familiar with the basics. Typically, we would do this backup using GitHub, since that is where most of the openaps repositories are located and you should already have an account. However, GitHub only provides free repositories if they are public, and since this repository has your `openaps.ini` file—and thus your pump's serial number—in it, we want to make sure it is private. You can [purchase a monthly GitHub plan](https://github.com/pricing), but there is another way.

[Bitbucket](https://bitbucket.org/) offers a similar service but permits users to create free private repositories. Go ahead and sign up and then create a repository. You can call it whatever you like, but makes sure that on the "Create a new repository" setup page you leave the "This is a private repository" box checked. Once created, you will be directed to a "Repository setup" page. Under the "Command line" section, click on the "I have an existing project" option and follow the instructions.

Once you have completed this step, all of the files in your `<my_openaps>` directory will be saved in your online Bitbucket repository. Whenever you would like to update your backup, simply go into your `<my_openaps>` directory and `$ git push`. This process can be automated, but we'll save that for another day.

