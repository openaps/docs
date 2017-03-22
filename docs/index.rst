Welcome to OpenAPS's documentation!
==============================================

This documentation support a self-driven Do-It-Yourself (DIY) implementation of an artificial pancreas based on the OpenAPS reference design. By proceeding to use these tools or any piece within, you agree to the copyright (see [LICENSE.txt](https://github.com/openaps/docs/blob/master/license.txt) for more information; and [the full README here[(https://github.com/openaps/docs/blob/master/README.md) and release any contributors from liability, and assume full responsibility for all of your actions and outcomes related to usage of these tools or ideas.

*A Note on DIY and the "Open" Part of OpenAPS*

This is a set of development tools to support a self-driven DIY implementation. Any person choosing to use these tools is solely responsible for testing and implementing these tools independently or together as a system.

The DIY part of OpenAPS is important. While formal training or experience as an engineer or a developer is not a prerequisite, a growth mindset is required to learn to work with the "building blocks" that will help you develop your OpenAPS instance. Remember as you consider this project that this is not a "set and forget" system; an OpenAPS implementation requires diligent and consistent testing and monitoring to ensure each piece of the system is monitoring, predicting, and controlling as desired. The performance and quality of your system lies solely with you.

This community of contributors believes in "paying it forward," and individuals who are implementing these tools are asked to contribute by asking questions, helping improve documentation, and contributing in other ways. Have questions? Hop into [Gitter](https://gitter.im/nightscout/intend-to-bolus) and ask anytime!



.. toctree::
   :maxdepth: 2
   :glob:
   :caption: Before You Begin

   docs/introduction/index
   docs/introduction/understand-this-guide
   docs/introduction/contribute
   docs/introduction/communication-support-channels
   
.. toctree::
   :maxdepth: 2
   :glob:
   :caption: General Setup
   
   docs/walkthrough/phase-0/index
   docs/walkthrough/phase-0/setup
   docs/walkthrough/phase-0/baseline-data
   docs/walkthrough/phase-0/hardware/hardware
   docs/walkthrough/phase-0/hardware/pump
   docs/walkthrough/phase-0/hardware/CGM
   docs/walkthrough/phase-0/hardware/edison
   docs/walkthrough/phase-0/setup-edison
   docs/walkthrough/phase-0/edison-explorer-board-Mac
   docs/walkthrough/phase-0/loops-in-progress
   
   
.. toctree::
   :maxdepth: 2
   :glob:
   :caption: Visualizing & Monitoring
   
   docs/walkthrough/phase-1/index
   docs/walkthrough/phase-1/nightscout-setup
   docs/walkthrough/phase-1/offline-looping-and-monitoring
   docs/walkthrough/phase-1/papertrail
   docs/walkthrough/phase-1/add-alias
   
.. toctree::
   :maxdepth: 2
   :glob:
   :caption: Creating your DIY Closed Loop
    
   docs/walkthrough/phase-2/oref0-setup
   docs/walkthrough/phase-2/troubleshoot-oref0-setup
   docs/walkthrough/phase-2/accessing-your-rig
   docs/walkthrough/phase-2/on-the-go-wifi-adding
   docs/walkthrough/phase-2/update-your-rig
   
.. toctree::
   :maxdepth: 2
   :glob:
   :caption: Understanding Your Loop and Tweaking Settings
   
   # docs/walkthrough/phase-3/index  
   docs/walkthrough/phase-3/Understand-determine-basal
   docs/walkthrough/phase-3/beyond-low-glucose-suspend

.. toctree::
   :maxdepth: 2
   :glob:
   :caption: Advanced Features 
   
   docs/walkthrough/phase-4/index  
   docs/walkthrough/phase-4/Usability-considerations
   docs/walkthrough/phase-4/keeping-up-to-date
   docs/walkthrough/phase-4/advanced-features
   docs/walkthrough/phase-4/bluetooth-tethering-edison
   docs/walkthrough/phase-4/ifttt-integration
   docs/walkthrough/phase-4/autotune
   docs/walkthrough/phase-4/data-commons-data-donation

.. toctree::
   :maxdepth: 2
   :glob:
   :caption: Resources/Reference
   
   Resources <docs/Resources/index>
   reference/index





Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

