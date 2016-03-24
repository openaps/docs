# `openaps-report`

## Help
usage: openaps-report [-h] [--version] {add,remove,show,invoke} ...

 openaps-report - configure reports

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

## Reports Menu:
   reports - manage report configurations 

  {add,remove,show,invoke}
                        Operation
    add                 add - add a new report configuration
    remove              remove - remove a device configuration
    show                show - show all reports
    invoke              invoke - generate a report

Manage which devices produce which reports.

Example workflow:

Use the add, remove, show to manage which reports openaps knows about.

  The add command adds a new report to the system.
  The syntax is: add <name> <reporter> <device> <use>

    openaps report add my-results.json json pump basals

    This example registers a json output, using the pump basals command, and
    stores the result in my-results.json.

  The show command will list or give more details about the reports registered with openaps.
  The syntax is: show [name]. The default name is '*' which should list all available reports.

    openaps report show

  The remove command removes the previously configured report from openaps.
  The syntax is: remove <name>

    openaps report remove my-results.json
    This example removes the report "my-results.json" from the openaps
    environment.

  openaps report invoke basals
                 <action> <name>
