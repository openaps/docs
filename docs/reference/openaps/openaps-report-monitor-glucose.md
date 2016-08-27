#### `monitor/glucose.json`
This report contains multiple glucose entries from either your CGM or Nightscout install.  For simplicity's sake, this document assumes that the data is coming from your directly connected CGM.
##### Setup code
`openaps report add monitor/glucose.json JSON cgm oref0_glucose --hours "25.0" --threshold "100"`
##### Sample contents
```
[
  {
    "trend_arrow": "FLAT",.
    "display_time": "2016-05-22T00:22:27",.
    "direction": "Flat",.
    "system_time": "2016-05-22T07:22:27",.
    "sgv": 149,.
    "dateString": "2016-05-22T00:22:27-04:00",.
    "device": "openaps://cgm",.
    "unfiltered": 159840,.
    "rssi": 180,.
    "date": 1463890947000.0,.
    "filtered": 156928,.
    "type": "sgv",.
    "glucose": 149
  },
]
```
##### Dependencies
* [`cgm.ini`](./openaps-device-cgm.md)
