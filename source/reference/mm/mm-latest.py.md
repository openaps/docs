# `mm-latest.py`

## Help
usage: mm-latest.py [-h] [--serial SERIAL] [--port PORT] [--no-op]
                    [--skip-prelude] [--no-rf-prelude] [--skip-postlude] [-v]
                    [--rf-minutes SESSION_LIFE] [--auto-init] [--init]
                    [--no-clock] [--no-basal] [--no-temp] [--no-reservoir]
                    [--no-status] [--parser-out PARSED_DATA]
                    [--rtc-out RTC_ARCHIVE]
                    [--reservoir-out RESERVOIR_ARCHIVE]
                    [--settings-out SETTINGS]
                    [--temp-basal-status-out TEMPBASAL] [--basals-out BASALS]
                    [--status-out STATUS] [--timezone TIMEZONE]
                    [minutes]

mm-latest.py - Grab latest activity

positional arguments:
  minutes               [default: 30)]

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
  --no-clock            Also report current time on pump.
  --no-basal            Also report basal rates.
  --no-temp             Also report temp basal rates.
  --no-reservoir        Also report remaining insulin in reservoir.
  --no-status           Also report current suspend/bolus status.
  --parser-out PARSED_DATA
                        Put history json in this file
  --rtc-out RTC_ARCHIVE
                        Put clock json in this file
  --reservoir-out RESERVOIR_ARCHIVE
                        Put reservoir json in this file
  --settings-out SETTINGS
                        Put settings json in this file
  --temp-basal-status-out TEMPBASAL
                        Put temp basal status json in this file
  --basals-out BASALS   Put basal schedules json in this file
  --status-out STATUS   Put status json in this file
  --timezone TIMEZONE   Timezone to use

Query pump for latest activity.
