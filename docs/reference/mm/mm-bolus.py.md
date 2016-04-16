# `mm-bolus.py`

## Help
usage: mm-bolus.py [-h] [--serial SERIAL] [--port PORT] [--no-op]
                   [--skip-prelude] [--no-rf-prelude] [--skip-postlude] [-v]
                   [--rf-minutes SESSION_LIFE] [--auto-init] [--init]
                   (--515 | --554 | --strokes STROKES_PER_UNIT)
                   units

mm-bolus.py - Send bolus command to a pump.

positional arguments:
  units                 Amount of insulin to bolus.

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
  --515
  --554
  --strokes STROKES_PER_UNIT

XXX: Be careful please! Units might be wrong. Keep disconnected from pump
until you trust it by observing the right amount first.
