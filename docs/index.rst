Welcome to OpenAPS's documentation!
==============================================

This documentation supports a self-driven Do-It-Yourself (DIY) implementation of an artificial pancreas based on the OpenAPS reference design. By proceeding to use these tools or any piece within, you agree to `the copyright <https://github.com/openaps/docs/blob/master/license.txt>`_ for more information; and `the full README here <https://github.com/openaps/docs/blob/master/README.md>`_ and release any contributors from liability, and assume full responsibility for all of your actions and outcomes related to usage of these tools or ideas.

.. WARNING:: 
Note: *We do not recommend using a PDF version of this guide. The docs are updated continuously, and with a PDF, you will not get the freshest real-time edits. Be aware if you download a PDF that when you have Internet connectivity, we recommend instead having the docs pulled up in an Internet browser so you can refresh. This is especially true if you are working on a setup over the course of multiple days.*

.. note:: 
   **A Note on DIY and the "Open" Part of OpenAPS**
   
   This is a set of development tools to support a self-driven DIY implementation. Any person choosing to use these tools is solely responsible for testing and implementing these tools independently or together as a system.
   
   The DIY part of OpenAPS is important. While formal training or experience as an engineer or a developer is not a prerequisite, a growth mindset is required to learn to work with the "building blocks" that will help you develop your OpenAPS instance. Remember as you consider this project that this is not a "set and forget" system; an OpenAPS implementation requires diligent and consistent testing and monitoring to ensure each piece of the system is monitoring, predicting, and controlling as desired. The performance and quality of your system lies solely with you.
   
   This community of contributors believes in "paying it forward," and individuals who are implementing these tools are asked to contribute by asking questions, helping improve documentation, and contributing in other ways. Have questions? Hop into `Gitter <https://gitter.im/nightscout/intend-to-bolus>`_ and ask anytime!


.. toctree::
   :maxdepth: 2
   :glob:
   :caption: Understanding OpenAPS (Overview)

   How OpenAPS works <docs/UnderstandingOpenAPS-Overview/how-openaps-works-overview>
   How this guide works/overview of steps <docs/UnderstandingOpenAPS-Overview/overview-of-build-process>
   Where to go for help <docs/UnderstandingOpenAPS-Overview/communication-support-channels>
   
.. toctree::
   :maxdepth: 2
   :glob:
   :caption: GearUp

   docs/GearUp/hardware
   Compatible Pumps <docs/GearUp/pump>
   Compatible CGMs <docs/GearUp/CGM>
   Get your rig parts <docs/GearUp/edison> 
   
.. toctree::
   :maxdepth: 2
   :glob:
   :caption: WhileYouWaitForGear
   
   Collect your data & prepare <docs/WhileYouWaitForGear/collect-data-and-prepare>
   Make Your First PR <docs/WhileYouWaitForGear/loops-in-progress>
   Setting up Nightscout  <docs/WhileYouWaitForGear/nightscout-setup>
   Understand your Explorer Board rig <docs/WhileYouWaitForGear/understanding-your-Explorer-Board-rig>
   Understand determine-basal (OpenAPS math) <docs/WhileYouWaitForGear/Understand-determine-basal>
   Monitoring OpenAPS <docs/WhileYouWaitForGear/monitoring-OpenAPS>
   Preferences and Safety Settings <docs/WhileYouWaitForGear/preferences-and-safety-settings>
   Understanding your wifi options <docs/WhileYouWaitForGear/understanding-wifi-options>
   
.. toctree::
   :maxdepth: 1
   :glob:
   :caption: BuildYourRig
    
   Installing OpenAPS <docs/BuildYourRig/OpenAPS-install>
   512/712 pump users <docs/BuildYourRig/x12-users>
   Tell us you’re looping <docs/BuildYourRig/keeping-up-to-date>


.. toctree::
   :maxdepth: 2
   :glob:
   :caption: Customize-Iterate

   Enable Bluetooth tethering <docs/Customize-Iterate/bluetooth-tethering-edison>
   IFTTT and Pebble buttons <docs/Customize-Iterate/ifttt-integration>
   Autosens <docs/Customize-Iterate/autosens>
   Autotune <docs/Customize-Iterate/autotune>
   Understanding Autotune <docs/Customize-Iterate/understanding-autotune>
   oref1: SMB and UAM <docs/Customize-Iterate/oref1>
   Offline Looping <docs/Customize-Iterate/offline-looping-and-monitoring>
   Add more wifi to your rig <docs/Customize-Iterate/on-the-go-wifi-adding>
   Useful mobile apps </docs/Customize-Iterate/useful-mobile-apps>
   Tips & tricks <docs/Customize-Iterate/usability-considerations>
   Update your rig in the future <docs/Customize-Iterate/update-your-rig>
   How to run oref0-setup.sh again <docs/Customize-Iterate/oref0-runagain>

.. toctree::
   :maxdepth: 2
   :glob:
   :caption: Troubleshooting
   
   Troubleshooting oref0-setup <docs/Troubleshooting/oref0-setup-troubleshooting>
   General linux troubleshooting <docs/Troubleshooting/General_linux_troubleshooting>
   Pump-rig troubleshooting <docs/Troubleshooting/Pump-rig-communications-troubleshooting>
   CGM-rig troubleshooting <docs/Troubleshooting/CGM-rig-communications-troubleshooting>
   Rig-NS troubleshooting <docs/Troubleshooting/Rig-NS-communications-troubleshooting>

.. toctree::
   :maxdepth: 2
   :glob:
   :caption: GiveBack-PayItForward

   Donate your data <docs/GiveBack-PayItForward/data-commons-data-donation>
   Help others - pay it forward <docs/GiveBack-PayItForward/contribute>

.. toctree::
   :maxdepth: 2
   :glob:
   :caption: Resources/Reference
   
   Resources <docs/Resources/index>
