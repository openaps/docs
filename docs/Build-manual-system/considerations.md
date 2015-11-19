# Phase 2: Build a Manual System

Phase 2 focuses on deploying a suitable algorithm to recommend necessary changes to basal rates. This is essentially a practice closed-loop system, with you completing the loop by manually calculating what you would do in that scenario. This can be performed in real time or by using historical data and making retroactive suggestions. Pay special attention to situations where CGM readings are not smooth (after calibration, with a new sensor, or with errors such as ???) or when there are issues with data connectivity or fidelity. Assume there will be issues with connectivity.

In this section, you'll dive into [how to use the oref0 tools](Using-oref0-tools.md) and learn about [creating a loop and retry logic](loop-and-retry-logic.md). oref0—short for "OpenAPS Reference Design 0"—is our first (zero-th) implementation of the OpenAPS Reference Design. It consists of a number of "Lego block" tools that, when combined with the core openaps toolset, create a full closed loop artificial pancreas system—an OpenAPS implementation.

By this stage, you should have already set up your pump and cgm as openaps devices. You will now add the oref0 tools as virtual devices, create openaps reports for commonly used queries and calculations, and add openaps aliases that bring together those reports into higher-level activities. Finally, you can combine those into a single command (or small set of them) that can do everything required to collect data, make a treatment recommendation, and enact it on the pump.

If you haven't already done so, this is also an excellent time to calibrate your inputs, such as insulin sensitivity factor (ISF), carbohydrate ratio (CR), basal rates, et cetera.

### Outline of Phase 2

* Upon Completion
    * Have a set of algorithms designed to keep blood glucose in target range with temp basals
    * Have provided patient-specific inputs required for these algorithms
    * Have those algorithms coded so as to take the data collection built in Phase 1 as input
    * Have the code output recommendations as to how it would change temp basal rates
    * Have the ability to utilize code on real-time and historical data to evaluate efficacy
    * Have implemented, tested, and tuned one or more set of algorithms and be able to help others do the same


* Phase Tasks
    * Research the different strategies and tools for single-hormone closed loop systems
    * Complete relevant patient-specific studies to determine key inputs (e.g. [carb absorption](http://diyps.org/2014/05/29/determining-your-carbohydrate-absorption-rate-diyps-lessons-learned/), although not necessary for OpenAPS, may be helpful)
    * Code one or more of these strategies such that they can accept live and/or historic patient data and output suggestions for temp basal changes. (oref0 is currently popular.)
    * Evaluate the efficacy of these algorithms by testing their suggestions against live and historic data
    * Iterate on the algorithms and their implementation to improve their output
    * Test at least these cases: data corruption, lack of data, lack of connectivity, and other non-ideal operating conditions, and provide error checking. Also, create a Òpreflight checkÓ.
    * Create a loop alias and retry logic


* Community Contributions
    * Provide feedback on efficacy of algorithms
    * Help edit instructions for Phase 2
    * Provide results of testing for comparing and contrasting with others
    * Summarize research findings and synthesize them into jump-off points for others' research




# Summary

* [Introduction](README.md)
* [Phase 0: General Setup](docs/getting-started/setup.md)
* [Phase 1: Logging, Cleaning, and Analyzing Your Data](docs/Log-clean-analyze-with-openaps-tools/log-clean-analyze.md)
* [Phase 2: Build a Manual System](docs/Build-manual-system/considerations.md)
   * [Using oref0 Tools](docs/Build-manual-system/Using-oref0-tools.md)
   * [Creating a Loop and Retry Logic](docs/Build-manual-system/loop-and-retry-logic.md)
* [Phase 3: Automate Your System](docs/Automate-system/considerations.md)
* [Phase 4: Iterate and Improve](docs/Iterate-improve/improvement-projects.md)
* [Resources](docs/Resources/resources.md)
* [Glossary](docs/Resources/glossary.md)

