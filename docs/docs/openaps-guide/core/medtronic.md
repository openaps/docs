
## Medtronic vendor

The medtronic vendor is backed by [decocare].  **Decocare** supports all
paradigm series pumps.

Different pumps in the paradigm series have different features, decocare is
aware of many of these differences but not all.

Adding a medtronic device to openaps also requires the **SERIAL** number of
the pump.  This is a six digit number, it's printed on the back of the pump.
On the bottom right, there is a bar code, and right above that is the text:
`SN PAR123456U`.  In this case, the serial number is `123456`.
It's also on the escape/status screen, scroll down, below the date, it will
say: `S/N# 123456`, again the serial number would be `123456`.

For example purposes, we'll use the serial number `123456` here, you should
use your pump's serial number.  Also, for the purposes of this guide, we will
not be issuing any commands that cause changes.  For most of this tutorial,
you do not need access to a medtronic pump, or even the carelink stick, this
tutorial focuses on understanding how **devices** are related to **uses**.

## Configuring medtronic device

Let's add a `medtronic` **device** *named* `pump`.
Remember that adding a device enables us to **use** it, and there's a
`medtronic` vendor.  `openaps device add pump medtronic -h`
This one works a little different, it wants the serial number after:

```
usage: openaps-device add name medtronic [-h] serial

Medtronic - openaps driver for Medtronic

positional arguments:
  serial

optional arguments:
  -h, --help  show this help message and exit
```

So adding the serial to the end:
```
$ openaps device add pump medtronic 123456
added medtronic://pump
```

## openaps use pump
Based on our prior experience knowing that `device` enables **use**, let's
check out our own `openaps use -h` to see how it's changed.
```
[...]
Known Devices Menu:
  These are the devices openaps knows about:

  device                Name and description:
    howdy               process - a fake vendor to run arbitrary commands
    pump                Medtronic - openaps driver for Medtronic

Once a device is registered in openaps.ini, it can be used.
```

Now there's a **pump** device in the **use** menu!  What can it do `openaps use pump -h`

```
usage: openaps-use pump [-h] USAGE ...

optional arguments:
  -h, --help            show this help message and exit

## Device pump:
  vendor openaps.vendors.medtronic

  Medtronic - openaps driver for Medtronic



  USAGE                 Usage Details
    Session             session for pump
    bolus               Send bolus command. [#warning!!!]
    filter_glucose_date
                        Search for glucose pages including begin and end dates
                        (iso 8601).
    filter_isig_date    Search for isig pages including begin and end dates
                        (iso 8601).
    iter_glucose        Read latest 100 glucose records
    iter_glucose_hours  Read latest n hours of glucose data
    iter_pump           Read latest 100 pump records
    iter_pump_hours     Read latest n hours of pump records
    model               Get model number [#oref0] [#recommended] [#safe]
    mytest              Testing read_settings
    read_basal_profile_A
                        Read basal profile A.
    read_basal_profile_B
                        Read basal profile B.
    read_basal_profile_std
                        Read default basal profile.
    read_battery_status
                        Check battery status. [#oref0]
    read_bg_targets     Read bg targets. [#oref0]
    read_carb_ratios    Read carb_ratios. [#oref0]
    read_clock          Read date/time of pump [#oref0]
    read_current_glucose_pages
                        Read current glucose pages.
    read_current_history_pages
                        Read current history pages.
    read_glucose_data   Read pump glucose page
    read_history_data   Read pump history page
    read_insulin_sensitivies
                        XXX: Deprecated. Don't use. Use
                        read_insulin_sensitivities instead.
    read_insulin_sensitivities
                        Read insulin sensitivities. [#oref0]
    read_selected_basal_profile
                        Fetch the currently selected basal profile. [#oref0]
    read_settings       Read settings. [#oref0]
    read_status         Get pump status
    read_temp_basal     Read temporary basal rates. [#oref0]
    reservoir           Get pump remaining insulin
    resume_pump         resume pumping.
    scan                scan for usb stick
    set_clock           Set clock.
    set_temp_basal      Set temporary basal rates. [#oref0]
    settings            Get pump settings
    status              Get pump status (alias for read_status)
    suspend_pump        Suspend pumping.
```

This is a list of all things the `medtronic` **vendor** knows how to do.
These things have all been exposed in `openaps` as a single `use` in a
**uniform** and **reproducible** way.  Even though our `howdy` example device
was completely different, the way we **use** it is identical to the `pump`
device.

Get some of the help for how to use a pump:
* `openaps use pump model -h`
* `openaps use pump reservoir -h`
* `openaps use pump read_clock -h`
* `openaps use pump iter_pump_hours -h`


## Understanding how to talk to medtronic


This portion is the first portion of the tutorial where we will actually talk
to the pump using the carelink usb stick.
Everything prior to this has been configuration.
Most of the time, Medtronic's wireless interface is off.
There's a special command that enables wireless communication for several
minutes, this is configurable in using the `minutes` parameter in the
`pump.ini` **extra** ini.
The medtronic vendor here tracks whether or not the session is expired, and
renews it before continuing, this RF initialization could take an extra 30
seconds.

So, how fast does `openaps use pump model` take the first time?  How long does
it take if you repeat it several times?

Try the following commands, these are all safe, read-only commands:
* `openaps use pump model`
* `openaps use pump reservoir`
* `openaps use pump read_clock`
* `openaps use pump iter_pump_hours 2`
* If you are using Medtronic for CGM, try `openaps use pump iter_glucose_hours 2`

If you are going to build tools to improve diabetes therapy, which pieces of data might
you need to gather?  You can interactively **use** each of these features to
view and inspect the data.

[decocare]: https://github.com/bewest/decoding-carelink
