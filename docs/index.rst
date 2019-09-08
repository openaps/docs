Welcome to OpenAPS's documentation!
==============================================

This documentation supports a self-driven Do-It-Yourself (DIY) implementation of an artificial pancreas based on the OpenAPS reference design. By proceeding to use these tools or any piece within, you agree to `the copyright <https://github.com/openaps/docs/blob/master/license.txt>`_ for more information; and `the full README here <https://github.com/openaps/docs/blob/master/README.md>`_ and release any contributors from liability, and assume full responsibility for all of your actions and outcomes related to usage of these tools or ideas.

.. note:: 
   **A Note on DIY and the "Open" Part of OpenAPS**
   
   This is a set of development tools to support a self-driven DIY implementation. Any person choosing to use these tools is solely responsible for testing and implementing these tools independently or together as a system.
   
   The DIY part of OpenAPS is important. While formal training or experience as an engineer or a developer is not a prerequisite, a growth mindset is required to learn to work with the "building blocks" that will help you develop your OpenAPS instance. Remember as you consider this project that this is not a "set and forget" system; an OpenAPS implementation requires diligent and consistent testing and monitoring to ensure each piece of the system is monitoring, predicting, and controlling as desired. The performance and quality of your system lies solely with you.
   
   This community of contributors believes in "paying it forward," and individuals who are implementing these tools are asked to contribute by asking questions, helping improve documentation, and contributing in other ways. Have questions? Hop into `Gitter <https://gitter.im/nightscout/intend-to-bolus>`_ and ask anytime!

.. DANGER:: 
   **IMPORTANT SAFETY NOTICE**

   The foundation of OpenAPS safety features discussed in this documentation are built on the safety features of the hardware used to build your system. It is critically important that you only use a tested, fully functioning FDA or CE approved insulin pump and CGM for closing an automated insulin dosing loop. Hardware or software modifications to these components can cause unexpected insulin dosing, causing significant risk to the user. If you find or get offered broken, modified or self-made insulin pumps or CGM receivers, *do not use* these for creating an OpenAPS system.
   
   Additionally, it is equally important to only use original supplies such as inserters, cannulas and insulin containers approved by the manufacturer for use with your pump or CGM. Using untested or modified supplies can cause CGM inaccuracy and insulin dosing errors. Insulin is highly dangerous when misdosed - please do not play with your life by hacking with your supplies.



.. toctree::
   :maxdepth: 2
   :glob:
   :hidden:
   :caption: Overview

   How OpenAPS works <docs/Understanding OpenAPS-Overview/how-openaps-works-overview>
   Overview of steps <docs/Understanding OpenAPS-Overview/overview-of-build-process>
   Using this documentation <docs/Understanding OpenAPS-Overview/using-the-docs>
   Where to go for help <docs/Understanding OpenAPS-Overview/communication-support-channels>
   
.. toctree::
   :maxdepth: 2
   :glob:
   :hidden:
   :caption: Hardware
   
   Overview <docs/Gear Up/hardware-overview>
   Compatible Pumps <docs/Gear Up/pump>
   Compatible CGMs <docs/Gear Up/CGM>
   Your rig hardware options <docs/Gear Up/rig-options> 
   Edison rigs <docs/Gear Up/edison-explorer-board> 
   Raspberry Pi rigs <docs/Gear Up/pi-based-rigs> 
   
.. toctree::
   :maxdepth: 2
   :glob:
   :hidden:
   :caption: Getting ready
   
   Set up Nightscout  <docs/While You Wait For Gear/nightscout-setup>
   Collect your data & prepare <docs/While You Wait For Gear/collect-data-and-prepare>
   Make your first PR <docs/While You Wait For Gear/loops-in-progress>
   Do some reading <docs/While You Wait For Gear/reading-list>
   
.. toctree::
   :maxdepth: 2
   :glob:
   :hidden:
   :caption: Installing OpenAPS
   
   Overview <docs/Build Your Rig/install-overview>
   Step 1: Flashing<docs/Build Your Rig/step-1-flashing>
   Step 2: Wifi and dependencies <docs/Build Your Rig/step-2-wifi-dependencies>
   Step 3: Setup script <docs/Build Your Rig/step-3-setup-script>
   Step 4: Watching logs <docs/Build Your Rig/step-4-watching-log>
   Step 5: Finishing setup <docs/Build Your Rig/step-5-finishing-setup>
   Logging into the rig using a serial connection <docs/Build Your Rig/logging-into-rig-serial>
   
   
.. toctree::
   :maxdepth: 2
   :glob:
   :hidden:
   :caption: How OpenAPS works
   
   How OpenAPS makes decisions  <docs/How it works/understand-determine-basal>
   Insulin on board calculations <docs/How it works/understanding-insulin-on-board-calculations>
   Understanding Autotune <docs/How it works/understanding-autotune>
   Running Autotune <docs/How it works/autotune>
   Using Autosens <docs/How it works/autosens>
   
.. toctree::
   :maxdepth: 2
   :glob:
   :hidden:
   :caption: Usage and maintenance 
   
	How to enter carbs and boluses <docs/Usage and maintenance/entering-carbs-bolus>
   Preferences and safety settings <docs/Usage and maintenance/preferences-and-safety-settings>
   Monitoring OpenAPS <docs/Usage and maintenance/monitoring-OpenAPS>
   Using your loop: common situations <docs/Usage and maintenance/usability-considerations>
   Optimizing your settings <docs/Usage and maintenance/optimize-your-settings>
   How to run oref0-setup.sh again <docs/Usage and maintenance/oref0-runagain>
   Update your rig in the future <docs/Usage and maintenance/update-your-rig>
   Wifi overview <docs/Usage and maintenance/Wifi/understanding-wifi-options>
   Adding wifi networks to your rig <odocs/Usage and maintenance/Wifi/n-the-go-wifi-adding>
   Bluetooth tethering <docs/Usage and maintenance/Wifi/bluetooth-tethering-edison>
   
   
.. toctree::
   :maxdepth: 2
   :glob:
   :hidden:
   :caption: Customizing and extra features
   
   oref1: SMB and UAM <docs/Customize-Iterate/oref1>
   Useful apps for accessing your rig <docs/Customize-Iterate/useful-mobile-apps>
   IFTTT and Pebble buttons <docs/Customize-Iterate/ifttt-integration>
   Offline Looping <docs/Customize-Iterate/offline-looping-and-monitoring>

.. toctree::
   :maxdepth: 2
   :glob:
   :hidden:
   :caption: Troubleshooting
   
   Overview and Linux reference <docs/Troubleshooting/General_linux_troubleshooting>
   oref0-setup Troubleshooting<docs/Troubleshooting/oref0-setup-troubleshooting
   Common error messages <docs/Troubleshooting/Common-error-messages>
   Wifi and hotspot issues <docs/Troubleshooting/Wifi-and-hotspot-issues>
   Pump-rig communications troubleshooting <docs/Troubleshooting/Pump-rig-communications-troubleshooting>
   CGM-rig communications troubleshooting <docs/Troubleshooting/CGM-rig-communications-troubleshooting>
   NS-rig communications troubleshooting<docs/Troubleshooting/Rig-NS-communications-troubleshooting>
   Medtronic button errors <docs/Troubleshooting/Medtronic-Button-Errors>
   Carelink troubleshooting <docs/Troubleshooting/Carelink>

.. toctree::
   :maxdepth: 2
   :glob:
   :hidden:
   :caption: Give Back-Pay It Forward

   Donate your data <docs/Give Back-Pay It Forward/data-commons-data-donation>
   Help others - pay it forward <docs/Give Back-Pay It Forward/contribute>

.. toctree::
   :maxdepth: 2
   :glob:
   :hidden:
   :caption: Resources/Reference
   
   For Clinicians <docs/Resources/clinician-guide-to-OpenAPS>
   History <docs/Resources/history>
   Glossary <docs/Resources/glossary>
   Making a PR <docs/Resources/my-first-pr>
   Technical resources <docs/Resources/technical-resources>
   Switching between DIY systems <docs/Resources/switching-between-DIY-systems>
   <docs/Resources/Deprecated: Pi Hardware info <Deprecated-Pi/Pi-hardware>
   <docs/Resources/Deprecated: Pi Setup info <Deprecated-Pi/Pi-setup>






