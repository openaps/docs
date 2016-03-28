
# About openaps

`openaps` is a toolkit to make developing an artificial pancreas easy
for humans.  What is an artificial pancreas?  What are the
requirements of this toolkit and how does it work?

While most people learning about this project may be interested in
assembling their own "AP" as soon as possible, it may be helpful to
pause and get a high level overview of openaps.


## What is an artificial pancreas?

The term artificial pancreas can be misleading, as it can include or
exclude different ideas or projects.  For our purposes, an artificial
pancreas does the following things:

1. **Monitor** therapeutic data (especially from pumps and CGM) in real time to
   provide relevant decision making data points.  In order to do this,
   we must be able to manage data from disparate systems in a
   **uniform** manner.

1. **Predict** what is likely to happen.
   For example, when administering insulin, we naturally expect
   glucose to fall along a given curve.
   High fidelity therapy means communicating expectations like this,
   learning when it is wrong, and responding accordingly.
   Since clinical therapy is an application of science, this process
   must be **reproducible**, so that we can properly assess what
   works, and what does not.

1. **Enact** shared plans like a good teammate.
   When humans get distracted, or sick, or are asleep, the tools can
   and should provide assistance to improve **safety** and increase
   **control** over dangerous conditions.

## Bring your own device

Circa 2016-03-27, we have access to a variety of insulin pumps and
glucose monitors.  openaps provides a modular framework to manipulate
a variety of insulin pumps, and glucose monitors, as well as
**devices** by different **vendors**.  openaps exposes the **uses** of
a **device** from a particular **vendor** for you to explore your own
menagerie of devices in a **uniform** and interoperable manner.
`openaps` also provides `reports` to track data as it flows through
each phase, and an **alias** feature to logically group commands and
workflows.

When the community discovers how to communicate with a device, we can
create an openaps **vendor** module for the new device.

## What is a toolkit?
`openaps` is not an artificial pancreas by itself.  So far in
discussing some of the philosophy and overview of openaps, we've seen
that it needs to interact with a lot of different devices in a lot of
different circumstances.  The solution to solving this problem was to
provide a suite of tools that allows us to interact with the
properties of the system, easily see what is going on inside and
inspect the data.  Because we often intend for the system to operate
while we're asleep, the tools also provide several facilities for
easily changing and saving configuration.

This means we'll be using the command line a lot, because it's very
easy to teach, reproduce, and automate.  Any series of commands you
type in the command line can be put in a file and made into a script.

Because most people intend to use this as a medical device, we also
wanted to track the data as it moves through the system.  openaps
checkpoints all the data so that it can be inspected and verified at
anytime.

The toolkit provides many tools to realize the values enumerated by
our design philosophy.  Here are a few, but don't panic, we'll go
through how to use each one methodically:

      openaps
      openaps-device
      openaps-report
      openaps-vendor
      openaps-use
      openaps-alias

Now that `openaps` is installed, we can ask any of these tools for
help to explain themselves:

    `openaps --help`

Many of the tools depend on some configuration though, how do we
provide the configuration it needs?  If it needs configuration, the
tool might refuse to run, like this:

      bewest@bewest-MacBookPro:~/Documents$ openaps use -h
      Not an openaps environment, run: openaps init

Don't worry, it's time to create our first workspace!

## My first workspace

This guide aims to help users become comfortable navigating the
openaps commands.  Most of the commands read saved configuration.
`openaps` needs a location to store all the data and configuration
generated as we explore.  We'll often refer to this location as your
**openaps instance**.  The toolkit helps you create an **instance** of
openaps on your computer.  We can think about this location as a
workspace for openaps.

Get familiar with `ls`, `cat`, `echo`, `cd`, `pwd` commands.
To create our first openaps instance, we use `openaps init` with the
location we'd like to use:

    cd ~/Documents
    openaps init tutorial-hello
    cd tutorial-hello
    pwd

This creates a new openaps **instance** in
`~/Documents/tutorial-hello`.  Take a look at what is in your
workspace, using `ls` and `cat`.  A valid instance must have an
`openaps.ini` file.  It can be empty, which simply means it doesn't
(yet) know about your devices or vendors or anything.

``` eval_rst
.. note::

  For the rest of this tutorial, all of our work will be done in the
  `~/Documents/tutorial-hello` directory.
```

## Inspecting the log
We mentioned earlier that the requirements for `openaps` demand that
we track data as it flows through the system.  Is there a log of all
the transactions that have occurred?  If so, it should include the
fact that we just created an instance of openaps.  A valid instance of
openaps has two requirements: it must be a `git` repository containing
an `openaps.ini` file at it's root.

This means many operations are tracked using `git`, try `git log` or `git
show`; there should an event in the log showing the time and date (and who!)
created this instance.

```bash
bewest@bewest-MacBookPro:~/Documents/tutorial-hello$ ls
openaps.ini
bewest@bewest-MacBookPro:~/Documents/tutorial-hello$ cat openaps.ini 
bewest@bewest-MacBookPro:~/Documents/tutorial-hello$ wc -l openaps.ini 
0 openaps.ini
bewest@bewest-MacBookPro:~/Documents/tutorial-hello$ git show
```
```diff
commit 04715a67099c19ae220220d474aa67e470d07e0e
Author: Ben West <bewest@gmail.com>
Date:   Sun Mar 27 14:37:56 2016 -0700

    initializing openaps 0.1.0-dev

diff --git a/openaps.ini b/openaps.ini
new file mode 100644
index 0000000..e69de29
bewest@bewest-MacBookPro:~/Documents/tutorial-hello$ 
```

Knowledge of `git` is not usually needed or expected in order to use
`openaps`, however, `openaps` does use it to store and track all data.
This has several side-effects including easy mesh/backup.  Many events
in the log will also include a comment on the commands used to create
the transaction.  This allows us to share, find and debug problems
quickly and easily.

Many software programs attempt to hide the inner workings. However
because `openaps` has to meet exacting requirements, the design
enables openaps to easily examine and adjust how it works using
standard tools.

## Summary

Congratulations, you're now the owner of a new openaps instance.  It's
time to start exploring `openaps` core in more detail.

  * [Devices](core/devices.md)
  * [Reports](core/reports.md)
  * [Alias](core/alias.md)
  * [Vendors](core/vendors.md)

