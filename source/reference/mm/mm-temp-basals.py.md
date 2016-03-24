# `mm-temp-basals.py`

## Help
usage: mm-temp-basals.py [-h] [--serial SERIAL] [--port PORT] [--no-op]
                         [--skip-prelude] [--no-rf-prelude] [--skip-postlude]
                         [-v] [--rf-minutes SESSION_LIFE] [--auto-init]
                         [--init] [--duration DURATION] [--rate RATE]
                         [--out OUT]
                         {query,set,percent}

mm-temp-basals.py - query or set temp basals

positional arguments:
  {query,set,percent}   Set or query pump status [default: query)]

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
  --duration DURATION   Duration of temp rate [default: 0)]
  --rate RATE           Rate of temp basal [default: 0)]
  --out OUT             Put basal in this file

Set or query temp basals.
