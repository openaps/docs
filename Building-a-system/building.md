# Building an OpenAPS Implementation

This section describes how to go from using the openaps tools in isolation to building your own OpenAPS implementation. For a number or reasons, this document can neither provide explicit instructions on how to construct a functional artificial pancreas nor recommend that you use the openaps tools for dosing insulin. What can be provided is an approach that can help guide this transition through a series of phases. 

In each phase, I'm looking to accomplish a set of goals as well as gain some further abilities to contribute back to the OpenAPS community. For me, there are five phases:

* Phase 0: Initial Setup
* Phase 1: Data Collection
* Phase 2: Recommendation Engine
* Phase 3: Closing the Loop
* Phase 4: Getting Fancy



### Phase 0: Initial Setup

* Upon Completion
    * Possess hardware and software tools necessary to build an OpenAPS implementation
    * Have gone through the setup process and be able to help others do the same


* Phase Tasks
    * Procure hardware
    * Download and install software and tools
    * Test a subset of tools to make sure they work as expected
    
* Community Contribution
    * Provide feedback on ...
        * Hardware procurement (cheap deals, alternatives)
        * Difficulties with installation process (‘this looked different on my system” or “I couldn’t locate that menu” or “I ran into this error”)
        * Solutions to overcome setup difficulties, especially for systems that are not yet covered (some different flavor of Linux, for example)
    * Help edit instructions for Phase 0 for accuracy, coverage, ease of understanding

### Phase 1: Data Collection
Phase 1 focuses on accessing, logging, cleaning up, and analyzing data from the pump and CGM.

* Upon Completion
    * Be able to download, record, and recall data logs from pump and CGM
    * Be able to download “real time” data
    * Have data being sent via wireless connection to a cloud database for user access
    * Have built a system able to collect data and be able to help others do the same


* Phase Tasks
    * Use tools to download data from pump and CGM
    * Log data for future analysis, use in algorithms
    * Ensure fidelity and accuracy of recorded readings
    * Test edge cases
    * Log data “in real time” to test hardware functionality
    * Set up cloud database to accept uploaded data (optional)
    * Have logged data syncing to cloud database


* Community Contribution
    * Provide feedback on ...
        * Model-specific data issues (e.g. Medtronic 722 v 723)
        * Using software tools
        * Following guides to accomplish above phase tasks
    * Help edit instructions for Phase I
    * Provide improved or alternative implementations

Phase II: Recommendation Engine

Upon Completion
Have a set of algorithms designed to control blood glucose via temp basals
Have patient-specific inputs required for these algorithms
Have those algorithms coded so as to take the data collection built in Phase I as input
Have the code output recommendations as to how it would change temp basal rates
Have the ability to utilize code on real-time and historical data to evaluate efficacy
Have implemented, tested, and tuned one or more set of algorithms and be able to help others do the same
Phase Tasks
Research the different strategies for single-hormone closed loop systems
Complete relevant patient-specific studies to determine key inputs (e.g. carb absorption)
Code one or more of these strategies such that they can accept live and/or historic patient data and output suggestions for temp basal changes
Evaluate the efficacy of these algorithms by testing their suggestions against live and historic data
Iterate on the algorithms and their implementation to improve their output
Test cases of data corruption, lack of data, lack of connectivity, and other non-ideal operating conditions
Community Contributions
Provide feedback on ...


Help edit instructions for Phase II
Provide results of testing for comparing and contrasting with others
Summarize research findings and synthesize them into jump-off points for others' research
Phase III: Close the Loop

I won't bother go into the details here as they aren't relevant to the write-up I'm suggesting
Phase IV: Gild the Lily

This is all the awesome stuff that everyone dreams of (and is certainly worthwhile) but tends to distract in the early stages; again, I won't jump into this at the moment
