# Introduction

Welcome to the [openaps](https://github.com/openaps/) documentation!

This documentation supports implementing a self driven, Do It Yourself (DIY) artificial pancreas, based on the [OpenAPS Reference Design](https://openaps.org/reference-design/). By proceeding to use these tools or any [openaps](https://github.com/openaps/) repositories, you agree to abide by the copyright agreement and release any contributors from any liability. You assume full responsibility for all actions and outcomes related to use of these tools or ideas. [Please read the copyright agreement before proceeding](https://github.com/openaps/docs/blob/master/license.txt).

* [The easiest option for reading the documentation is by using this version](https://openaps.readthedocs.org/en/latest/index.html). (You may want to bookmark this link.)

----------
## A Note on DIY and the Open Part of OpenAPS

This is a set of development tools to support a self driven DIY implementation of an open source artificial pancreas, OpenAPS. Any individual choosing to use these tools is solely responsible for testing, verifying, and implementing each of these tools independently or together as a system.

The [DIY part of OpenAPS is important](http://bit.ly/1NBbZtO). A growth and learning mindset is required to work with the "building blocks" that will help develop your OpenAPS system. **This is not a set and forget system**; an OpenAPS system requires persistent attention. Users must do blood glucose tests frequently and watch continuous glucose monitors vigilantly, in order to ensure each piece of the system is monitoring, predicting, and controlling blood glucose safely, given user defined constraints. The performance and quality of your OpenAPS system relies solely on you.

This community of contributors believes in paying it forward, and individuals who are implementing these tools are asked to contribute by asking questions, [helping improve this documentation](docs/docs/Resources/my-first-pr.md), and contributing in other ways.


----------
## OpenAPS System Development Phases

This documentation is organized into a series of phases that progressively build upon the openaps development tools towards a working OpenAPS system.

The phases are as follows:

* **Phase 0: General Setup**<br>
Get the equipment you need; record baseline data, configure your hardware, install software, and become familiar with the openaps environment. 

* **Phase 1: Monitoring and Visualization Setup**<br>
Prepare Nightscout or other visualization tools that are key for monitoring a closed loop.

* **Phase 2: Creating a PLGM or open loop**<br>
Use the setup script to build a basic loop; you can choose to run the loop manually ("open loop" mode), or automate your loop. At this stage, you should review and refine algorithms, test different scenarios for safety, etc.

* **Phase 3: Understanding Your Loop and Tweaking Settings**<br>
Analyze the basal recommendations that are outputted from your system; run in a test environment for multiple days to configure safety settings that are right for you before moving forward. 

* **Phase 4: Iterate and Improve the Closed Loop**<br>
At the end of the previous stages and after 3 consecutive nights with no hardware failures and at least 1 night without low alarms, you can move into advanced features like advanced meal assist (AMA) and auto-sensitivity tuning ("autosens" and "autotune"), and improve the functionality of the system with additional software or hardware development.

----------
**You may be looking for:**

* [Live help with your implementation](http://openaps.readthedocs.io/en/latest/docs/introduction/communication-support-channels.html) (Hint: [Check out this Gitter channel](https://gitter.im/nightscout/intend-to-bolus))

* ["Old" setup directions](http://openaps.readthedocs.io/en/latest/docs/walkthrough/manual/index.html)

*  [OpenAPS Reference Design](https://openaps.org/reference-design/)

 
