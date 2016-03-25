# Introduction 

Welcome to the [openaps](https://github.com/openaps/) documentation!

openaps is part of a set of tools to support a self-driven Do-It-Yourself (DIY) implementation of an artificial pancreas based on the [OpenAPS reference design](http://openaps.org/open-artificial-pancreas-system-openaps-reference-design/). 

By proceeding to use these tools or any piece within, you agree to the copyright (see LICENSE.txt for more information) and release any contributors from liability. 

The tools may be categorized as: 1)  **monitor** collecting data and operational status from devices, and/or aggregating as much data as is relevant into one place; 2)  **predict** make predictions about what will happen next; and 3)  **control** enacting changes, and feeding more data back into the **monitor**, closing the loop.

----------
### A Note on DIY and the "Open" Part of OpenAPS
This is a set of development tools to support a self-driven DIY implementation. Any person choosing to use these tools is solely responsible for testing and implementing these tools independently or together as a system.  

The [DIY part of OpenAPS is important](http://bit.ly/1NBbZtO). There are very good reasons why this isn't a single downloadable script. While formal training or experience as an engineer or a developer is not a prerequisite, a growth mindset is required to learn to work with the "building blocks" that will help you develop your OpenAPS instance. Remember as you consider this project that this is not a "set and forget" system; an OpenAPS implementation requires diligent and consistent testing and monitoring to ensure each piece of the system is monitoring, predicting, and controlling as desired.  The performance and quality of your system lies solely with you.

This community of contributors believes in "paying it forward," and individuals who are implementing these tools are asked to contribute by asking questions, [helping improve documentation](docs/docs/Resources/my-first-pr.md), and contributing in other ways.


----------
###OpenAPS System Development Phases

This documentation is organized into a series of phases that progressively build upon the openaps development tools towards a working OpenAPS system. The phases are as follows: 

* [Phase 0: General Setup](docs/docs/walkthrough/phase-0/setup.md)<br>
Get the equipment you need; record baseline data, configure your hardware, install software, and become familiar with the openaps environment

* [Phase 1: Logging, Cleaning, and Analyzing Your Data](docs/docs/walkthrough/phase-1/log-clean-analyze.md)<br>
Create or utilize tools for logging and analyzing pump and CGM data

* [Phase 2: Creating an Open Loop](docs/docs/walkthrough/phase-2/considerations.md)<br>
Use the logged data with oref0 tools to suggest insulin dose adjustments in an "open loop"; review and refine algorithms, test different scenarios for safety, prepare for creating a loop and implementing retry logic

* [Phase 3: Understanding Your Open Loop](docs/docs/walkthrough/phase-3/considerations.md)<br>
Analyze the basal recommendations that are outputted from your system; run in a test environment for multiple days to configure safety settings that are right for you.

* [Phase 4: Starting to Close the Loop](docs/docs/walkthrough/phase-4/considerations.md)<br>
Apply the recommendations automatically and in real time by creating a schedule and continuing to validate and assess outputs; beginning with a simple "low glucose suspend"-type mode for several days, tweaking settings and validating setup before moving forward.

* [Phase 5: Tuning the Closed Loop](docs/docs/walkthrough/phase-5/considerations.md)<br>
Moving beyond low glucose suspend mode, work through tuning your targets

* [Phase 6: Iterate and Improve the Closed Loop](docs/docs/walkthrough/phase-6/considerations.mdd)<br>
At the end of the previous stages and after 3 consecutive nights with no hardware failures and at least 1 night without low alarms, you can move into advanced features like meal-assist and auto-sensitivity tuning. Also improve the functionality of the system with additional software or hardware development

----------
In addition to the phases linked above for helping you consider the DIY loop implementation process, you may also be interested in some of the following resources:

* [Resources](docs/docs/Resources/resources.md)
   * [Technical Resources](docs/docs/Resources/technical-resources.md)
   * [Troubleshooting](docs/docs/Resources/troubleshooting.md)
   * [#OpenAPS Overview and Project History](docs/docs/Resources/history.md)
   * [Other Projects, People & Tools](docs/docs/Resources/other-projects.md)
   * [FAQs](docs/docs/Resources/faq.md)
   * [Glossary](docs/docs/Resources/glossary.md)



-   <a href="docs/docs/introduction/index.rst" class="reference internal">Introduction</a>
    *   <a href="docs/docs/introduction/understand-this-guide.md" class="reference internal">Understanding this guide</a>
        *   <a href="docs/docs/introduction/understand-this-guide.md#before-you-get-started" class="reference internal">Before you get started</a>
        *   <a href="docs/docs/introduction/understand-this-guide.md#what-you-won-t-see-in-this-guide" class="reference internal">What you won’t see in this guide</a>
    *   <a href="docs/docs/introduction/contribute.md" class="reference internal">Ways to Contribute</a>
    *   <a href="docs/docs/introduction/communication-support-channels.md" class="reference internal">Where to go for help with your implementation</a>
        *   <a href="docs/docs/introduction/communication-support-channels.md#gitter" class="reference internal">Gitter</a>
        *   <a href="docs/docs/introduction/communication-support-channels.md#google-groups" class="reference internal">Google Groups</a>
        *   <a href="docs/docs/introduction/communication-support-channels.md#issues-on-openaps-github" class="reference internal">Issues on openaps GitHub</a>
        *   <a href="docs/docs/introduction/communication-support-channels.md#other-online-forums" class="reference internal">Other online forums</a>
-   <a href="docs/docs/walkthrough/index.rst" class="reference internal">Walkthrough</a>
    *   <a href="docs/docs/walkthrough/phase-0/index.rst" class="reference internal">Phase 0: General Setup</a>
        *   <a href="docs/docs/walkthrough/phase-0/setup.md" class="reference internal">General Setup and Project Prep</a>
        *   <a href="docs/docs/walkthrough/phase-0/baseline-data.md" class="reference internal">Baseline data</a>
        *   <a href="docs/docs/walkthrough/phase-0/hardware.md" class="reference internal">Hardware</a>
        *   <a href="docs/docs/walkthrough/phase-0/rpi.md" class="reference internal">Setting Up Your Raspberry Pi</a>
        *   <a href="docs/docs/walkthrough/phase-0/openaps.md" class="reference internal">Setting Up openaps and Dependencies</a>
    *   <a href="docs/docs/walkthrough/phase-1/index.rst" class="reference internal">Phase 1: Logging, Cleaning, and Analyzing Your Data</a>
        *   <a href="docs/docs/walkthrough/phase-1/log-clean-analyze.md" class="reference internal">Phase 1: Logging, Cleaning, and Analyzing Your Data</a>
        *   <a href="docs/docs/walkthrough/phase-1/visualization.md" class="reference internal">Visualization and Monitoring</a>
    *   <a href="docs/docs/walkthrough/phase-2/index.rst" class="reference internal">Phase 2: Build a Manual System</a>
        *   <a href="docs/docs/walkthrough/phase-2/considerations.md" class="reference internal">Phase 2: Creating an Open Loop</a>
        *   <a href="docs/docs/walkthrough/phase-2/using-openaps-tools.md" class="reference internal">Configuring and Learning to Use openaps Tools</a>
        *   <a href="docs/docs/walkthrough/phase-2/building-preflight-safety-checks.md" class="reference internal">Building preflight and other safety checks</a>
        *   <a href="docs/docs/walkthrough/phase-2/Using-oref0-tools.md" class="reference internal">Add the oref0 Virtual Devices</a>
        *   <a href="docs/docs/walkthrough/phase-2/Using-oref0-tools.md#organizing-the-reports" class="reference internal">Organizing the reports</a>
        *   <a href="docs/docs/walkthrough/phase-2/Using-oref0-tools.md#the-get-profile-process" class="reference internal">The get-profile process</a>
        *   <a href="docs/docs/walkthrough/phase-2/Using-oref0-tools.md#the-calculate-iob-process" class="reference internal">The calculate-iob process</a>
        *   <a href="docs/docs/walkthrough/phase-2/Using-oref0-tools.md#the-determine-basal-process" class="reference internal">The determine-basal process</a>
        *   <a href="docs/docs/walkthrough/phase-2/Using-oref0-tools.md#adding-aliases" class="reference internal">Adding aliases</a>
        *   <a href="docs/docs/walkthrough/phase-2/Using-oref0-tools.md#checking-your-reports" class="reference internal">Checking your reports</a>
        *   <a href="docs/docs/walkthrough/phase-2/Using-oref0-tools.md#enacting-the-suggested-action" class="reference internal">Enacting the suggested action</a>
        *   <a href="docs/docs/walkthrough/phase-2/Using-oref0-tools.md#cleaning-cgm-data-from-minimed-cgm-systems" class="reference internal">Cleaning CGM data from Minimed CGM systems</a>
        *   <a href="docs/docs/walkthrough/phase-2/loop-and-retry-logic.md" class="reference internal">Running an open loop with oref0</a>
    *   <a href="docs/docs/walkthrough/phase-3/index.rst" class="reference internal">Phase 3: Automation</a>
        *   <a href="docs/docs/walkthrough/phase-3/considerations.md" class="reference internal">Phase 3: Understanding Your Open Loop</a>
        *   <a href="docs/docs/walkthrough/phase-3/Understand-determine-basal.md" class="reference internal">Understanding the output of oref0-determine-basal</a>
    *   <a href="docs/docs/walkthrough/phase-4/index.rst" class="reference internal">Phase 4: Iterate and Improve</a>
        *   <a href="docs/docs/walkthrough/phase-4/considerations.md" class="reference internal">Phase 4: Starting to Close the Loop</a>
        *   <a href="docs/docs/walkthrough/phase-4/create-schedule.md" class="reference internal">Using cron to create a schedule for your loop</a>
        *   <a href="docs/docs/walkthrough/phase-4/Observing-closed-loop.md" class="reference internal">Observing the closed loop</a>
        *   <a href="docs/docs/walkthrough/phase-4/troubleshooting-loop.md" class="reference internal">Troubleshooting the closed loop</a>
    *   <a href="docs/docs/walkthrough/phase-5/index.rst" class="reference internal">Phase 5: Tuning the Closed Loop</a>
        *   <a href="docs/docs/walkthrough/phase-5/considerations.md" class="reference internal">Phase 5: Tuning the Closed Loop</a>
        *   <a href="docs/docs/walkthrough/phase-5/beyond-low-glucose-suspend.md" class="reference internal">Going beyond low glucose suspend mode</a>
        *   <a href="docs/docs/walkthrough/phase-5/tuning-targets.md" class="reference internal">Tuning your targets</a>
    *   <a href="docs/docs/walkthrough/phase-6/index.rst" class="reference internal">Phase 6: Iterate and Improve the Closed Loop</a>
        *   <a href="docs/docs/walkthrough/phase-6/considerations.md" class="reference internal">Phase 6: Iterating on Your Closed Loop</a>
        *   <a href="docs/docs/walkthrough/phase-6/keeping-up-to-date.md" class="reference internal">So you think you’re looping? Now keep up to date!</a>
        *   <a href="docs/docs/walkthrough/phase-6/daytime-testing.md" class="reference internal">Testing during the day</a>
        *   <a href="docs/docs/walkthrough/phase-6/advanced-features.md" class="reference internal">Advanced features</a>
        *   <a href="docs/docs/walkthrough/phase-6/Configure-Automatic-Sensitivity-Mode.md" class="reference internal">Configuring Automatic Sensitivity Mode</a>
-   <a href="docs/docs/Resources/index.rst" class="reference internal">Resources</a>
    *   <a href="docs/docs/Resources/my-first-pr.md" class="reference internal">Making your first PR (pull request)</a>
    *   <a href="docs/docs/Resources/technical-resources.md" class="reference internal">Technical Resources</a>
        *   <a href="docs/docs/Resources/technical-resources.md#raspberry-pi" class="reference internal">Raspberry Pi</a>
        *   <a href="docs/docs/Resources/technical-resources.md#git-and-github" class="reference internal">Git and GitHub</a>
        *   <a href="docs/docs/Resources/technical-resources.md#linux-shell-terminal" class="reference internal">Linux Shell / Terminal</a>
        *   <a href="docs/docs/Resources/technical-resources.md#python" class="reference internal">Python</a>
        *   <a href="docs/docs/Resources/technical-resources.md#useful-apps" class="reference internal">Useful Apps</a>
        *   <a href="docs/docs/Resources/technical-resources.md#markdown-gitbook" class="reference internal">Markdown & GitBook</a>
    *   <a href="docs/docs/Resources/troubleshooting.md" class="reference internal">Troubleshooting</a>
        *   <a href="docs/docs/Resources/troubleshooting.md#generally-useful-linux-commands" class="reference internal">Generally useful linux commands</a>
        *   <a href="docs/docs/Resources/troubleshooting.md#dealing-with-the-carelink-usb-stick" class="reference internal">Dealing with the CareLink USB Stick</a>
        *   <a href="docs/docs/Resources/troubleshooting.md#dealing-with-a-corrupted-git-repository" class="reference internal">Dealing with a corrupted git repository</a>
        *   <a href="docs/docs/Resources/troubleshooting.md#environment-variables" class="reference internal">Environment variables</a>
        *   <a href="docs/docs/Resources/troubleshooting.md#common-error-messages" class="reference internal">Common error messages</a>
    *   <a href="docs/docs/Resources/history.md" class="reference internal">OpenAPS Overview and Project History</a>
    *   <a href="docs/docs/Resources/other-projects.md" class="reference internal">Other People, Projects & Tools</a>
        *   <a href="docs/docs/Resources/other-projects.md#people" class="reference internal">People</a>
        *   <a href="docs/docs/Resources/other-projects.md#aps-diabetes-data-tools" class="reference internal">APS & Diabetes Data Tools</a>
    *   <a href="docs/docs/Resources/other-projects.md#commercial-aps-efforts" class="reference internal">Commercial APS Efforts</a>
    *   <a href="docs/docs/Resources/faq.md" class="reference internal">Frequently Asked Questions</a>
        *   <a href="docs/docs/Resources/faq.md#what-is-a-closed-loop" class="reference internal">What is a Closed Loop?</a>
        *   <a href="docs/docs/Resources/faq.md#what-does-an-openaps-closed-loop-look-like" class="reference internal">What does an OpenAPS closed loop look like?</a>
    *   <a href="docs/docs/Resources/glossary.md" class="reference internal">Glossary</a>
-   <a href="reference/index.rst" class="reference internal">Reference</a>
    *   <a href="reference/index.rst#manuals" class="reference internal">Manuals</a>
        *   <a href="reference/openaps/index.rst" class="reference internal">openaps</a>
        *   <a href="reference/oref0/index.rst" class="reference internal">oref0</a>
        *   <a href="reference/nightscout/index.rst" class="reference internal">Nightscout</a>
        *   <a href="reference/mm/index.rst" class="reference internal">mm</a>
    *   <a href="reference/index.rst#api" class="reference internal">API</a>
        *   <a href="api/index.rst" class="reference internal">API Reference</a>

