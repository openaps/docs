#### `pump.ini`
This device contains the information requied to connect to your pump, such as your pump's serial number.  This example assumes you are using a TI stick.
##### Setup code
`openaps device add pump mmeowlink subg_rfspy /dev/mmeowlink [YOUR PUMP SERIAL]`
##### Sample contents
```
[device "pump"]
serial = [YOUR PUMP SERIAL]
port = /dev/mmeowlink
radio_type = subg_rfspy
model = [YOUR PUMP MODEL]
expires = 2016-05-23T23:02:36.168762
```
##### Dependencies
None
