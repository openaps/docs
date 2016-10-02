# Frequently Asked Questions

## What is a Closed Loop?

In general, a "closed loop" system for treatment of diabetes is considered to
be one in which insulin dosing "and in some cases glucagon dosing" is
partially or completely automated. This is in contrast to an "open loop"
system, where the user evaluates the inputs and manually instructs the insulin
pump to dose a specific amount. In both cases, the goal is to maintain blood
glucose within the desired range through adjusting hormone doses.

There are numerous different types of closed loop systems, ranging from simple
basal suspend systems designed to mitigate extreme hypoglycemia to dual
hormone, fully automated systems. The JDRF [Artificial Pancreas Project
Plan](http://jdrf.org/research/treat/artificial-pancreas-project/) page
provides an overview of the current commercial and academic generation-based
approach. Several commercial systems are currently in development; see
[Commercial APS Efforts](../Resources/other-projects#commercial-aps-efforts) for more
information.


\#OpenAPS is focused on a single-hormone hybrid closed-loop system. This is a
system that uses only insulin (no glucagon) and still requires user input for
mealtime insulin. For background on #OpenAPS, review the [\#OpenAPS Reference
Design](https://openaps.org/reference-design/)
page.

## What does an OpenAPS closed loop look like?

While there are numerous variations, this particular setup shows the key components—namely, a continuous glucose monitor, an insulin pump, a method for communicating with the pump (here, a CareLink USB stick), and a controller (here, a Raspberry Pi). Also shown is a Pebble watch, which can be used for monitoring the status of the OpenAPS. Not shown is the power supply (off-screen) and a way to interact with and program the Raspberry Pi, typically a computer or smartphone.

![Example OpenAPS Setup](../IMG_1112.jpg)

For more details on the exact hardware required to build an OpenAPS, see the
[Hardware](../walkthrough/phase-0/hardware.md) section.

