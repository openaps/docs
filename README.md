# Introduction 

Welcome to the [openaps](https://github.com/openaps/openaps) documentation!

![Example OpenAPS Setup](./docs/IMG_1112.jpg)

`openaps` is part of a set of [development tools](https://net.educause.edu/ir/library/pdf/ELI7088.pdf) to support a self-driven Do-It-Yourself (DIY) implementation of an artificial pancreas based on the [OpenAPS reference design](http://openaps.org/open-artificial-pancreas-system-openaps-reference-design/).

The tools may be categorized as:

*  **monitor**—collecting data and operational status from devices, and/or aggregating as much data as is relevant into one place

* **predict**—make predictions about what will happen next

* **control**—enacting changes, and feeding more data back into the **monitor**, closing the loop.

By proceeding to use these tools or any piece within, you agree to the copyright (see LICENSE.txt for more information) and release any contributors from liability. 

##Note

This is a set of development tools to support a self-driven DIY implementation. Any person choosing to use these tools is solely responsible for testing and implementing these tools independently or together as a system.  

**The [DIY part of OpenAPS is important](http://bit.ly/1NBbZtO).** While formal training or experience as an engineer or a developer is not required, **what is required:**

* a growth mindset to learn what are essentially "building blocks" to implement an OpenAPS system. 
	
	* This is not a "set and forget" system; `openaps` requires diligent and consistent testing and monitoring to ensure each piece of the system is monitoring, predicting, and controlling as desired.  The performance and quality of your system lies solely with you.

**This community of contributors believes in "paying it forward," and individuals who are implementing these tools are asked to contribute by asking questions, helping improve documentation, and contributing in other ways.**

# Building an OpenAPS Implementation

### Prerequisites

* Learn how to to go from [learning to use the openaps tools through practicing](../Using-openaps-Tools/using.md) to building your own OpenAPS system. 

* [Why you might take a DIY approach](http://bit.ly/1NBbZtO) for creating new tools and using the OpenAPS system development phases.

	* We cannot provide explicit instructions on how to construct a functional artificial pancreas 
	
	* We cannot recommend that you use the openaps tools for dosing insulin. 

## OpenAPS System Development Phases

The 5 phases build upon the openaps development tools towards a working OpenAPS system:

* [Phase 0: Initial Setup](../Building-a-system/initial-setup.md)<br>
Acquire and configure hardware, install software, and become familiar with the openaps environment

* [Phase 1: Data Collection](../Building-a-system/data-collection.md)<br>
Create tools for logging and analyzing pump and CGM data

* [Phase 2: Recommendation Engine](../Building-a-system/recommendation-engine.md)<br>
Use the logged data to suggest insulin dose adjustments, review and refine algorithms, test different scenarios for safety

* [Phase 3: Closing the Loop](../Building-a-system/closing-the-loop.md)<br>
Apply the recommendations automatically and in real time

* [Phase 4: Additional Modifications](../Building-a-system/getting-fancy.md)<br>
Improve the functionality of the system with additional software or hardware development

## Phase Structure

The document subsection for each phase has three components outlined:

* Upon Completion--The capabilities that the user and system should have after completing the phase  

* Phase Tasks--Tasks or steps to take during the phase

* Community Contribution--Users should be able to contribute to the **#OpenAPS** project and/or openaps development tool set during and after the phase.

The recommended phase descriptions serve as one possible path to step through the development process in a structured way.
