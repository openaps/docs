# Introduction 

Welcome to the [openaps](https://github.com/openaps/) documentation!

openaps is part of a set of tools to support a self-driven Do-It-Yourself (DIY) implementation of an artificial pancreas based on the [OpenAPS reference design](http://openaps.org/open-artificial-pancreas-system-openaps-reference-design/). 

By proceeding to use these tools or any piece within, you agree to the copyright (see LICENSE.txt for more information) and release any contributors from liability. 

The tools may be categorized as: 1)  **monitor** collecting data and operational status from devices, and/or aggregating as much data as is relevant into one place; 2)  **predict** make predictions about what will happen next; and 3)  **control** enacting changes, and feeding more data back into the **monitor**, closing the loop

You may also find [this flowchart](./OpenAPS_phase_visualization_Nov152015.png) helpful to further break down the areas of monitor, predict, and control into various stages of general setup; logging, cleaning, and analyzing data; building a manual system or "open loop"; automating your work and starting to close and tune your loop; and iterating and improving on your setup over time.


----------
### A Note on DIY and the "Open" Part of OpenAPS
This is a set of development tools to support a self-driven DIY implementation. Any person choosing to use these tools is solely responsible for testing and implementing these tools independently or together as a system.  

The [DIY part of OpenAPS is important](http://bit.ly/1NBbZtO). There are very good reasons why this isn't a single downloadable script. While formal training or experience as an engineer or a developer is not a prerequisite, a growth mindset is required to learn to work with the "building blocks" that will help you develop your OpenAPS instance. Remember as you consider this project that this is not a "set and forget" system; an OpenAPS implementation requires diligent and consistent testing and monitoring to ensure each piece of the system is monitoring, predicting, and controlling as desired.  The performance and quality of your system lies solely with you.

This community of contributors believes in "paying it forward," and individuals who are implementing these tools are asked to contribute by asking questions, [helping improve documentation](source/docs/Resources/my-first-pr.md), and contributing in other ways.


----------
###OpenAPS System Development Phases

This documentation is organized into a series of phases that progressively build upon the openaps development tools towards a working OpenAPS system. [Click here for a visualization and breakdown of the phases](./OpenAPS_phase_visualization_Nov152015.png). The phases are as follows: 

* [Phase 0: General Setup](source/docs/walkthrough/phase-0/setup.md)<br>
Get the equipment you need; record baseline data, configure your hardware, install software, and become familiar with the openaps environment

* [Phase 1: Logging, Cleaning, and Analyzing Your Data](source/docs/walkthrough/phase-1/log-clean-analyze.md)<br>
Create or utilize tools for logging and analyzing pump and CGM data

* [Phase 2: Creating an Open Loop](docs/walkthrough/phase-2/considerations.md)<br>
Use the logged data with oref0 tools to suggest insulin dose adjustments in an "open loop"; review and refine algorithms, test different scenarios for safety, prepare for creating a loop and implementing retry logic

* [Phase 3: Understanding Your Open Loop](docs/walkthrough/phase-3/considerations.md)<br>
Analyze the basal recommendations that are outputted from your system; run in a test environment for multiple days to configure safety settings that are right for you.

* [Phase 4: Starting to Close the Loop](docs/walkthrough/phase-4/considerations.md)<br>
Apply the recommendations automatically and in real time by creating a schedule and continuing to validate and assess outputs; beginning with a simple "low glucose suspend"-type mode for several days, tweaking settings and validating setup before moving forward.

* [Phase 5: Tuning the Closed Loop](docs/walkthrough/phase-5/considerations.md)<br>
Moving beyond low glucose suspend mode, work through tuning your targets

* [Phase 6: Iterate and Improve the Closed Loop](sdocs/walkthrough/phase-6/considerations.mdd)<br>
At the end of the previous stages and after 3 consecutive nights with no hardware failures and at least 1 night without low alarms, you can move into advanced features like meal-assist and auto-sensitivity tuning. Also improve the functionality of the system with additional software or hardware development

----------
In addition to the phases linked above for helping you consider the DIY loop implementation process, you may also be interested in some of the following resources?

* [Resources](source/docs/Resources/resources.md)
   * [Technical Resources](source/docs/Resources/technical-resources.md)
   * [Troubleshooting](source/docs/Resources/troubleshooting.md)
   * [#OpenAPS Overview and Project History](source/docs/Resources/history.md)
   * [Other Projects, People & Tools](source/docs/Resources/other-projects.md)
   * [FAQs](source/docs/Resources/faq.md)
   * [Glossary](source/docs/Resources/glossary.md)
