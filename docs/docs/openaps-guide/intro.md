
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

Once `openaps` is installed in the next section, then we can ask any of these tools for
help to explain themselves:

    `openaps --help`

Many of the tools depend on some configuration though, how do we
provide the configuration it needs?  If it needs configuration, the
tool might refuse to run, like this:

      bewest@bewest-MacBookPro:~/Documents$ openaps use -h
      Not an openaps environment, run: openaps init

Don't worry, it's time to install OpenAPS followed by creating our first workspace!

