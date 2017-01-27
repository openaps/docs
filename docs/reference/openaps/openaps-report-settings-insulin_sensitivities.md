#### `settings/insulin_sensitivities.json`
This report contains the insulin sensitivity levels stored in your pump.
##### Setup code
`openaps report add settings/insulin_sensitivities.json JSON pump read_insulin_sensitivities`
##### Sample contents
```
{
  "units": "mg/dL",
  "sensitivities": [
    {
      "i": 0,
      "start": "00:00:00",
      "sensitivity": 20,
      "offset": 0,
      "x": 0
    }
  ],
  "first": 1
}
```
##### Dependencies
* [`pump.ini`](./openaps-device-pump.md)
