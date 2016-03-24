# `mm-set-rtc.py`

## Help
usage: mm-set-rtc.py [-h] [--serial SERIAL] [--port PORT] [--no-op]
                     [--skip-prelude] [--no-rf-prelude] [--skip-postlude] [-v]
                     [--rf-minutes SESSION_LIFE] [--auto-init] [--init]
                     [--rtc-out RTC_ARCHIVE] [--timezone TIMEZONE] --set SET
                     [--out OUT]
                     {query,set}

mm-set-rtc.py - query or set RTC

positional arguments:
  {query,set}           Set or query pump status [default: query)]

optional arguments:
  -h, --help            show this help message and exit
  --serial SERIAL       serial number of pump [default: ]
  --port PORT           Path to device [default: scan]
  --no-op               Dry run, don't do main function
  --skip-prelude        Don't do the normal prelude.
  --no-rf-prelude       Do the prelude, but don't query the pump.
  --skip-postlude       Don't do the normal postlude.
  -v, --verbose         Verbosity
  --rf-minutes SESSION_LIFE
                        How long RF sessions should last
  --auto-init           Send power ctrl to initialize RF session.
  --init                Send power ctrl to initialize RF session.
  --rtc-out RTC_ARCHIVE
                        Put clock json in this file
  --timezone TIMEZONE   Timezone to use
  --set SET             Set clock to new value (iso8601)
  --out OUT             Put basal in this file

Set or query RTC.
