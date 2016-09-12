## Configuring Automatic Sensitivity and Meal Assist Mode

For more information review https://github.com/openaps/oref0/issues/58

1)	Install the latest dev branch of `oref0`:
```
sudo npm install -g git://github.com/openaps/oref0.git'#dev'
```

2)	Next in order for the new auto-sensitivity report to run, you need to have at least 24 hours worth of pump history data and enough bg readings (24 hours).
In your `openaps.ini` apply the following changes:
```
[report "monitor/glucose.json"]
device = cgm
use = iter_glucose
reporter = JSON
count = 288
```

(NOTE: if using Nightscout, add `count=288` to your `entries.json` API call as a querystring parameter)

One way to do this is to go to your openaps directory and edit the `ns-glucose.ini` file.  Depending on how you've implemented it, it should look something like this (please note the `?count=288`):
```
[device "curl"]
fields =
cmd = bash
vendor = openaps.vendors.process
args = -c "curl -s https://[Your URL]/api/v1/entries.json?count=288 | json -e 'this.glucose = this.sgv'"
```
If your `glucose.json` does not have enough entries you will see a warning when running your `auto-sens.json` report:
```
Error: not enough glucose data to calculate autosens.
```

3)	After applying the above change you need to add a new `auto-sens` device and an `auto-sens` report.  Run this command to create the `auto-sens` report:

`openaps device add auto-sens process --require "glucose pumphistory insulin_sensitivities basal_profile profile" oref0 detect-sensitivity`

If the command executed properly, the contents of `openaps.ini` should contain:
```
[device "auto-sens"]
vendor = openaps.vendors.process
extra = auto-sens.ini
```
Another new file named `auto-sens.ini` should have been created, and it should contain:
```
[device "auto-sens"]
fields = glucose pumphistory insulin_sensitivities basal_profile profile
cmd = oref0
args = detect-sensitivity
```

4) In order for `auto-sens` to run properly, you need to make sure you pull enough history from your pump - 24 hours plus however many yours you have set for your DIA.  To do this, you will create a new report called `pumphistory-24h.json`:
```
openaps report add settings/pumphistory-24h.json JSON pump iter_pump_hours 28
```
(NOTE: the `28` assumes a 4h DIA - please adjust accordingly if your DIA is longer.)

5) Once the device is created, we need to create the `auto-sens.json` report.  Run this command to create the `auto-sens.json` report:
```
openaps report add settings/auto-sens.json text auto-sens shell monitor/glucose.json settings/pumphistory-24h.json settings/insulin_sensitivities.json settings/basal_profile.json settings/profile.json
```
Now invoke the report to test:
```
openaps report invoke settings/auto-sens.json
```

6) Next we need to add the `auto-sens.json` report to the `oref0-determine-basal` device.  In `openaps.ini` make sure your `oref0-determine-basal` looks similar to this:
```
[device "oref0-determine-basal"]
fields = iob current-temps glucose profile **auto-sens** meal
cmd = oref0-determine-basal
vendor = openaps.vendors.process
args =
```
(NOTE: in the `fields` above, `meal` should only be present if meal assist is configured)

7) At this point, in the process you should already have an `enact/suggested.json` report.  Edit your `openaps.ini` file and add the bottom line to that report:
```
[report "enact/suggested.json"]
profile = settings/profile.json
use = shell
reporter = text
current-temps = monitor/temp-basal-status.json
device = oref0-determine-basal
iob = monitor/iob.json
glucose = monitor/glucose.json
meal = monitor/meal.json
auto-sens = settings/auto-sens.json
```
(NOTE: as stated above, if you do not have meal assist enabled, do not include the `meal` line)

8)  Based on the configuration of the basic loop, it is recommended that the `settings/auto-sens.json` be added to the `get-profile` alias:
```
get-profile report invoke settings/settings.json settings/bg_targets.json settings/insulin_sensitivities.json settings/basal_profile.json settings/profile.json settings/auto-sens.json
```
and that the `gather` alias be adjusted to make sure `get-profile` is at the end. This is because the `settings/auto-sens.json` report depends upon elements from the preceding two aliases to run.

`gather ! bash -c "rm -f monitor/*; openaps monitor-cgm && openaps monitor-pump && openaps get-profile"`

Note. Your loop should run without `auto-sens.json` report but if you don't pass that as an input you will see the following message while executing `oref0-determine-basal.js`:
```
Optional feature Auto Sensitivity not enabled:  { [Error: ENOENT: no such file or directory, open 'online'] errno: -2, code: 'ENOENT', syscall: 'open', path: 'online' }
```
Here is an example of running the loop with Auto Sensitivity feature enabled:
```
reporting oref0-prepare/mm-normalized.json
...............................................................................................................................................................................................................................................................................................
p=0.51: -0.33, -0.33, 0.22
p=0.50: -0.33, -0.33, 0.13
p=0.49: -0.67, -0.36, -0.03
p=0.48: -0.67, -0.39, -0.11
p=0.47: -0.67, -0.46, -0.24
p=0.46: -0.67, -0.50, -0.38
p=0.45: -1.00, -0.54, -0.42
p=0.44: -1.24, -0.57, -0.47
p=0.43: -1.33, -0.58, -0.63
p=0.42: -1.49, -0.60, -0.67
p=0.41: -1.67, -0.62, -0.78
p=0.40: -1.67, -0.65, -0.88
p=0.39: -1.67, -0.66, -0.95
p=0.38: -2.00, -0.67, -1.12
p=0.37: -2.00, -0.68, -1.57
p=0.36: -2.00, -0.69, -1.67
p=0.35: -2.33, -0.69, -1.73
p=0.34: -2.33, -0.70, -1.89
p=0.33: -2.43, -0.74, -2.03
p=0.32: -2.67, -0.76, -2.16
p=0.31: -3.00, -0.77, -2.36
p=0.30: -3.00, -0.82, -2.55
Mean deviation: 0.76
Sensitivity within normal ranges
Basal adjustment 0.00U/hr
Ratio: 100%: new ISF: 42.0mg/dL/U
{"carbs":0,"boluses":0,"mealCOB":10}
{"ratio":1}
{"delta":-4,"glucose":129,"avgdelta":-6}
{"duration":17,"rate":1.125,"temp":"absolute"}
{"iob":0.089,"activity":0.0119,"bolussnooze":0,"basaliob":0.089,"netbasalinsulin":1.4,"hightempinsulin":1.8}
{"max_iob":3,"type":"current","dia":3,"current_basal":1.15,"max_daily_basal":1.15,"max_basal":3,"min_bg":100,"max_bg":120,"sens":42,"carb_ratio":10}
oref0-get-profile://text/shell/oref0-predict/profile.json
reporting oref0-predict/profile.json
oref0-calculate-iob://text/shell/oref0-predict/iob.json
reporting oref0-predict/iob.json
auto-sens://text/shell/oref0-monitor/auto-sens.json
reporting oref0-monitor/auto-sens.json
oref0-determine-basal://text/shell/oref0-predict/oref0.json
reporting oref0-predict/oref0.json
{
"temp": "absolute",
"bg": 129,
"tick": -4,
"eventualBG": 104,
"snoozeBG": 104,
"mealAssist": "Off: Carbs: 0 Boluses: 0 Target: 110 Deviation: -21 BGI: -2.5",
"reason": "Eventual BG 104>100 but Avg. Delta -6.00 < Exp. Delta -2.3, temp 1.125 ~ req 1.15U/hr"
}
No recommendation to send
```
