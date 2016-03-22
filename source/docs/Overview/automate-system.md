# Phase 3: Automate your system

Phase 3 focuses on creating a schedule to collect data from the pump and cgm, calculate IOB and a temp basal suggestion, and then enact that on the pump. Again, at this stage testing is critical and output of the system should be tracked and validated over a series of time, and include thorough edge case testing.

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

