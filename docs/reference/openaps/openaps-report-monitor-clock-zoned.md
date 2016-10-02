#### `monitor/clock-zoned.json`
This report contains the date and time that is set on your pump, but modified to include your timezone information.
##### Setup code
`openaps use tz clock --timezone "[YOUR TIMEZONE]" --adjust "missing" --date "None" --astimezone monitor/clock.json`
##### Sample contents
`"2016-05-23T22:40:14-04:00"`
##### Dependencies
* [`monitor/clock.json`](openaps-report-monitor-clock.md)
