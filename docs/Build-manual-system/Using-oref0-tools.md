#Using oref0 Tools

## Add the oref0 Virtual Devices
In Phase 1, you added two physical medical devices to openaps—your pump and your cgm. This was done using the command `$ openaps device add` and then specifying the device name, type, and parameters. Since there is no physical oref0 device, you are essentially adding it to the openaps environment as a virtual device or plugin.

You can add a catch-all oref0 device using

`$ openaps device add oref0 process oref0`

and then you can be more specific and add individual oref0 processes as virtual devices using the following commands: 

```
$ openaps device add get-profile process --require "settings bg_targets insulin_sensitivities basal_profile max_iob" oref0 get-profile
$ openaps device add calculate-iob process --require "pumphistory profile clock" oref0 calculate-iob
$ openaps device add determine-basal process --require "iob temp_basal glucose profile" oref0 determine-basal
```

In these commands, `--require` specifies the arguments required by each of the oref0 processes. Most of the arguments to the oref0 processes should look familiar to you from your experimentation with `openaps` tools earlier. Now it's time to put together reports that the oref0 processes can use as inputs, and reports that invoke the oref0 processes themselves. Next, the oref0 processes are discussed in more detail.

## Organizing the reports

It is convenient to group your reports into `settings`, `monitor`, and `enact` directories. The `settings` directory holds reports you may not need to refresh as frequently as those in `monitor` (e.g. BG targets and basal profile, vs. pump history and calculated IOB). Finally, the `enact` directory can be used to store recommendations ready to be reviewed or enacted, i.e. sent to the pump. The rest of this section assumes that you created the `settings`, `monitor`, and `enact` as subdirectories in your openaps directory. The following shell command creates these three directories:
```
$ mkdir -p settings monitor enact
```

## The get-profile process

The purpose of the `get-profile` process is to consolidate information from multiple settings reports into a single JSON file. This makes it easier to pass the relevant settings information to subsequent steps. Let's look at what kind of reports you may want to set up for each of the `get-profile` process arguments:

* `settings` outputs a JSON file containing the pump settings:
  ```
  $ openaps report add settings/settings.json JSON pump read_settings
  ```

* `bg_targets` outputs a JSON file with bg targets collected from the pump:
  ```
  $ openaps report add settings/bg_targets.json JSON pump read_bg_targets
  ```

* `insulin_sensitivities` outputs a JSON file with insulin sensitivites from the pump:
  ```
  $ openaps report add settings/insulin_sensitivities.json JSON pump read_insulin_sensitivies
  ```

* `basal_profile` outputs a JSON file with the basal rates stored on the pump
  ```
  $ openaps report add settings/basal_profile.json JSON pump read_basal_profile_std
  ```

* `max_iob`: This is an exception: in contrast to the other settings above, `max_iob` is not the result of an openaps report. It's a JSON file that should contain a single line, such as: `{"max_iob": 2}`. You can create this file by hand, or use the [oref0-mint-max-iob.sh](https://github.com/openaps/oref0/blob/master/bin/basal_profile.json.sh) tool to generate the file. The `max_iob` variable represents an upper limit to how much insulin on board (iob) oref0 will be allowed to add by enacting increases in temporary basal rates over a period of time. In the example above, `max_iob` equals 2 units of insulin.  

Make sure you test invoking each of these reports as you set them up, and review the corresponding JSON files using `cat`. Once you have a report for every argument required by `get-profile`, you can add a `profile` report:

```
$ openaps report add settings/profile.json text get-profile shell settings/settings.json settings/bg_targets.json settings/insulin_sensitivities.json settings/basal_profile.json max_iob.json
```

At this point, it's natural to think about an alias that generates all the reports required for `get-profile`, then invokes the report that calls `get-profile` on them, for example: 

```
$ openaps alias add gather-profile "report invoke settings/settings.json settings/bg_targets.json settings/insulin_sensitivities.json settings/basal_profile.json settings/profile.json"
```

Remember, what you name things is not important - but remembering WHAT you name each thing and using it consistently throughout is key to saving you a lot of debugging time.  Also, note that the name of your report and the name of the corresponding file created by the report are the same. For example, you invoke a report called "settings/settings.json" and the results are stored in "settings/settings.json".  Until you invoke a report, the corresponding file is not created. 

## The calculate-iob process

This process uses pump history and the result of `get-profile` to calculate IOB. The IOB is calculated based on normal boluses and basal rates over past several hours. At this time, extended boluses are not taken into account. The `get-profile` arguments, and suggested reports are as follows:

* `pumphistory` stores pump history in a JSON file

  ```
  $ openaps report add monitor/pumphistory.json JSON pump iter_pump_hours 4
  ```

In this example, the pump history is obtained from the pump over a period of 4 hours. Normally, you would want openaps to operate based on the pump history over the number of hours equal to what you assume is your active insulin time.

* `profile`: report for `get-profile`

* `clock` outputs the current time stamp from the pump

  ```
  $ openaps report add monitor/clock.json JSON pump read_clock
  ```

As above, you can now add a report for the `calculate-iob` process:

```
$ openaps report add monitor/iob.json JSON calculate-iob shell monitor/pumphistory.json settings/profile.json monitor/clock.json
```

As always, it is a good idea to carefully test and examine the generated reports.

## The determine-basal process

This process uses the IOB computed by `calculate-iob`, the current temp basal state, CGM history, and the profile to determine what (if any) temp basal to recommend. Its arguments, and suggested reports can be setup as follow:

* `iob`: your report for `calculate-iob`

* `temp_basal` reads from pump and outputs the current temp basal state:

  ```
  $ openaps report add monitor/temp_basal.json JSON pump read_temp_basal
  ```

* `glucose` reads from CGM and stores last several bg values:

  ```
  $ openaps report add monitor/glucose.json JSON cgm iter_glucose 5
  ```

In this example, `glucose.json` contains a total of 5 most recent bg values. 

* `profile`: your report for `get-profile`

Finally, a report for `determine-basal` may look like this:

```
$ openaps report add enact/suggested.json text determine-basal shell monitor/iob.json monitor/temp_basal.json monitor/glucose.json settings/profile.json
```

## Adding aliases

You may want to add a `monitor-pump` alias to group all the pump-related reports, which should generally be obtained before `calculate-iob` and `determine-basal`:

```
$ openaps alias add monitor-pump "report invoke monitor/clock.json monitor/temp_basal.json monitor/pumphistory.json monitor/iob.json"
```

For consistency, you may also want to add a `monitor-cgm` alias. Even though it's invoking only a single report, keeping this consistent with the `monitor-pump` alias makes the system easier to reason about.

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

to list all the reports and all the aliases you've set up, respectively. You'll want to ensure that you've set up a report for every argument for every process in the oref0 algorithm, and *more importantly*, that you understand what each report and process does. This is an excellent opportunity to make some `openaps report invoke` calls and to `cat` the report files, in order to gain better familiarity with each input and output of the system.

You can also test the full sequence of aliases and the reports which depend on them:

```
$ rm settings/* monitor/* enact/*
$ openaps gather-profile
$ openaps monitor-pump
$ openaps monitor-cgm
$ openaps report invoke monitor/iob.json
$ openaps report invoke enact/suggested.json
```

It is particularly important to examine `suggested.json`, which is the output of the `determine-basal` process, i.e. the output of the calculation performed to determine what temp basal rate, if any, should be enacted, i.e. sent to the pump. Lets take a look at some typical `suggested.json` examples:

```
{"temp": "absolute","bg": 89,"tick": -7,"eventualBG": -56,"snoozeBG": 76,"reason": "Eventual BG -56<100, no temp, setting -0.435U/hr","duration": 30,"rate": 0}
```

In this example, the current temporary basal rate type is "absolute", which should always be the case. The current bg values is 89, dropped from 96 by the "tick" value of -7. The "eventualBG" and "snoozeBG" are internal variables projecting ultimate bg values based on the current value of IOB (with or without IOB due to boluses), average change in bg, and your insulin sensitivity. The "reason" indicates why a recommendation is made. In the example shown, "eventualBG" is less than the target bg (100), no temp rate is currently set, and the temp rate required to bring the eventual bg to target is -0.435U/hr. Unfortunately, we do not have glucagon available, and the pump is unable to implement a negative temporary basal rate. The system recommends the best it can: set the "rate" to 0 for a "duration" of 30 minutes. Lets take a look at another example of `suggested.json`:

```
{"temp": "absolute","bg": 91,"tick": "+6","eventualBG": -2,"snoozeBG": 65,"reason": "Eventual BG -2<100, but Delta +6 > Exp. Delta -2.3;cancel","duration": 0,"rate": 0
}
```

In this case, the evenatual bg is less than the target, but the bg is increasing (e.g. due to a recent meal). The actual "tick" or "Delta" is larger than the change that would be expected based on IOB and insulin sensitivity. The system therefore recommends canceling the temp basal rate, which is in general done by setting "duration" to 0. Finally, consider this example:

```
{"temp": "absolute","bg": 95,"tick": "+4","eventualBG": 13,"snoozeBG": 67,"reason": "Eventual BG 13<90, but Avg. Delta 4.00 > Exp. Delta -2.9; no temp to cancel"}
```

which is similar to the previous example except, in this case there is no temp basal rate to cancel. To gain better understanding of the system operation, you may look through the report files and try to correlate the outputs with the current situation. 

## Enacting the suggested action

Based on `suggested.json`, which is the output of the `determine-basal` process, the next step is to enact the suggested action, i.e. to send a new temp rate to the pump, if necessary.To setup an `enacted.json` report, one may first try the following: 

```
$openaps report add enact/enacted.json JSON mypump set_temp_basal suggested.json
```

together with a simple `enact` alias: 

```
$openaps alias add try-to-enact "report invoke enact/enacted.json"
```

By experimenting with generating `suggested.json`and then running `$openaps try-to-enact` you would find that enacting the suggestion works only in the cases when a new basal rate is suggested. Otherwise, the `set_temp_basal` command to the pump is missing the requred values and throws an error. A check must be added to make sure a new temp basal is recomemnded before trying to set one on the pump. Looking at the `suggested.json` examples above, one may note that the word "duration" is present in `suggested.json` if a new temp basal rate is suggested. Otherwise, no action is required and the `enact/enacted.json` report should not be invoked. To check for the presence of "duration", one my use `grep`, a standard command-line utility for searching text for patterns, for example as follows:

```
openaps alias add enact '! bash -c "openaps report invoke enact/suggested.json && grep -q duration enact/suggested.json && (openaps report invoke enact/enacted.json && cat enact/enacted.json ) || echo No action required"'
```

This example shows how an alias can be constructed using shell commands (bash in this case), including conditional commands executed upon status of a prior command. First `enact/suggested.json` is invoked. Next, grep is used to search for "duration" in `suggested.json` file. If a match is found, `enact/enacted.json` is invoked. Otherwise, `echo` displays that no action is required. This example also shows how aliases can be used to produce extra diagnostic output (the cat commands), and how commands can be chained together with the bash && ("and") or || ("or") operators to execute different subsequent commands depending on the output code (interpreted as "true" or "false") of a previous command.

You may now experiment by running the required sequence of reports and by executing the `enact` alias using `$openaps enact`. Soon it becomes clear that it would be conventient to put all required reports into a single alias. 

## Adding error checking

Before moving on to consolidating all of these capabilities into a single alias, you'll also want to add some error checking to ensure that your openaps implementation can't act on stale data. This can be done, for example, by deleting all of the data in the `monitor` directory each time it's refreshed, so that if a refresh fails, the data required for subsequent commands will be missing, and they will fail to run. You may add an alias that runs required bash commands, e.g., 

```
openaps alias add gather '! bash -c "rm monitor/*; openaps monitor-cgm && openaps monitor-pump && openaps get-settings"'
```

A similar approach can be used to both remove any old `suggested.json` output before generating a new one, and to check and make sure oref0 is recommending a temp basal before trying to set one on the pump. The `enact` alias can be updated as follows: 

```
openaps alias add enact '! bash -c "rm enact/suggested.json; openaps report invoke enact/suggested.json && grep -q duration enact/suggested.json && (openaps report invoke enact/enacted.json && cat enact/enacted.json) || echo No action required"'
```

It's also worthwhile to do a "preflight" check that verifies a pump is in communication range before trying anything else. This can be done using something like openaps report add model.json JSON pump model, and then can be combined with some error checking from the oref0 mm-stick tool to do some error checking if the model query fails: openaps alias add preflight '! bash -c "rm -f model.json && openaps report invoke model.json && test -n $(json -f model.json) && echo \"PREFLIGHT OK\" || ( mm-stick warmup fail \"NO PUMP MODEL RESPONDED\" || mm-stick fail \"NO MEDTRONIC CARELINK STICK AVAILABLE\")"' 
