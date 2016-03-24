# Introduction 

Welcome to the [openaps](https://github.com/openaps/) documentation!

openaps is part of a set of [development tools](https://net.educause.edu/ir/library/pdf/ELI7088.pdf) to support a self-driven Do-It-Yourself (DIY) implementation of an artificial pancreas based on the [OpenAPS reference design](http://openaps.org/open-artificial-pancreas-system-openaps-reference-design/). ([Click here to view an image of the common physical components of an OpenAPS setup](source/docs/IMG_1112.jpg).)

By proceeding to use these tools or any piece within, you agree to the copyright (see LICENSE.txt for more information) and release any contributors from liability. 

The tools may be categorized as:

*  **monitor** collecting data and operational status from devices, and/or aggregating as much data as is relevant into one place

* **predict** make predictions about what will happen next

* **control** enacting changes, and feeding more data back into the **monitor**, closing the loop

You may also find [this flowchart](./OpenAPS_phase_visualization_Nov152015.png) helpful to further break down the areas of monitor, predict, and control into various stages of general setup; logging, cleaning, and analyzing data; building a manual system; automating your work; and iterating and improving.

## A Note on DIY and the "Open" Part of OpenAPS

This is a set of development tools to support a self-driven DIY implementation. Any person choosing to use these tools is solely responsible for testing and implementing these tools independently or together as a system.  

The [DIY part of OpenAPS is important](http://bit.ly/1NBbZtO). There are very good reasons why this isn't a single downloadable script. While formal training or experience as an engineer or a developer is not a prerequisite, a growth mindset is required to learn to work with the "building blocks" that will help you develop your OpenAPS instance. Remember as you consider this project that this is not a "set and forget" system; and OpenAPS implementation requires diligent and consistent testing and monitoring to ensure each piece of the system is monitoring, predicting, and controlling as desired.  The performance and quality of your system lies solely with you.

This community of contributors believes in "paying it forward," and individuals who are implementing these tools are asked to contribute by asking questions, [helping improve documentation](source/docs/Resources/my-first-pr.md), and contributing in other ways.


## OpenAPS System Development Phases

This documentation is organized into a series of phases that progressively build upon the openaps development tools towards a working OpenAPS system. [Click here for a visualization and breakdown of the phases](./OpenAPS_phase_visualization_Nov152015.png). The phases are as follows: 

* [Phase 0: General Setup](source/docs/Overview/initial-setup.md)<br>
Record baseline data, acquire and configure hardware, install software, and become familiar with the openaps environment

* [Phase 1: Logging, Cleaning, and Analyzing Your Data](source/docs/Overview/data-collection.md)<br>
Create tools for logging and analyzing pump and CGM data

* [Phase 2: Build a Manual System](source/docs/Overview/manual-system.md)<br>
Use the logged data with oref0 tools to suggest insulin dose adjustments, review and refine algorithms, test different scenarios for safety, prepare for creating a loop and implementing retry logic

* [Phase 3: Automate Your System](source/docs/Overview/automate-system.md)<br>
Apply the recommendations automatically and in real time by creating a schedule and continuing to validate and assess outputs

* [Phase 4: Iterate and Improve](source/docs/Overview/iterate-improve.md)<br>
Improve the functionality of the system with additional software or hardware development

At the beginning of each phase, an outline summarizes:

* Upon Completion—The capabilities that the user and system should have after completing the phase
	
* Phase Tasks—Tasks or steps to take during the phase

* Community Contribution—How users should be able to contribute to the #OpenAPS project and/or openaps development tool set during and after the phase

# Summary

* [Introduction](README.md)
   * [Table of Contents](SUMMARY.md)
   * [Conventions](source/docs/Overview/conventions.md)
   * [Ways to Contribute](source/docs/Overview/contribute.md)
   * [Where to Go for Help](source/docs/Overview/communication-support-channels.md)
* [Phase 0: General Setup](source/docs/getting-started/setup.md)
   * [Baseline Data](source/docs/getting-started/baseline-data.md)
   * [Hardware](source/docs/getting-started/hardware.md)
   * [Seting Up Your Raspberry Pi](source/docs/getting-started/rpi.md)
   * [Setting Up openaps and Dependencies](source/docs/getting-started/openaps.md)
* [Phase 1: Logging, Cleaning, and Analyzing Your Data](source/docs/Log-clean-analyze-with-openaps-tools/log-clean-analyze.md)
   * [Configuring and Learning to Use openaps Tools](source/docs/Log-clean-analyze-with-openaps-tools/using.md)
* [Phase 2: Build a Manual System](source/docs/Build-manual-system/considerations.md)
   * [Using oref0 Tools](source/docs/Build-manual-system/Using-oref0-tools.md)
   * [Understanding oref0-determine-basal recommendations] (source/docs/Build-manual-system/Understand-determine-basal.md)
   * [Creating a Loop and Retry Logic](source/docs/Build-manual-system/loop-and-retry-logic.md)
* [Phase 3: Automate Your System](source/docs/Automate-system/considerations.md)
   * [Creating a Schedule](source/docs/Automate-system/create-schedule.md)
   * [Visualization and Monitoring](source/docs/Automate-system/vizualization.md)
   * [Validating and Testing](source/docs/Automate-system/validate-output.md)
   * [Keeping Up To Date](source/docs/Automate-system/keeping-up-to-date.md)
* [Phase 4: Iterate and Improve](source/docs/Iterate-improve/improvement-projects.md)
* [Resources](source/docs/Resources/resources.md)
   * [Technical Resources](source/docs/Resources/technical-resources.md)
   * [Troubleshooting](source/docs/Resources/troubleshooting.md)
   * [#OpenAPS Overview and Project History](source/docs/Resources/history.md)
   * [Other Projects, People & Tools](source/docs/Resources/other-projects.md)
   * [FAQs](source/docs/Resources/faq.md)
   * [Glossary](source/docs/Resources/glossary.md)

