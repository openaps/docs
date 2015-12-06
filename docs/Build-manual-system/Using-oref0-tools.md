#Using oref0 Tools

## Add the oref0 Virtual Devices
In Phase 1, you added two physical medical devices to openaps—your pump and your cgm. This was done using the command `$ openaps device add` and then specifying the device name, type, and parameters. Since their is no physical oref0 device, you are essentially adding it to the openaps environment as a virtual device or plugin.

You can add a catch-all oref0 device using

`$ openaps device add oref0 process oref0`

and then you can be more specific and add individual oref0 processes as devices using commands like

```
$ openaps device add get-profile process --require "settings bg_targets isf basal_profile max_iob" oref0 get-profile
$ openaps device add calculate-iob process --require "pumphistory profile clock" oref0 calculate-iob
$ openaps device add determine-basal process --require "iob temp_basal glucose profile" oref0 determine-basal
```

In that syntax, the `--require` specifies which arguments are required in order to successfully run each command.

Hopefully, from your experimentation with `openaps` tools earlier, most of the arguments to the oref0 processes are familiar to you. Now it's time to formalize them all into reports which the processes can use as input, and reports which call the oref0 processes themselves.

## Organizing the reports

It may make sense to group your reports into `settings`, `monitor`, and `enact` directories. The `settings` directory holds reports you don't need to refresh as frequently as those in `monitor` (e.g. BG targets and basal profile, vs. pump history and calculated IOB). The `enact` directory makes it explicit that it contains recommendations ready to be reviewed or sent to the pump.
```
$ mkdir -p settings monitor enact
```

## The get-profile process

The purpose of the `get-profile` process is to consolidate information from multiple settings reports into a single JSON file. This makes it easier to pass the relevant settings information to subsequent steps. Let's look at what kind of report you might set up for each of its arguments:

* `settings`
  ```
  $ openaps report add settings/settings.json JSON pump read_settings
  ```

* `bg_targets`
  ```
  $ openaps report add settings/bg_targets.json JSON pump read_bg_targets
  ```

* `isf`
  ```
  $ openaps report add settings/insulin_sensitivities.json JSON pump read_insulin_sensitivies
  ```

* `basal_profile`
  ```
  $ openaps report add settings/basal_profile.json JSON pump read_basal_profile_std
  ```

* `max_iob`: This one's a trick: it's not the result of a report. It's a JSON file that looks like `{"max_iob": 0}`. You can create it by hand, or use the [oref0-mint-max-iob.sh](https://github.com/openaps/oref0/blob/master/bin/oref0-mint-max-iob.sh) tool to generate it.

Make sure you test invoking each of these reports as you set them up. Once you have a report for every argument, you can add a report which uses them all as input for `get-profile`:

```
$ openaps report add settings/profile.json text get-profile shell settings/settings.json settings/bg_targets.json settings/insulin_sensitivities.json settings/basal_profile.json max_iob.json
```

At this point, it's natural to think about an alias which generates all the reports which you'll need for `get-profile`, then invokes the report which calls `get-profile` on them. This might look like:

```
$ openaps alias add gather-profile "report invoke settings/settings.json settings/bg_targets.json settings/insulin_sensitivities.json settings/basal_profile.json settings/profile.json"
```

Remember, what you name things is not important - but remembering WHAT you name each thing and using it consistently throughout is key to saving you a lot of debugging time.  Also, your reports where your reports are stored and named are the same thing; so you invoke a report called "settings/settings.json" and the results are stored at "settings/settings.json".  Until you invoke a report you have added, it will not be created.  You also need to make sure to create those subdirectories of settings, monitor, and enact if you are going to use the model laid out in this documentation.

## The calculate-iob process

This process uses pump history and the result of `get-profile` to calculate IOB. Its arguments, and suggested reports:

* `pumphistory`
  ```
  $ openaps report add monitor/pumphistory.json JSON pump iter_pump_hours 4
  ```

* `profile`: your report for `get-profile`

* `clock`
  ```
  $ openaps report add monitor/clock.json JSON pump read_clock
  ```

As above, you can now add a report for the `calculate-iob` process:

```
$ openaps report add monitor/iob.json JSON calculate-iob shell monitor/pumphistory.json settings/profile.json monitor/clock.json
```

## The determine-basal process

This process uses the IOB computed by `calculate-iob`, the current temp basal state, CGM history, and the profile to determine what (if any) temp basal to recommend. Its arguments, and suggested reports:

* `iob`: your report for `calculate-iob`

* `temp_basal`
  ```
  $ openaps report add monitor/temp_basal.json JSON pump read_temp_basal
  ```

* `glucose`
  ```
  $ openaps report add monitor/glucose.json JSON cgm iter_glucose 5
  ```

* `profile`: your report for `get-profile`

So a report for `determine-basal` might look like:

```
$ openaps report add enact/suggested.json text determine-basal shell monitor/iob.json monitor/temp_basal.json monitor/glucose.json settings/profile.json
```

## Adding aliases

You may want to add a `monitor-pump` alias to group all the pump-related reports which will generally be run together before `calculate-iob` and `determine-basal`:

```
$ openaps alias add monitor-pump "report invoke monitor/clock.json monitor/temp_basal.json monitor/pumphistory.json monitor/iob.json"
```

You may also want to add a `monitor-cgm` alias. Even though it's invoking only a single report, keeping this consistent with the `monitor-pump` alias makes the system easier to reason about.
```
$ openaps alias add monitor-cgm "report invoke monitor/glucose.json"
```

## Checking your reports

At this point you can call
```
$ openaps report show
```
to list all the reports you've set up. You'll want to ensure that you've set up a report for every argument for every process in the oref0 algorithm, and *more importantly*, that you understand what each report and process does. This is an excellent opportunity to make some `openaps report invoke` calls to build your familiarity with each input and output of the system.

You can also test the full sequence of aliases and the reports which depend on them:
```
$ rm settings/* monitor/* enact/*
$ openaps gather-profile
$ openaps monitor-pump
$ openaps monitor-cgm
$ openaps report invoke monitor/iob.json
$ openaps report invoke enact/suggested.json
```

## Adding error checking

Before moving on to consolidating all of these capabilities into a single alias, you'll also want to add some error checking to ensure that your openaps implementation can't act on stale data. This can be done by deleting all of the data in the monitor directory each time it's refreshed, so that if a refresh fails, the data required for subsequent commands will be missing, and they will fail to run. This can be done by adding an alias that runs arbitrary bash commands, in this case something like `openaps alias add gather '! bash -c "rm monitor/*; openaps monitor-cgm && openaps monitor-pump && openaps get-settings"'`. A similar approach can be used to both remove any old suggested.json output before generating a new one, and to check and make sure oref0 is recommending a temp basal before trying to set one on the pump. For example: `openaps alias add enact '! bash -c "rm enact/suggested.json; openaps report invoke enact/suggested.json && cat enact/suggested.json && grep -q duration enact/suggested.json && ( openaps report invoke enact/enacted.json && cat enact/enacted.json ) || echo No action required"'`. That command also shows how aliases can be used to produce extra diagnostic output (the cat comands), and how commands can be chained together with the bash && ("and") or || ("or") operators to execute different subsequent commands depending on the output code (interpreted as "true" or "false") of a previous command.

It's also worthwhile to do a "preflight" check that verifies a pump is in communication range before trying everything else. This can be done using something like openaps report add model.json JSON pump model, and then can be combined with some error checking from the oref0 mm-stick tool to do some error checking if the model query fails: openaps alias add preflight '! bash -c "rm -f model.json && openaps report invoke model.json && test -n $(json -f model.json) && echo \"PREFLIGHT OK\" || ( mm-stick warmup fail \"NO PUMP MODEL RESPONDED\" || mm-stick fail \"NO MEDTRONIC CARELINK STICK AVAILABLE\")"' 
