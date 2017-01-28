#### `settings/auto-sens.json`
This report contains an automatically determined, temporary modification to your ISF (Insulin Sensitivity Factor).
##### Setup code
`openaps report add settings/auto-sens.json text detect-sensitivity shell monitor/glucose.json settings/pumphistory-24h-zoned.json settings/insulin_sensitivities.json settings/basal_profile.json settings/profile.json`
##### Sample contents
`{"ratio":0.78}`
##### Dependencies
* [`monitor/glucose.json`](./openaps-report-monitor-glucose.md)
* [`settings/pumphistory-24h-zoned.json`](./openaps-report-settings-pumphistory-24h-zoned.md)
* [`settings/insulin_sensitivities.json`](./openaps-report-settings-insulin_sensitivities.md)
* [`settings/basal_profile.json`](./openaps-report-settings-basal_profile.md)
* [`settings/profile.json`](./openaps-report-settings-profile.md)
