# Configuring and Learning to Use openaps Tools


This section provides and introduction to intializing, configuring, and using the openaps toolset. The purpose is to get you familiar with how the different commands work and to get you thinking about how they may be used to build your own closed loop.

The [openaps readme](https://github.com/openaps/openaps/blob/master/README.md) has detailed information on the installation and usage of openaps. You should take the time to read through it in detail, even if it seems confusing at first. There are also a number of example uses available in the [openaps-example](https://github.com/bewest/openaps-example) repository.

Some notes on conventions used in this guide:
* Wherever there are `<bracketed_components>` in the the code, these are meant for you to insert your own information. Most of the time, it doesn't matter what you choose **as long as you stay consistent throughout this guide**. That means if you choose `Barney` as your  `<my_pump_name>`, you must use `Barney` every time you see `<my_pump_name>`. Choose carefully. Do not include the `< >` brackets in your name.
* You will see a `$ ` at the beginning of many of the lines of code. This indicates that it is to be entered and executed at the terminal prompt. Do not type in the `$`.  

<br>
## Configure openaps

### Initialize a new openaps environment

To get started, go to your home directory:

`$ cd`

Create a new instance of openaps in a new directory.

`$ openaps init <my_openaps>`

As mentioned above, `<my_openaps>` can be anything you'd like: `myopenaps`, `awesome-openaps`, `openaps4ever`, `bob`, etc.

Now that it has been created, move into the new openaps directory:

`$ cd <my_openaps>`

This folder is mostly empty at the moment, as can been seen by running the list files command:

```
$ ls
openaps.ini
```
That `openaps.ini` file is the configuration file for this particular instance of openaps. It will contain all of your devices information, plugin information, report, and alias . In the subsequent sections, you will be configuring your openaps instance to add these components. For now, however, it is blank. Go ahead and take a look:

`$ cat openaps.ini`

Didn't return much, did it? By the way, that `cat` command will be very useful as you go through these configuration steps to quickly check the contents of files.

### Add pump as device

In order to communicate with the pump and cgm receiver, they must first be added as devices to the openaps configuration. To do this for the pump:

`$ openaps device add <my_pump_name> medtronic <my_serial_number>`

Here, `<my_pump_name>` can be whatever you like, but `<my_serial_number>` must be the 6-digit serial number of your pump. You can find this either on the back of the pump or near the bottom of the pump's status screen, accessed by hitting the ESC key.

### Add Dexcom CGM receiver as device

Now you will do this for the Dexcom CGM receiver.

`$ openaps device add <my_dexcom_name> dexcom`

Note this step is not required if you are using a Medtronic CGM. The pump serves as the receiver and all of the pumping and glucose functionality are contained in the same openaps device.

### Check that the devices are all added properly

`$ openaps device show`

should return something like:

```
medtronic://pump
dexcom://cgms
```
Here, `pump` was used for `<my_pump_name>` and 'cgms' was used for `<my_dexcom_name>`. The names you selected should appear in their place.

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

It is important to note that your pump's serial number also serves as its security key, so be careful with the openaps.ini file. If you need to share it for some reason, be sure and remove your serial number first.

### Check that you can communicate with your pump

Now that you have added these devices, let's see if we can establish communication with them. First, the pump:

`$ openaps use <my_pump_name> model`

should return something like:

`"723"`

Pretty cool, right? Congratulations, you just pulled data from your pump! The `model` command is a very useful one to verify whether you can communicate with the pump. It is not, however, the only thing you can do. Take a look at the help file to see all of the possibilities:

`$ openaps use <my_pump_name> -h`

This returns a healthy bit of useful information, including a list of all the commands that can be done with `$ openaps use <my_pump_name>`. Of course, each one of those uses has its own help file as well:

```
$ openaps use <my_pump_name> model -h
usage: openaps-use pump model [-h]

 Get model number
  

optional arguments:
  -h, --help  show this help message and exit
```

The `-h` argument is your friend. If you ever forget what command does, what arguments it requires, or what options it has, `-h` should be your first resource.

Go ahead and try some more pump uses to see what they do.

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
Hint: if this doesn't work, check to make sure that your Dexcom receiver is plugged into your RPi ;-)

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

