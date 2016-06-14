# `mm-press-key.py`

## Help
usage: mm-press-key.py [-h] [--serial SERIAL] [--port PORT] [--no-op]
                       [--skip-prelude] [--no-rf-prelude] [--skip-postlude]
                       [-v] [--rf-minutes SESSION_LIFE] [--auto-init] [--init]
                       {act,esc,up,down,easy} [{act,esc,up,down,easy} ...]

mm-press-key.py - Simulate presses on the keypad.

positional arguments:
  {act,esc,up,down,easy}
                        buttons to press [default: None)]

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

Press keys on the keypad.
