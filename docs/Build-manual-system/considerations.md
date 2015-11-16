#Considerations before buildling a manual system

oref0 ("OpenAPS Reference Design 0") is our first (zero-th) implementation of the OpenAPS Reference Design. It consists of a number of "Lego Block" tools that, when combined with the core "openaps" toolset to create a full closed loop artificial pancreas system (an OpenAPS implementation).

To create a full OpenAPS implementation using oref0, and by this stage, you should have already set up your openaps devices. At this point, you'll want to include virtual devices for the oref0 tools, too, and make sure you have created reports for commonly used queries and calculations, and then add openaps aliases that bring together those reports into higher-level activities, and eventually, into a single command (or small set of them) that can do everything required to collect data, make a treatment recommendation, and enact it on the pump.

In this section, you'll dive into [how to use the oref0 tools](Using-oref0-tools.md), and learn about [creating a loop and retry logic](loop-and-retry-logic.md). 
