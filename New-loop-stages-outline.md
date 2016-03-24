Introduction
* Table of Contents
* Understanding This Guide
* Ways to Contribute
* Where to Go For Help With Your Implementation

Stage 0: General Setup and Project Prep
* Hardware & Equipment You Need 
 * pulling in hardware alternatives from ‘iterating and improving’, make this page overall more easy to read
* Storing Baseline Data
* Setting Up Your Raspberry Pi or other devices
* Setting Up openaps and dependencies

Stage 1: Logging, Cleaning, Analyzing Data
* Setting up visualization and monitoring
 * Include NS related alerts and openaps system alerts for looping/not
 *DIYPS style net basal insulin reports should get added to NS reports
* Setup script 
 * github.com/openaps/oref0/blog/master/bin/ns-uploader-setup.sh with some tweaks)
* Analyze your existing data 
 * basals & ISF, use NS report or Dex Studio/Clarity, whatever people prefer

Stage 2: Creating an Open Loop
* Configuring and learning to use openaps tools
 * much of this covered by script, so mostly pulling suggest and enact from old version
* Running an open loop with oref0 
 * most of the content previously from creating loop and retry logic
* Building preflight and other checks

Stage 3: Understanding Your Open Loop
* Determining basal recommendations
 * https://github.com/openaps/docs/blob/dev/docs/Build-manual-system/Understand-determine-basal.md 
 * Run for enough days to decide what max basal should be
 * How often did you disagree or counteract what the loop was recommending?

Stage 4: Starting to Close the Loop
* Cron instructions (or daemon)
 * this is obviously new and needs a lot of thought/contributions
* Observing the closed loop
 * Starts with LGS mode only
 * Don’t move forward until observed for 3 days
 * If any consistent net negative low insulin amounts (check  NS reports), then you may be overbolusing for meals and/or basals are too high 1.5-2 hours before the lows are occurring.
* Troubleshooting the closed loop
 * Info from validating & testing

Stage 5: Tuning the Closed Loop
* Going beyond low glucose suspend mode
 * (moving beyond max iob = 0)
* Tuning your targets
 * After 3 days, at least one night with zero low alarms should occur before you consider dropping the max target from 160.
 * Only drop 10 points at a time, again observing the outcomes over a few days. 
 * If going low three+ days, the “min” target may need to be raised

Stage 6: Iterating on the Closed Loop
* So you think you’re looping
 * 3 nights consecutively with no major system problems and at least 1 night without low alarms – fill out form and get number
* Tests for when you are running for 24 hours 
 * Run 24 hours for 3 days (doesn’t have to be consecutive) to get a feel for how the system behaves when you do meal boluses with the system on
 * Observe again net basal insulin delivery after 1 week of looping; see times of day when the system gives net negative; again, may be overbolusing and/or basals too high
* Enabling meal-assist and other advanced features
 * First, regular carb entry required (so don’t accidentally trigger wtf-assist after meal-assist & co are enabled
 * Confirm 1 week successful daytime looping
 * Enable meal-assist & co to enable more aggressive high temps (setup script)
 * Understanding the –assist features & how it works
 * Close observation for a week

Resources
* #OpenAPS overview & history
* General technical resources
* Troubleshooting tips
* FAQs
* Other people, projects, and tools to check out
* Glossary
