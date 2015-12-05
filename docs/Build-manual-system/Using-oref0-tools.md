#Using oref0 Tools

## Add the oref0 Virtual Devices 
In Phase 1, you added two physical medical devices to openaps—your pump and your cgm. This was done using the command `$ openaps device add` and then specifying the device name, type, and parameters. Since their is no physical oref0 device, you are essentially adding it to the openaps environment as a virtual device or plugin.

You can add a catch-all oref0 device using

`$ openaps device add oref0 process oref0`

and then you can be more specific and add individual oref0 processes as devices using commands like

```
$ openaps device add iob process --require "pumphistory profile clock" oref0 calculate-iob
$ openaps device add get-profile process --require "settings bg_targets isf basal_profile max_iob" oref0 get-profile
$ openaps device add determine-basal process --require "iob temp_basal glucose profile" oref0 determine-basal
```

In that syntax, the `--require` specifies which arguments are required in order to successfully run each command.

##Adding reports

Once you have devices added, you can start adding reports that correspond to various openaps use commands you'll want to run regularly, such as `cgm iter_glucose`, `pump read_temp_basal`, `pump iter_pump_hours`, etc. You might categorize reports into "monitor" and "settings" directories, in case you want to be able to refresh the former more frequently than the latter (which hasn't been necessary so far with oref0, as openaps is now fast enough to collect all the data and enact a new temp basal in less than a minute). If you use that for naming, and stick with the use names for your filenames (except for the iter_* uses, which describe how the data is being collected more than what it is), you'll end up with commands like `openaps report add monitor/glucose.json JSON cgm iter_glucose_5` (retrieves the last 5 CGM data points), `openaps report add monitor/temp_basal.json JSON pump read_temp_basal`, and `openaps report add monitor/pumphistory.json JSON pump iter_pump_hours 4` to add the monitor reports, and commands like `openaps report add settings/bg_targets.json JSON pump read_bg_targets` for the various settings.

Remember, what you name things is not important - but remembering WHAT you name each thing and using it consistently throughout is key to saving you a lot of debugging time.

##Consolidating information

In order to avoid passing all the settings data to each subsequent command, oref0 has a get-profile command that consolidates the information we need from them into a single json. This can be added by creating a report using the get-profile device you added earlier, which would look something like `openaps report add settings/profile.json text get-profile shell settings/settings.json settings/bg_targets.json settings/insulin_sensitivities.json settings/basal_profile.json max_iob.json`. (The max_iob.json has to be defined manually: it's not configured on the pump. It's a really simple json file that looks like {"max_iob":0} or similar, or you can use the oref0-mint-max-iob.sh tool.)

Similarly, you can also calculate IOB using the oref0 calculate-iob command (which you defined in the iob device earlier) to update monitor/iob.json based on the updated pump history, profile, and pump clock. That report would look something like openaps report add monitor/iob.json text iob shell monitor/pumphistory.json settings/profile.json monitor/clock.json.

##Adding aliases

Once you create reports for all the use commands you might want, you'll have a lot of reports that really need to be run all at the same time. So you'll probably want to start adding aliases, like `openaps alias add monitor-pump "report invoke monitor/clock.json monitor/temp_basal.json monitor/pumphistory.json monitor/iob.json"` and `openaps alias add get-settings "report invoke settings/bg_targets.json settings/insulin_sensitivities.json settings/basal_profile.json settings/settings.json settings/profile.json"`. You might want to do a monitor-cgm one as well just for consistency (or just add monitor/glucose.json to monitor-pump).

Once you have those aliases defined, you'll be able to very quickly refresh your CGM and pump data and settings with just a couple of commands (`openaps monitor-cgm`, `openaps monitor-pump`, and `openaps get-settings`).

##Calculating needed temporary basal rates

Now you have all the data you need to calculate the temporary basal rate required by the OpenAPS reference design 0 (oref0) algorithm. This can be done by the oref0 determine-basal device, with something like `openaps report add enact/suggested.json text determine-basal shell monitor/iob.json monitor/temp_basal.json monitor/glucose.json settings/profile.json`. Invoking that will generate a suggested.json, which can then be enacted with pump set_temp_basal in a use or report.

##Adding error checking

Before moving on to consolidating all of these capabilities into a single alias, you'll also want to add some error checking to ensure that your openaps implementation can't act on stale data. This can be done by deleting all of the data in the monitor directory each time it's refreshed, so that if a refresh fails, the data required for subsequent commands will be missing, and they will fail to run. This can be done by adding an alias that runs arbitrary bash commands, in this case something like `openaps alias add gather '! bash -c "rm monitor/*; openaps monitor-cgm && openaps monitor-pump && openaps get-settings"'`. A similar approach can be used to both remove any old suggested.json output before generating a new one, and to check and make sure oref0 is recommending a temp basal before trying to set one on the pump. For example: `openaps alias add enact '! bash -c "rm enact/suggested.json; openaps report invoke enact/suggested.json && cat enact/suggested.json && grep -q duration enact/suggested.json && ( openaps report invoke enact/enacted.json && cat enact/enacted.json ) || echo No action required"'`. That command also shows how aliases can be used to produce extra diagnostic output (the cat comands), and how commands can be chained together with the bash && ("and") or || ("or") operators to execute different subsequent commands depending on the output code (interpreted as "true" or "false") of a previous command.

It's also worthwhile to do a "preflight" check that verifies a pump is in communication range before trying everything else. This can be done using something like openaps report add model.json JSON pump model, and then can be combined with some error checking from the oref0 mm-stick tool to do some error checking if the model query fails: openaps alias add preflight '! bash -c "rm -f model.json && openaps report invoke model.json && test -n $(json -f model.json) && echo \"PREFLIGHT OK\" || ( mm-stick warmup fail \"NO PUMP MODEL RESPONDED\" || mm-stick fail \"NO MEDTRONIC CARELINK STICK AVAILABLE\")"' 
