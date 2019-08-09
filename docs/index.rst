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

.. DANGER:: 
   **IMPORTANT SAFETY NOTICE**

   The foundation of OpenAPS safety features discussed in this documentation are built on the safety features of the hardware used to build your system. It is critically important that you only use a tested, fully functioning FDA or CE approved insulin pump and CGM for closing an automated insulin dosing loop. Hardware or software modifications to these components can cause unexpected insulin dosing, causing significant risk to the user. If you find or get offered broken, modified or self-made insulin pumps or CGM receivers, *do not use* these for creating an OpenAPS system.
   
   Additionally, it is equally important to only use original supplies such as inserters, cannulas and insulin containers approved by the manufacturer for use with your pump or CGM. Using untested or modified supplies can cause CGM inaccuracy and insulin dosing errors. Insulin is highly dangerous when misdosed - please do not play with your life by hacking with your supplies.

.. toctree::
   :maxdepth: 2
   :glob:
   :hidden:

   Understanding OpenAPS (Overview) <docs/Understanding OpenAPS-Overview/index>
   
   Gear Up <docs/Gear Up/index>
   
   While You Wait For Gear <docs/While You Wait For Gear/index>
    
   Build your rig <docs/Build Your Rig/index>

   Customize-Iterate <docs/Customize-Iterate/index>
   
   Troubleshooting <docs/Troubleshooting/index>

   Give Back - Pay it Forward <docs/Give Back-Pay It Forward/index>
   
   Resources <docs/Resources/index>


