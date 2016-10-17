#### `monitor/iob.json`
This report contains several entries detailing the levels of IOB (Insulin On Board) over a given time period.
##### Setup code
`openaps report add monitor/iob.json text iob shell monitor/pumphistory-zoned.json settings/profile.json monitor/clock-zoned.json`
##### Sample contents
```
[
  {
    "iob": 1.908,
    "activity": 0.0009,
    "bolussnooze": 0,
    "basaliob": 1.908,
    "netbasalinsulin": 1.1,
    "hightempinsulin": 3.2,
    "time": "2016-05-22T04:43:33.000Z"
  },
]
```
##### Dependencies
* [`monitor/pumphistory-zoned.json`](./openaps-report-monitor-pumphistory-zoned.md)
* [`settings/profile.json`](./openaps-report-settings-profile.md)
* [`monitor/clock-zoned.json`](./openaps-report-monitor-clock-zoned.md)
