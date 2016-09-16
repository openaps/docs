# Introduction

* Easily navigable version of the [latest production docs are here.](https://openaps.readthedocs.org/en/latest/index.html)
* Easily navigable version of the [in-development or "dev" docs can be found here.](https://openaps.readthedocs.org/en/dev/index.html)

## Welcome

Welcome to the [openaps](https://github.com/openaps/) documentation!

openaps is part of a set of tools to support a self-driven Do-It-Yourself (DIY) implementation of an artificial pancreas based on the [OpenAPS reference design](http://openaps.org/open-artificial-pancreas-system-openaps-reference-design/).

Here are two visuals to show you what the physical hardware components of an OpenAPS setup look like - [version A](docs/docs/IMG_1112.jpg) is without labels; [version B](https://github.com/logichammer/docs/blob/b53a64b5dce81eaf112c7dafcb8d3415b2ddf85c/docs/Images/piSetup.jpg) contains labels to describe the parts.

By proceeding to use these tools or any piece within, you agree to the copyright (see LICENSE.txt for more information) and release any contributors from liability.

The tools may be categorized as: 1)  **monitor** collecting data and
operational status from devices, and/or aggregating as much data as is relevant
into one place; 2)  **predict** make predictions about what will happen next;
and 3)  **control** enacting changes, and feeding more data back into the
**monitor**, closing the loop.

----------
### A Note on DIY and the "Open" Part of OpenAPS
This is a set of development tools to support a self-driven DIY implementation.
Any person choosing to use these tools is solely responsible for testing and
implementing these tools independently or together as a system.

The [DIY part of OpenAPS is important](http://bit.ly/1NBbZtO). There are very
good reasons why this isn't a single downloadable script. While formal training
or experience as an engineer or a developer is not a prerequisite, a growth
mindset is required to learn to work with the "building blocks" that will help
you develop your OpenAPS instance. Remember as you consider this project that
this is not a "set and forget" system; an OpenAPS implementation requires
diligent and consistent testing and monitoring to ensure each piece of the
system is monitoring, predicting, and controlling as desired.  The performance
and quality of your system lies solely with you.

This community of contributors believes in "paying it forward," and individuals
who are implementing these tools are asked to contribute by asking questions,
[helping improve documentation](docs/docs/Resources/my-first-pr.md), and
contributing in other ways.


----------
### OpenAPS System Development Phases

This documentation is organized into a series of phases that progressively
build upon the openaps development tools towards a working OpenAPS system.
The phases are as follows:

* **Phase 0: General Setup**<br>
Get the equipment you need; record baseline data, configure your hardware, install software, and become familiar with the openaps environment

* **Phase 1: Logging, Cleaning, and Analyzing Your Data**<br>
Create or utilize tools for logging and analyzing pump and CGM data

* **Phase 2: Creating an Open Loop**<br>
Use the logged data with oref0 tools to suggest insulin dose adjustments in an "open loop"; review and refine algorithms, test different scenarios for safety, prepare for creating a loop and implementing retry logic

* **Phase 3: Understanding Your Open Loop**<br>
Analyze the basal recommendations that are outputted from your system; run in a test environment for multiple days to configure safety settings that are right for you.

* **Phase 4: Starting to Close the Loop**<br>
Apply the recommendations automatically and in real time by creating a schedule and continuing to validate and assess outputs; beginning with a simple "low glucose suspend"-type mode for several days, tweaking settings and validating setup before moving forward.

* **Phase 5: Tuning the Closed Loop**<br>
Moving beyond low glucose suspend mode, work through tuning your targets

* **Phase 6: Iterate and Improve the Closed Loop**<br>
At the end of the previous stages and after 3 consecutive nights with no hardware failures and at least 1 night without low alarms, you can move into advanced features like meal-assist and auto-sensitivity tuning. Also improve the functionality of the system with additional software or hardware development
