
# Reports - the value of reproducibility

Reports can automate this by recording the output of any **use** to a
file.  Reports make **uses** **reproducible**.  Let's peek at `openaps
report -h`.

```
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
```



The **use** commands allow us to interact with devices.
This is very useful for exploring and learning about what the devices
can do, but the `openaps use` tool is little unwieldy if we put our
commands in a script.

For example, consider a simple script which saves the output from our
`howdy` device to a file called `howdy.txt`:
```
openaps use --format text howdy shell > howdy.txt
```

Now, if there were any tools that needed to use the output from
`howdy` can retrieve it from the `howdy.txt` file.

What if we take a more complicated example?  Try running these
commands:

```
echo {} | json -e "this.foo = 'first thing'"
echo {} | json -e "this.bar = 'second thing'"
echo {} | json -e "this.baz = 'baz thing'"
```

These three bash commands will `echo` slightly different `json`
objects to the terminal.  Let's create devices for each of these, and
pretend each is some important piece of data, such as glucose data or
pump history, or bg targets.

We'll iterate on the above to implement some fake data for this
tutorial:
```
openaps device add fake-cgm process bash -c '"echo {} | json -e '\''this.cgm_fake=\"fake-cgm\"'\'' "'
openaps device add fake-pump process bash -c '"echo {} | json -e '\''this.pump_fake=\"fake-pump\"'\'' "'
openaps device add fake-oref0 process bash -c '"echo {} | json -e '\''this.oref0_fake=\"fake-oref0\"'\'' "'
```


Let's assume we want to get data from all these devices in order to
run an algorithm on the complete data set.  The algorithm we want to
run needs all the information from all three devices in a file.  Just
to review the uses:


```

Known Devices Menu:
  These are the devices openaps knows about:    

  device                Name and description:
    fake-cgm            process - a fake vendor to run arbitrary commands
    fake-oref0          process - a fake vendor to run arbitrary commands
    fake-pump           process - a fake vendor to run arbitrary commands
    howdy               process - a fake vendor to run arbitrary commands
    pump                Medtronic - openaps driver for Medtronic

```

We can interact with the devices like this, but this just prints the
information to the screen, and then it's gone.
```
openaps use  fake-cgm shell
openaps use  fake-pump shell
openaps use  fake-oref0 shell
```

If we wanted to get all the information into a file, we might have to
do something like this:

```bash
openaps use fake-cgm shell > fake-cgm-data.txt
openaps use fake-pump shell > fake-pump-data.txt
openaps use fake-oref0 shell > fake-oref0-data.txt
```


Let's try to create reports for each of our fake device uses before:
`openaps report add -h`:
```
usage: openaps-report add [-h] report {base,text,stdout,JSON} device ...

add    - add a new report configuration

positional arguments:
  report
  {base,text,stdout,JSON}

optional arguments:
  -h, --help            show this help message and exit

Known Devices Menu:
  These are the devices openaps knows about:    

  device                Name and description:
    fake-cgm            process - a fake vendor to run arbitrary commands
    fake-oref0          process - a fake vendor to run arbitrary commands
    fake-pump           process - a fake vendor to run arbitrary commands
    howdy               process - a fake vendor to run arbitrary commands
    pump                Medtronic - openaps driver for Medtronic
```

Interesting, apparently the **reports** know about valid **devices**
also.  Let's configure a **report** to save the `fake-cgm` `shell`
data into a file called `fake-cgm-data.txt`:

```
openaps report add fake-cgm-data.txt JSON fake-cgm shell
```

Notice how the  `...` in `openaps report add <name> <format> ...` and
`openaps use ...` are identical.  This is a design feature to
encourage iterating through interactive usage, and then saving the
commands that work into the openaps configuration using the **add**
comands.

## openap report add saves **use** configuration

What did this add command do?

```
$ openaps report add fake-cgm-data.txt JSON fake-cgm shell
added fake-cgm://JSON/shell/fake-cgm-data.txt
```
Let's get a list of all our known reports: `openaps report show`
```
fake-cgm://JSON/shell/fake-cgm-data.txt
```
Or let's see what happened behind the scenes with `git show`:
```diff
commit 25104f7cd4e56e6cb2ca630ce06f927046a669a3
Author: Ben West <bewest@gmail.com>
Date:   Sun Mar 27 18:53:11 2016 -0700

    openaps-report add fake-cgm-data.txt JSON fake-cgm shell
    
          TODO: better change descriptions
          /usr/local/bin/openaps-report add fake-cgm-data.txt JSON fake-cgm shell

diff --git a/openaps.ini b/openaps.ini
index 8b1dbeb..f55161a 100644
--- a/openaps.ini
+++ b/openaps.ini
@@ -18,3 +18,10 @@ extra = fake-pump.ini
 vendor = openaps.vendors.process
 extra = fake-oref0.ini
 
+[report "fake-cgm-data.txt"]
+device = fake-cgm
+remainder = []
+use = shell
+json_default = True
+reporter = JSON
+
```

It modified the openaps configuration with information that matches
the **use** configuration.  It did not run the use, and it did not
create the file, it only saves the configuration.

Let's go ahead and add the others:

```
openaps report add howdy.txt text howdy shell
openaps report add fake-pump-data.txt JSON fake-pump shell
openaps report add fake-oref0-data.txt JSON fake-oref0 shell
```

Notice these add commands saves information about how were using
openaps.  This allows us to **reproduce** the same logic every time.

## Show

Let's take another look at `openaps report show`:
```
fake-cgm://JSON/shell/fake-cgm-data.txt
howdy://text/shell/howdy.txt
fake-pump://JSON/shell/fake-pump-data.txt
fake-oref0://JSON/shell/fake-oref0-data.txt
```


## Invoke

It's time to generate a bunch of reports.  Instead of attempting to
reproduce all the **uses** again with all the right flags and in the
right ways, we can **invoke** the previously saved uses.

First, if we haven't run any reports before, our directory might look
like this.  There's no data here yet, just some configuration.

```
$ ls
fake-cgm.ini
fake-oref0.ini
fake-pump.ini
foo.ini
howdy.ini
openaps.ini
pump.ini
```


Let's try invoking a single report and see what happens:
```
$ openaps report invoke howdy.txt
howdy://text/shell/howdy.txt
reporting howdy.txt
$ ls
fake-cgm.ini
fake-oref0.ini
fake-pump.ini
foo.ini
howdy.ini
howdy.txt
openaps.ini
pump.ini
```

Now there's a `howdy.txt` file containing `cat howdy.txt`:
```
hello world!
```

## Invoke runs preconfigured uses
`openaps report invoke` takes a list of any number of reports:

    openaps report invoke fake-cgm-data.txt howdy.txt fake-pump-data.txt fake-oref0-data.txt

```
$ openaps report invoke fake-cgm-data.txt howdy.txt fake-pump-data.txt fake-oref0-data.txt
fake-cgm://JSON/shell/fake-cgm-data.txt
reporting fake-cgm-data.txt
howdy://text/shell/howdy.txt
reporting howdy.txt
fake-pump://JSON/shell/fake-pump-data.txt
reporting fake-pump-data.txt
fake-oref0://JSON/shell/fake-oref0-data.txt
reporting fake-oref0-data.txt
```

Now we can **invoke** many groups of reports in one line, save the
data to their own files consistently, while referring to the
preconfigured **use** for that **device**.

Each `invoke` creates a new git commit in the log: `openaps show`:
```
commit eb782e12552ad664697aa38d7e6b05b41f5e5a22
Author: Ben West <bewest@gmail.com>
Date:   Sun Mar 27 19:11:37 2016 -0700

    openaps-report invoke fake-cgm-data.txt howdy.txt fake-pump-data.txt fake-oref0-data.txt
    
          TODO: better change descriptions
          /usr/local/bin/openaps-report invoke fake-cgm-data.txt howdy.txt fake-pump-data.txt fake-oref0-data.txt

diff --git a/fake-cgm-data.txt b/fake-cgm-data.txt
new file mode 100644
index 0000000..f54d1ff
--- /dev/null
+++ b/fake-cgm-data.txt
@@ -0,0 +1,3 @@
+{
+  "cgm_fake": "fake-cgm"
+}
\ No newline at end of file
diff --git a/fake-oref0-data.txt b/fake-oref0-data.txt
new file mode 100644
index 0000000..adb1295
--- /dev/null
+++ b/fake-oref0-data.txt
@@ -0,0 +1,3 @@
+{
+  "oref0_fake": "fake-oref0"
+}
\ No newline at end of file
diff --git a/fake-pump-data.txt b/fake-pump-data.txt
new file mode 100644
index 0000000..d2d5bf6
--- /dev/null
+++ b/fake-pump-data.txt
@@ -0,0 +1,3 @@
+{
+  "pump_fake": "fake-pump"
+}
\ No newline at end of file
```

Notice, we already ran `howdy`, earlier, and it did not change.
Also notice how `invoke` performs the same exact logic for each
**report** mentioned.  It is equivalent to running the exact **use**
for each command, saving the data in a file, and creating a log entry.


Reports are how we organize and track the data flowing through the
system.  In `openaps` **reports** **reproduce** **uses**.

