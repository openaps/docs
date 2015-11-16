# Introduction 

Welcome to the [openaps](https://github.com/openaps/openaps) documentation!

![Example OpenAPS Setup](./docs/IMG_1112.jpg)

`openaps` is part of a set of [development tools](https://net.educause.edu/ir/library/pdf/ELI7088.pdf) to support a self-driven Do-It-Yourself (DIY) implementation of an artificial pancreas based on the [OpenAPS reference design](http://openaps.org/open-artificial-pancreas-system-openaps-reference-design/).

The tools may be categorized as:

*  **monitor**â€”collecting data and operational status from devices, and/or aggregating as much data as is relevant into one place

* **predict**â€”make predictions about what will happen next

* **control**â€”enacting changes, and feeding more data back into the **monitor**, closing the loop.

By proceeding to use these tools or any piece within, you agree to the copyright (see LICENSE.txt for more information) and release any contributors from liability. 
You may also find this flowchart helpful to further break down the areas of Òmonitor, predict, and controlÓ into various stages of general setup; logging, cleaning, and analyzing data; building a manual system; automating your work; and iterating and improving.
(PHASE IMAGE)

##Note

This is a set of development tools to support a self-driven DIY implementation. Any person choosing to use these tools is solely responsible for testing and implementing these tools independently or together as a system.  

**The [DIY part of OpenAPS is important](http://bit.ly/1NBbZtO).** While formal training or experience as an engineer or a developer is not required, a growth mindset is required to learn to work with the Òbuilding blocksÓ that will help you develop your OpenAPS instance. Remember as you consider this project that this is not a "set and forget" system; `openaps` requires diligent and consistent testing and monitoring to ensure each piece of the system is monitoring, predicting, and controlling as desired.  The performance and quality of your system lies solely with you.

**This community of contributors believes in "paying it forward," and individuals who are implementing these tools are asked to contribute by asking questions, helping improve documentation, and contributing in other ways.**

# Building an OpenAPS Implementation

* Before deciding to close the loop, you will first [learn how to use the openaps tools](../Using-openaps-Tools/using.md) before building a system based on the OpenAPS reference design (which has related tools named under Òoref0Ó, which stands for ÒOpenAPS Reference Design 0Ó). 


* [Again, make sure you understand why the DIY approach](http://bit.ly/1NBbZtO) for creating new tools and using the OpenAPS system development phases is a critical part of building a system.


## OpenAPS System Development Phases

The 5 phases build upon the openaps development tools towards a working OpenAPS system:

* [Phase 0: General Setup](../Building-a-system/initial-setup.md)<br>
Record baseline data; acquire and configure hardware, install software, and become familiar with the openaps environment

* [Phase 1: Logging, cleaning and analyzing your data](../Building-a-system/data-collection.md)<br>
Create tools for logging and analyzing pump and CGM data

* [Phase 2: Build a manual system](../Building-a-system/recommendation-engine.md)<br>
Use the logged data with oref0 tools to suggest insulin dose adjustments, review and refine algorithms, test different scenarios for safety; prepare for creating a loop and implementing retry logic

* [Phase 3: Automate your system](../Building-a-system/closing-the-loop.md)<br>
Apply the recommendations automatically and in real time by creating a schedule and continuing to validate and assess outputs

* [Phase 4: Iterate and improve](../Building-a-system/getting-fancy.md)<br>
Improve the functionality of the system with additional software or hardware development

## Phase Structure

The document subsection for each phase has three components outlined:

* Upon Completion--The capabilities that the user and system should have after completing the phase
	
* Phase Tasks--Tasks or steps to take during the phase

* Community Contribution--Users should be able to contribute to the **#OpenAPS** project and/or openaps development tool set during and after the phase.

The recommended phase descriptions serve as one possible path to step through the development process in a structured way.

