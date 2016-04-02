# `openaps-use`

## Help
usage: openaps-use [-h] [--format {text,json,base,stdout}] [--output OUTPUT]
                   [--version]
                   device ...

 openaps-use - use a registered device

optional arguments:
  -h, --help            show this help message and exit
  --format {text,json,base,stdout}
  --output OUTPUT
  --version             show program's version number and exit

Known Devices Menu:
  These are the devices openaps knows about:    

  device                Name and description:
    black               Medtronic - openaps driver for Medtronic
    blue                Medtronic - openaps driver for Medtronic
    calculate-iob       process - a fake vendor to run arbitrary commands
    cat                 process - a fake vendor to run arbitrary commands
    cgm                 Dexcom - openaps driver for dexcom
    curl                process - a fake vendor to run arbitrary commands
    determine-basal     process - a fake vendor to run arbitrary commands
    dx-format-oref0-glucose
                        process - a fake vendor to run arbitrary commands
    format-latest-nightscout-treatments
                        process - a fake vendor to run arbitrary commands
    get-profile         process - a fake vendor to run arbitrary commands
    howdy               process - a fake vendor to run arbitrary commands
    iob                 process - a fake vendor to run arbitrary commands
    latest-treatments   process - a fake vendor to run arbitrary commands
    mine                process - a fake vendor to run arbitrary commands
    munge               mmhistorytools - tools for cleaning, condensing, and
                        reformatting history data
    my-agp              AGP - calculate agp values given some glucose text
    newone              process - a fake vendor to run arbitrary commands
    ns-glucose          process - a fake vendor to run arbitrary commands
    ns-upload           process - a fake vendor to run arbitrary commands
    oref0               process - a fake vendor to run arbitrary commands
    plugins             Plugins - Community maintained plugins to openaps
    predict             predict - tools for predicting glucose trends
    pump                mmeowlink - openaps driver for cc1111/cc1110 devices
    share               openxshareble - pure python driver to communicate with
                        Dexcom G4+Share over ble. Allows openaps to use ble to
                        talk to Dexcom G4+Share.
    tz                  Timezones - manage timezones in diabetes data with
                        ease.
    units               Units - units tool for openaps

Once a device is registered in openaps.ini, it can be used.
