#### `settings/profile.json`
This report contains a general profile of the information in your pump such as carb ratios, DIA, max basal rates, etc.
##### Setup code
`openaps report add settings/profile.json text get-profile shell settings/settings.json settings/bg_targets.json settings/insulin_sensitivities.json settings/basal_profile.json preferences.json`
##### Sample contents
```
{
    "max_iob": 0,
    "type": "current",
    "dia": 4,
    "current_basal": 1.8,
    "max_daily_basal": 2.2,
    "max_basal": 6,
    "min_bg": 100,
    "max_bg": 120,
    "sens": 20,
    "carb_ratio": 5
}
```
##### Dependencies
* [`settings/settings.json`](./openaps-report-settings-settings.md)
* [`settings/bg_targets.json`](./openaps-report-settings-bg_targets.md)
* [`settings/insulin_sensitivities.json`](./openaps-report-settings-insulin_sensitivities.md)
* [`settings/basal_profile.json`](./openaps-report-settings-basal_profile.md)
* [`max_iob.json`](./openaps-report-max_iob.md)
