# `mm-set-suspend.py`

## Help
usage: mm-set-suspend.py [-h] [--serial SERIAL] [--port PORT] [--no-op]
                         [--skip-prelude] [--no-rf-prelude] [--skip-postlude]
                         [-v] [--rf-minutes SESSION_LIFE] [--auto-init]
                         [--init]
                         {query,suspend,resume} [{query,suspend,resume} ...]

mm-set-suspend.py - query or set suspend/resume status

positional arguments:
  {query,suspend,resume}
                        Set or query pump status [default: query)]

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

Pause or resume pump.
