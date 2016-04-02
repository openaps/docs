# `openaps-enact`

## Help
usage: openaps-enact [-h] [--version]
                     [{temp-basal,bolus,phone,sms,pipe}]
                     [{simulator,static-file,medtronic,dexcom}] ...

  Send changes out into the world.

positional arguments:
  {temp-basal,bolus,phone,sms,pipe}
  {simulator,static-file,medtronic,dexcom}
  args

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

Make a phone call, send SMS/TEXT, send messages to devices and people.
