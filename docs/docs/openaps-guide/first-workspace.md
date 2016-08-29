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

