# Using oref0 Tools

## Add the oref0 Virtual Devices

Note: The names and folders used in this doc do not correspond to names used in some of the recent templates creating devices, reports, and aliases. For example: bg_targets_raw.json in the docs is bg-targets-raw.json in the templates as well as things like settings/insulin_sensitivities_raw.json in the docs is raw-pump/insulin-sensitivities-raw.json in the templates.  

Here are some of the newer reports copied from the newer style walkthrough:

This creates several devices to manage oref0:

```
oref0 template mint device oref0 | openaps import
```

Create medtronic and oref0 reports, this handles timezones, units conversion, as well as detecting freshness of files.

```
oref0 template mint reports  medtronic-pump | openaps import
oref0 template mint reports  oref0-inputs | openaps import
```

# Older directions (needs updating or delete altogether in favor of templates?)
In Phase 1, you added two physical medical devices to openaps—your pump and your cgm. This was done using the command `openaps device add` and then specifying the device name, type, and parameters. OpenAPS tools to gather system profile parameters such as pump settings, calculate the current insulin on board (IOB), and determine if the pump temp basal should be updated or not, are contained in the OpenAPS reference system oref0. Since there is no physical oref0 device, you are essentially adding it to the openaps environment as a virtual device or plugin.

First, you can add a catch-all oref0 device using

```
$ openaps device add oref0 process oref0
```

and then you can be more specific and add individual oref0 processes as virtual devices using the following commands:

```
$ openaps device add get-profile process --require "settings bg_targets insulin_sensitivities basal_profile preferences" oref0 get-profile
$ openaps device add calculate-iob process --require "pumphistory profile clock" oref0 calculate-iob
$ openaps device add determine-basal process --require "iob temp_basal glucose profile" oref0 determine-basal
```

In these commands, `--require` specifies the arguments required by each of the oref0 processes. Most of the arguments to the oref0 processes should look familiar to you from your experimentation with `openaps` tools earlier. Now it's time to put together reports that the oref0 processes use as inputs, as well as reports and aliases that invoke the oref0 processes themselves.

## Organizing the reports

It is convenient to group your reports into `settings`, `monitor`, and `enact` directories. The `settings` directory holds reports you may not need to refresh as frequently as those in `monitor` (e.g. BG targets and basal profile, vs. pump history and calculated IOB). Finally, the `enact` directory can be used to store recommendations ready to be reviewed or enacted (sent to the pump). The rest of this section assumes that you have created `settings`, `monitor`, and `enact` as subdirectories in your openaps directory. The following shell command creates these three directories:

```
$ mkdir -p settings monitor enact
```

## The get-profile process

The purpose of the `get-profile` process is to consolidate information from multiple settings reports into a single JSON file. This makes it easier to pass the relevant settings information to oref0 tools in subsequent steps. Let's look at what kind of reports you may want to set up for each of the `get-profile` process arguments:

* `settings` outputs a JSON file containing the pump settings:

  ```
  $ openaps report add settings/settings.json JSON pump read_settings
  ```

* `bg_targets` outputs a JSON file with bg targets collected from the pump:

  ```
  $ openaps report add settings/bg_targets_raw.json JSON pump read_bg_targets
  ```
  * If your pump OR CGM is European and displays mmol/L as opposed to mg/dl you will need to convert this "raw" file.

    First install the unit conversion device to ensure all units will match.
     ```
      $ openaps device add units units
      ```
    Go through the standard process of use, report add, report invoke for the 2 reports below.

    For Blood Sugar Conversion
    The `units` function ensures that units will match.  To use it, add units to your list of devices with:
      ```
      $ openaps device add units units
      ```
    To convert this "raw" file, we need to add a report that will perform
    `openaps use units bg_targets settings/bg_targets_raw.json`
    and output not to the screen but into a file called settings/bg_targets.json:
      ```
      $ openaps report add settings/bg_targets.json JSON units bg_targets settings/bg_targets_raw.json
      ```
    For Insulin Sensitivity
       ```
      $ openaps report add settings/insulin_sensitivities.json JSON units insulin_sensitivities settings/insulin_sensitivities_raw.json

* `insulin_sensitivities` outputs a JSON file with insulin sensitivities obtained from the pump:

  ```
  $ openaps report add settings/insulin_sensitivities_raw.json JSON <my_pump_name> read_insulin_sensitivities
  ```

* `basal_profile` outputs a JSON file with the basal rates stored on the pump in your basal profile

  ```
  $ openaps report add settings/basal_profile.json JSON <my_pump_name> read_basal_profile_std
  ```

* `preferences` is an exception: in contrast to the other settings above, `preferences` is not the result of an openaps report. It's a JSON file that should contain a single line with your maximum IOB, such as: `{"max_iob": 0}`. You can create this file by hand, or use the [oref0-mint-max-iob](https://github.com/openaps/oref0/blob/master/bin/oref0-mint-max-iob.sh) tool to generate the file (click on "Update Oref0-mint-max-iob to use preferences.json" in Github). The `max_iob` variable represents an upper limit to how much insulin on board oref0 is allowed to contribute by enacting temp basals over a period of time. In the example above, `max_iob` equals 0 units of insulin.  To create a JSON file:

    ```
      $ nano preferences.json
      ```
which opens in a nano editor.  Then type in {"max_iob":0} or whatever number you are choosing and Ctrl + X to exit.

Make sure you test invoking each of these reports as you set them up, and review the corresponding JSON files using `cat`. Once you have a report for each argument required by `get-profile`, you can add a `profile` report:

```
$ openaps report add settings/profile.json text get-profile shell settings/settings.json settings/bg_targets_raw.json settings/insulin_sensitivities_raw.json settings/basal_profile.json preferences.json
```
If you need to add a `profile` report that has the unit conversion, you can use this:
```
$ openaps report add settings/profile.json text get-profile shell settings/settings.json settings/bg_targets.json settings/insulin_sensitivities.json settings/basal_profile.json preferences.json
```

Note how the `profile` report uses `get-profile` virtual device, with all the required inputs provided.
At this point, it's natural to add an alias that generates all the reports required for `get-profile`, and then invokes the `profile` report that calls `get-profile` on them:

```
$ openaps alias add get-profile "report invoke settings/settings.json settings/bg_targets_raw.json settings/bg_targets.json settings/insulin_sensitivities_raw.json settings/insulin_sensitivities.json settings/basal_profile.json settings/profile.json"
```

Remember, what you name things is not important - but remembering WHAT you name each thing and using it consistently throughout is key to saving you a lot of debugging time.  Also, note that the name of your report and the name of the corresponding file created by the report are the same. For example, you invoke a report called "settings/settings.json" and the results are stored in "settings/settings.json".  The corresponding output file is created by invoking the report.

## The calculate-iob process

This process uses pump history and the result of `get-profile` to calculate IOB. The IOB is calculated based on normal boluses and basal rates over past several hours. At this time, extended boluses are not taken into account. The `get-profile` arguments, and suggested reports are as follows:

* `profile`: report for `get-profile`, as discussed above

* `pumphistory` stores pump history in a JSON file

  ```
  $ openaps report add monitor/pumphistory.json JSON pump iter_pump_hours 4
  ```

In this example, pump history is over a period of 4 hours. Normally, you would want oref0 to operate based on pump history over the number of hours at least equal to what you assume is your active insulin time.

* `clock` outputs the current time stamp from the pump

  ```
  $ openaps report add monitor/clock.json JSON pump read_clock
  ```

You can now add a report for the `calculate-iob` process:

```
$ openaps report add monitor/iob.json JSON calculate-iob shell monitor/pumphistory.json settings/profile.json monitor/clock.json
```

As always, it is a good idea to carefully test and examine the generated reports.

## The determine-basal process

This process uses the IOB computed by `calculate-iob`, the current temp basal state, CGM history, and the profile to determine what temp basal to recommend (if any). Its arguments and reports could be setup as follow:

* `iob`: your report for `calculate-iob`

* `profile`: your report for `get-profile`

* `temp_basal` reads from pump and outputs the current temp basal state:

  ```
  $ openaps report add monitor/temp_basal.json JSON pump read_temp_basal
  ```

* `glucose` reads several most recent BG values from CGM and stores them in glucose.json file:

  ```
  $ openaps report add monitor/glucose.json JSON <my_cgm_name> iter_glucose 5
  ```

In this example, glucose.json will contain 5 most recent bg values.

Finally, a report for `determine-basal` may look like this:

```
$ openaps report add enact/suggested.json text determine-basal shell monitor/iob.json monitor/temp_basal.json monitor/glucose.json settings/profile.json
```

The report output is in suggested.json file, which includes a recommendation to be enacted by sending, if necessary, a new temp basal to the pump, as well as a reason for the recommendation.

If you are using a Minimed CGM (enlite sensors with glucose values read by your pump), you might get this error message when running this report `Could not determine last BG time`. That is because times are reported differently than from the Dexcom receiver and need to be converted first. See the section at the bottom of this page.

## Adding aliases

You may want to add a `monitor-pump` alias to group all the pump-related reports, which should generally be obtained before running  `calculate-iob` and `determine-basal` processes:

```
$ openaps alias add monitor-pump "report invoke monitor/clock.json monitor/temp_basal.json monitor/pumphistory.json monitor/iob.json"
```

For consistency, you may also want to add a `monitor-cgm` alias. Even though it's invoking only a single report, keeping this consistent with the `monitor-pump` alias makes the system easier to put together and reason about.

```
$ openaps alias add monitor-cgm "report invoke monitor/glucose.json"
```

## Checking your reports

At this point you can call

```
$ openaps report show
```

and

```
$ openaps alias show
```

to list all the reports and aliases you've set up so far. You'll want to ensure that you've set up a report for every argument for every oref0 process and, *more importantly*, that you understand what each report and process does. This is an excellent opportunity to make some `openaps report invoke` calls and to `cat` the report files, in order to gain better familiarity with system inputs and outputs.

You can also test the full sequence of aliases and the that which depend on them:

```
$ rm -f settings/* monitor/* enact/*
$ openaps get-profile
$ openaps monitor-pump
$ openaps monitor-cgm
$ openaps report invoke monitor/iob.json
$ openaps report invoke enact/suggested.json
```

It is particularly important to examine suggested.json, which is the output of the `determine-basal` process, i.e. the output of the calculations performed to determine what temp basal rate, if any, should be enacted. Let's take a look at some suggested.json examples:

```
{"temp": "absolute","bg": 89,"tick": -7,"eventualBG": -56,"snoozeBG": 76,"reason": "Eventual BG -56<100, no temp, setting -0.435U/hr","duration": 30,"rate": 0}
```

In this example, the current temporary basal rate type is "absolute", which should always be the case. The current BG values is 89, which dropped from 96 by a "tick" value of -7. "eventualBG" and "snoozeBG" are oref0 variables projecting ultimate bg values based on the current IOB with or without meal bolus contributions, an average change in BG over the most recent CGM data in glucose.json, and your insulin sensitivity. The "reason" indicates why the recommendation is made. In the example shown, "eventualBG" is less than the target BG (100), no temp rate is currently set, and the temp rate required to bring the eventual BG to target is -0.435U/hr. Unfortunately, we do not have glucagon available, and the pump is unable to implement a negative temp basal rate. The system recommends the best it can: set the "rate" to 0 for a "duration" of 30 minutes. In the oref0 algorithm, a new temp basal rate duration is always set to 30 minutes. Let's take a look at another example of `suggested.json`:

```
{"temp": "absolute","bg": 91,"tick": "+6","eventualBG": -2,"snoozeBG": 65,"reason": "Eventual BG -2<100, but Delta +6 > Exp. Delta -2.3;cancel","duration": 0,"rate": 0}
```

In this case, the eventual BG is again less than the target, but BG is increasing (e.g. due to a recent meal). The actual "tick", which is also referred to as "Delta", is larger than the change that would be expected based on the current IOB and the insulin sensitivity. The system therefore recommends canceling the temp basal rate, which is in general done by setting "duration" to 0. Finally, consider this example:

```
{"temp": "absolute","bg": 95,"tick": "+4","eventualBG": 13,"snoozeBG": 67,"reason": "Eventual BG 13<90, but Avg. Delta 4.00 > Exp. Delta -2.9; no temp to cancel"}
```

which is similar to the previous example except that in this case there is no temp basal rate to cancel. To gain better understanding of oref0 operation, you may want to also read [Understanding oref0-determine-basal recommendations](../phase-3/Understand-determine-basal.md) and spend some time generating and looking through suggested.json and other reports.

## Enacting the suggested action

Based on suggested.json, which is the output of the `determine-basal` oref0 process, the next step is to enact the suggested action, i.e. to send a new temp rate to the pump, to cancel the current temp rate, or do nothing. The approach one may follow is to setup an  `enacted.json` report, and a corresponding `enact` alias. Thinking about how to setup the `enact` report and alias, you may consider the following questions:

* Which pump command could be used to enact a new basal temp, if necessary, and what inputs should that command take? Where should these inputs come from?

Use your answer to this question to create and test an openaps use command by looking at the pump to see what, if anything, is happening.  Once you have a working use command, create a report called enact/enacted.json to capture the data and an alias to invoke the report (which will send the command to the pump).  The enact/enacted.json report will capture the commands that were sent to the pump.

* How could a decision be made whether a new basal temp should be sent to the pump or not? What should `enact` do in the cases when no new temp basal is suggested?

This functionality is built within the oref0 code, but it is helpful to think through as you work towards understanding your open loop and how it will function.

Once you setup your `enact` alias, you should plan to experiment by running the required sequence of reports and by executing the `enact` alias using `openaps enact`. Plan to test and correct your setup until you are certain that `enact` works correctly in different situations, including recommendations to update the temp basal, cancel the temp basal, or do nothing.

In order to ensure that your pump is able to accept the temp basal suggestion, ensure that the temp basal setting, on the pump itself is set to "Insulin Rate (U/H)". This can be found in Act>basal>Temp basal type.

## Cleaning CGM data from Minimed CGM systems

If you are using the Minimed Enlite system, then your report for `iter_glucose` uses your pump device because the pump is the source of your CGM data. Unfortunately, the pump reports CGM data a bit differently and so your glucose.json file needs cleaning to align it with Dexcom CGM data. The simplest way to handle this is with this excellent plug-in:

https://github.com/loudnate/openaps-glucosetools

After installing glucosetools, add the vendor and device with:

```
$ openaps vendor add openapscontrib.glucosetools
$ openaps device add glucose glucosetools
```

Now you can create a report to clean your glucose data like this:
```
openaps report add monitor/glucoseclean.json JSON glucose clean monitor/glucose.json
```
And you should then make sure that your enact/suggested.json report uses monitor/glucoseclean.json instead of monitor/glucose.json. You can add the `clean` report to your `monitor-cgm` alias, as long as it comes after the `iter_glucose` report.

Note that if you use Nightscout visualization as described later, you can use the built-in tool `mm-format-ns-glucose` to help formatting the Minimed glucose data. If you do, run the tool against the original `iter-glucose` output (monitor/glucose.json), *not* the output from glucosetools.
