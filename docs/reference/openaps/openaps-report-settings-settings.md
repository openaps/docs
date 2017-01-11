#### `settings/settings.json`
This report contains various settings specific to your pump.
##### Setup code
`openaps report add settings/settings.json JSON pump read_settings`
##### Sample contents
```
{
  "low_reservoir_warn_point": 20,
  "keypad_lock_status": 0,
  "maxBasal": 6.0,
  "temp_basal": {
    "percent": 100,
    "type": "Units/hour"
  },
  "low_reservoir_warn_type": 0,
  "insulinConcentration": 100,
  "audio_bolus_enable": true,
  "variable_bolus_enable": true,
  "alarm": {
    "volume": 2,
    "mode": 2
  },
  "rf_enable": false,
  "auto_off_duration_hrs": 24,
  "block_enable": false,
  "timeformat": 0,
  "insulin_action_curve": 4,
  "audio_bolus_size": 1.0,
  "selected_pattern": 0,
  "patterns_enabled": true,
  "maxBolus": 25.0,
  "paradigm_enabled": 1
}
```
##### Dependencies
* [`pump.ini`](./openaps-device-pump.md)
