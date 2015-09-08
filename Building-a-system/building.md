# Building an OpenAPS Implementation

This section describes how to go from [learning to use the openaps tools in isolation](../Using-openaps-Tools/using.md) (<--make sure you've learned to use the tools first!) to building your own OpenAPS implementation. For a number of reasons, this document can neither provide explicit instructions on how to construct a functional artificial pancreas nor recommend that you use the openaps tools for dosing insulin. ([This is a good background on why, and why you might take a DIY approach](http://bit.ly/1NBbZtO) to building yourself new tools and revieiwng the phases below.) What can be provided instead is an approach that can help guide a user through a series of phases. 

In each phase, look to accomplish a set of goals relating to the functionality of your system as well as gain some further abilities to contribute back to the OpenAPS community. Five phases:


* [Phase 0: Initial Setup](../Building-a-system/initial-setup.md)<br>
Acquire and configuring hardware, install software, and become familiar with the openaps environment

* [Phase 1: Data Collection](../Building-a-system/data-collection.md)<br>
Build a system for logging and analyzing pump and CGM data

* [Phase 2: Recommendation Engine](../Building-a-system/recommendation-engine.md)<br>
Use the logged data to suggest insulin dosage adjustment, review and refine algorithms, test different scenarios for safety

* [Phase 3: Closing the Loop](../Building-a-system/closing-the-loop.md)<br>
Apply the recommendations, automatically and in real time

* [Phase 4: Getting Fancy](../Building-a-system/getting-fancy.md)<br>
Improve the functionality of the implementation with additional software or hardware development

The document subsection for each phase has three components outlined:
* Upon Completion<br>
The capabilities that the user and system should have after completing the phase  

* Phase Tasks<br>
Tasks or steps to take during the phase

* Community Contribution
Ways that a user should be able to contribute to the #OpenAPS project and/or openaps tool set during and after the phase

These phase descriptions are purely suggestive and are by no means a required method for building an OpenAPS implementation. They serve as one possible path to step through the development process in a structured way.

