# Introduction

* Easily navigable version of the [latest production docs are here.](https://openaps.readthedocs.org/en/latest/index.html)
* Easily navigable version of the [in-development or "dev" docs can be found here.](https://openaps.readthedocs.org/en/dev/index.html)

## Welcome

Welcome to the [openaps](https://github.com/openaps/) documentation!

This documentation support a self-driven Do-It-Yourself (DIY) implementation of an artificial pancreas based on the [OpenAPS reference design](http://openaps.org/open-artificial-pancreas-system-openaps-reference-design/). By proceeding to use these tools or any piece within, you agree to the copyright (see LICENSE.txt for more information) and release any contributors from liability, and assume full responsibility for all of your actions and outcomes related to usage of these tools or ideas.

----------
### A Note on DIY and the "Open" Part of OpenAPS
This is a set of development tools to support a self-driven DIY implementation.
Any person choosing to use these tools is solely responsible for testing and
implementing these tools independently or together as a system.

The [DIY part of OpenAPS is important](http://bit.ly/1NBbZtO). While formal training
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
Get the equipment you need; record baseline data, configure your hardware, install software, and become familiar with the openaps environment. 

* **Phase 1: Monitoring and Visualization Setup**<br>
Prepare Nightscout or other visualization tools that are key for monitoring a closed loop.

* **Phase 2: Creating a a PLGM or open loop**<br>
Use the setup script to build a basic loop; you can choose to run the loop manually ("open loop" mode), or automate your loop. At this stage, you should review and refine algorithms, test different scenarios for safety, etc.

* **Phase 3: Understanding Your Loop and Tweaking Settings**<br>
Analyze the basal recommendations that are outputted from your system; run in a test environment for multiple days to configure safety settings that are right for you before moving forward. 

* **Phase 4: Iterate and Improve the Closed Loop**<br>
At the end of the previous stages and after 3 consecutive nights with no hardware failures and at least 1 night without low alarms, you can move into advanced features like meal-assist and auto-sensitivity tuning. Also improve the functionality of the system with additional software or hardware development

----------
You may be looking for:
* How to [get help with your implementation](http://openaps.readthedocs.io/en/latest/docs/introduction/communication-support-channels.html) (hint: [go to Gitter here](https://gitter.im/nightscout/intend-to-bolus))
* The ["old" directions](http://openaps.readthedocs.io/en/latest/docs/walkthrough/manual/index.html)
* The [OpenAPS Reference Design](https://openaps.org/reference-design/) 
