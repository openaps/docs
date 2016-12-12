#### `monitor/clock.json`
This report contains the date and time that is set on your pump, but does **NOT** include timezone information.
##### Setup code
`openaps report add monitor/clock.json JSON pump read_clock`
##### Sample contents
`"2016-05-22T00:18:41"`
##### Dependencies
* [`pump.ini`](./openaps-device-pump.md)
