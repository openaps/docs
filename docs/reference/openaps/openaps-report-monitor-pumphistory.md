#### `monitor/pumphistory.json`
This report gathers the last 5 hours of history directly from your pump.
##### Setup code
`openaps report add monitor/pumphistory.json JSON pump iter_pump_hours 5`
##### Sample contents
```
[
  {
    "_type": "TempBasalDuration",.
    "duration (min)": 30,.
    "_description": "TempBasalDuration 2016-05-23T22:15:28 head[2], body[0] op[0x16]",.
    "timestamp": "2016-05-23T22:15:28",.
    "_body": "",.
    "_head": "1601",.
    "_date": "5c4f165710"
  },
]
```
##### Dependencies
* [`pump.ini`](./openaps-device-pump.md)
