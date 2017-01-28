#### `monitor/pumphistory-zoned.json`
This report is the same as your `pumphistory.json` report, but adjusted for your timezone.
##### Setup code
`openaps use tz rezone --timezone "[YOUR TIMEZONE]" --adjust "missing" --date "timestamp dateString start_at end_at created_at" --astimezone monitor/pumphistory.json`
##### Sample contents
```
[
  {
    "_type": "TempBasalDuration",.
    "_description": "TempBasalDuration 2016-05-23T22:15:28 head[2], body[0] op[0x16]",.
    "timestamp": "2016-05-23T22:15:28-04:00",.
    "_body": "",.
    "_head": "1601",.
    "duration (min)": 30,.
    "_date": "5c4f165710"
  },
]
```
##### Dependencies
* [`monitor/pumphistory.json`](./openaps-report-monitor-pumphistory.md)
