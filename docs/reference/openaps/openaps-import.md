# `openaps-import`

## Help
usage: openaps-import [-h] [--list] [input]

 openaps-import - import openaps configuration
  Import configuration.

positional arguments:
  input       Read from stdin

optional arguments:
  -h, --help  show this help message and exit
  --list, -l  Just list types

Example workflow:

openaps -C /path/to/another/openaps.ini device show --json ns-upload | openaps import -
