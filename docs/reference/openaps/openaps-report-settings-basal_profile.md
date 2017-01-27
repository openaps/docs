#### `settings/basal_profile.json`
This report contains the basal rates that are set up in your pump.
##### Setup code
`openaps report add settings/basal_profile.json JSON pump read_selected_basal_profile`
##### Sample contents
```
[
  {
    "i": 0,
    "start": "00:00:00",
    "rate": 1.8,
    "minutes": 0
  },
  {
    "i": 1,
    "start": "05:00:00",
    "rate": 2.2,
    "minutes": 300
  },
  {
    "i": 2,
    "start": "08:00:00",
    "rate": 1.8,
    "minutes": 480
  }
]
```
##### Dependencies
* [`pump.ini`](./openaps-device-pump.md)
