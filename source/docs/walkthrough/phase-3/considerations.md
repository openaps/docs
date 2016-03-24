# Phase 3: Automate Your System

Phase 3 focuses on creating a schedule to automate the manual system you developed in [Phase 2](../../docs/Build-manual-system/considerations.md). Again, at this stage testing is critical and output of the system should be tracked and validated over a series of time, and include thorough edge case testing as you move from communicating with the pump and CGM to closing the loop. If you haven't already, it's helpful to consider this experience as a set of experiments. For experimenting, you'll need to have plenty of time (and patience) to track what the loop is doing; what you think it should do; and what is needed to bring your BG up/down and decide if you need to intervene. 

At this stage, you should have a suitable algorithm to manually recommend necessary changes to basal rates that you have tested thoroughly. That was essentially a practice closed-loop system, with you completing the loop by manually calculating what you would do in that scenario. Now, you're ready to automate your loop. This section focuses on [creating a schedule](create-schedule.md) to collect data from the pump and cgm, calculate IOB and a temp basal suggestion, and then enact that on the pump. Again, at this stage testing is critical and output of the system should be tracked and [validated](validate-output.md) over a series of time, and include thorough edge case testing to ensure that the loop is working, the schedule is as designed, and that you can quick-check when the system is running and trouble shoot any runtime challenges. You will likely also want to [visualize](vizualization.md) what the system is doing.

Once you get the loop automated, you should set an alarm and check your glucose levels every 15-30 minutes and continue to watch the system closely. You should not test overnight until you are supremely confident in the operation of the system! And you should probably have someone committed to watching your response while you sleep, and alarms to ensure that everything goes as planned.

	* Upon Completion
		* Have a schedule to run a set of algorithms designed to keep blood glucose in target range with temp basals
		* Have repeatedly validated the output of your scheduled work  and understand how to quick-check whether the system is running and what the current outputs are, plus trouble shoot any runtime challenges.

	* Phase Tasks
		* Create schedule to collect & validate input data, calculate IOB, generate temp basal suggestion, prepare to enact (utilizing crontab)
		* Carefully analyze output and outcomes from the scheduled system over a series of time
		* Test at least these cases: data corruption, lack of data, lack of connectivity, and other non-ideal operating conditions

	* Community Contributions
		* Provide feedback on efficacy of algorithms
		* Help edit instructions for Phase 3
		* Provide results of testing (including start date for first overnight evaluation, please share with Dana) for comparing and contrasting with others
		* Summarize research findings and synthesize them into jump-off points for others' research


# Summary

* [Phase 3: Automate Your System](../../docs/Automate-system/considerations.md)
   * [Creating a Schedule](../../docs/Automate-system/create-schedule.md)
   * [Visualization and Monitoring](../../docs/Automate-system/vizualization.md)
   * [Validating and Testing](../../docs/Automate-system/validate-output.md)
   * [Keeping up to date](../../docs/Automate-system/keeping-up-to-date.md)
