#### `monitor/battery.json`
This report contains the current status and voltage of the battery in your pump.
##### Setup code
`openaps report add monitor/battery.json JSON pump read_battery_status`
##### Sample contents
```
{
  "status": "normal",
  "voltage": 1.56
}
```
##### Dependencies
None
