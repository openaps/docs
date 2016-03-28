
# Devices - aka **using** openaps

There are several **vendors** that built into the core of openaps.
There are two tools we can use to examine which **vendors** are available for
**use** by a **device**.

## What can we use?

The `openaps use` command allows us to interact with devices.  Let's ask it for help:

    openaps use -h

```bash
usage: openaps-use [-h] [--format {text,json,base,stdout}] [--output OUTPUT]
                   [--version]
                   device ...
[... edited for brevity ...]
Known Devices Menu:
  These are the devices openaps knows about:    

  device                Name and description:

Once a device is registered in openaps.ini, it can be used.
```

Notice the `Known Devices Menu:` is empty, this means `openaps` doesn't know
about anything yet.
Let's try the `openaps device` command instead:

```
usage: openaps-device [-h] {add,remove,show} ...

  openaps-device - Manage device configurations.

positional arguments:
  {add,remove,show}  Operation
    add              add - add a new device configuration
    remove           remove - remove a device configuration
    show             show - show all devices

optional arguments:
  -h, --help         show this help message and exit

show    - lists all known devices
add     - add a new device
remove  - remove a device
```

Lots of options there: the `devices` command allows us to teach openaps about our devices.
The **use** command above had an empty devices menu what does `device show` say?
```
```
Nothing yet!  Both `openaps use` and `openaps device show` indicate nothing for us
to interact with yet.  Let's look at the `--help` output for `device add`:

```
usage: openaps-device add [-h] [--extra EXTRA]
                          name {dexcom,medtronic,process,units} ...

add    - add a new device configuration

positional arguments:
  name

optional arguments:
  -h, --help            show this help message and exit
  --extra EXTRA, -e EXTRA
                        Name of extra ini file to use.

## VendorConfigurations:
  {dexcom,medtronic,process,units}
                        Operation
    dexcom              Dexcom - openaps driver for dexcom
    medtronic           Medtronic - openaps driver for Medtronic
    process             process - a fake vendor to run arbitrary commands
    units               Units - units tool for openaps
```

Notice `VendorConfigurations`.  These are the default **vendors** that ship
with `openaps`.  However, `openaps` doesn't know we want to **use**
them yet.  `openaps device add` allows us to name our device.  The
name we *add* to openaps will be the name we **use** later.

## **Devices** configure **use**

### A trivial device

Let's use `echo` to create a trivial device that just says "hello
world."
`echo` is a unix **process**, the **VendorConfigurations** above include a
`process` vendor we can use to illustrate the relationship between **uses**
and **devices**.
Let's warm up with some examples:

```bash
echo 'hello world!'
```
That should print hello world on the screen.  We can run this over and
over again just for fun, but let's discover how to teach `openaps` how
to do this.

```bash
openaps device add howdy process  echo 'hello world!'
added process://howdy/echo/hello world!
```

What did this do? Let's check `git show`:

```diff
commit 8e198ad8556ea6df4d4f6459d212eee316b89a0e
Author: Ben West <bewest@gmail.com>
Date:   Sun Mar 27 15:45:16 2016 -0700

    openaps-device add howdy process echo hello world!
    
          TODO: better change descriptions
          /usr/local/bin/openaps-device add howdy process echo hello world!

diff --git a/openaps.ini b/openaps.ini
index e69de29..d4a23d0 100644
--- a/openaps.ini
+++ b/openaps.ini
@@ -0,0 +1,4 @@
+[device "howdy"]
+vendor = openaps.vendors.process
+extra = howdy.ini
+
```

The `openaps * add` commands all change some of the INI configurations.

Did the **use** menu change at all? `openap use -h`

```
[...]
Known Devices Menu:
  These are the devices openaps knows about:    

  device                Name and description:
    howdy               process - a fake vendor to run arbitrary commands

```

Now there's a **howdy** device in the **use** menu.  The **use** menu adapts
to our custom devices.  Now we can **use** the device interactively: `openaps
use howdy -h`, remember, we can always add `-h` to get more help/hints.
Take note of that `--format text` option... our trivial `howdy` tool just
prints a line of text.  Most tools actually use a format called json (and it's
the default), but for this example, we'll stick with `--format text`.

```
usage: openaps-use howdy [-h] USAGE ...

optional arguments:
  -h, --help  show this help message and exit

## Device howdy:
  vendor openaps.vendors.process
  
  process - a fake vendor to run arbitrary commands
  
      

  USAGE       Usage Details
    shell     run a process in a subshell
```

Hmm, because this a *unix process*, the **use** for this one is called
**shell**.  What happens if we just add that word to the end? `openaps use
--format text howdy shell`

```
$ openaps use --format text howdy shell
hello world!
```

Now it prints `hello world!` because we are interactively **using** the
**device**.  The **device** was configured through the `add` command, and
saved in the INI as the `process` **vendor**.  The `process` **vendor** only
exposes a single **use**: the `shell` use allows us to run any unix process.
The **device** commands configure the **uses**.  The **use** menu adapts to
the registered **devices**.  We can interact with a device by using it.


## Summary
  
Hopefully this illustrates the relationship between the openaps **device** and
**use** tools.  The `device` command allows bringing devices into your
instance, and **use** allows interacting with them.  Let's take a deeper look
at this relationship looking at the other vendors that might share a closer
relationship to diabetes.

  * [medtronic builtin]


[medtronic builtin]: medtronic.md
[dexcom builtin]: dexcom.md
[overview]: ../overview.md

