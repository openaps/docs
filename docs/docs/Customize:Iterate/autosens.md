{\rtf1\ansi\ansicpg1252\cocoartf1348\cocoasubrtf170
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

\f0\fs24 \cf0 # Auto-sensitivity mode (Autosens)\
\
Wouldn't it be great if the system knew when you were running sensitive or resistant? That's what we thought, so we created "auto-sensitivity mode". If you explicitly configure this additional feature (again by enabling it through advanced features in setup script), it will allow the system to analyze historical data on the go and make adjustments if it recognizes that you are reacting more sensitively (or conversely, more resistant) to insulin than usual. It will then make temporary adjustments to the basal, ISF, and targets used for calculating temp basals, in order to keep BG closer to your configured target.\
\
When you watch your loop run in the logs and sensitivity changes is going to be detected, you might see something like this:\
\
`-+>>>>>>>>>>>>+++->->+++>++>>+>>>>>>>>++-+>>>>>>>-+++-+--+>>>>>>>>>>>>>>>>>>>>>>>>>++-++++++--++>>>++>>++-++->++-+++++++>+>>>>>>>>>>>>>>>>>++-+-+-+--++-+--+++>>>>>>++---++----+---++-+++++>>>++------>>>++---->>+++++--+++-++++++++--+--+------++++++++++>>>>++--+->>>>>>>>>>++++-+-+---++++ 34% of non-meal deviations negative (target 45%-50%)\
Excess insulin resistance detected: ISF adjusted from 100 to 73.52941176470588`\
\
Here's what each symbol above means:\
\
 ">" : deviation from BGI was high enough that we assume carbs were being absorbed, and disregard it for autosens purposes\
\
 "+" : deviation was above what was expected\
\
 "-" : deviation was below what was expected\
\
 "=" : BGI is doing what we expect\
\
### Notes about autosensitivity:\
\
* "Autosens" works by reviewing the last 24 hours of data (so it's a rolling calculation with a moving window of 24 hours) and assessing deviations to determine if you are more sensitive or resistant than expected. If a pattern of such deviations is detected, it will calculate the adjustment that would've been required to bring deviations back to normal.\
* Autosens does NOT take into account meal/carb deviations; it only is able to assess the impact of insulin, and thus will adjust ISF, basals, and targets to help compensate for changes in sensitivity.\
* Most users will notice the changed ISF numbers in their OpenAPS pill, along with changed targets. Note that a temp target will override the autosens-adjusted target. If you do not want autosens to adjust targets, that can be turned off via a setting in preferences.json\
* The reason for autosens automatically adjusting targets is because the other adjustments it makes can't be fully applied without creating a feedback loop, so automatically adjusting the target it thinks it's shooting for lets autosens get BG closer to your actual target most of the time. When autosens needs to adjust basal and ISF, it can very straightforwardly use that for adjusting the temp basal it's about to set, by assuming a higher or low neutral temp basal to start from, and by calculating a bigger or smaller expected impact of current IOB. What it can't do is calculate IOB in a way that reflects the adjusted basals and ISF, because doing so would change the autosens result, which would require recalculating IOB again, which would further change the result, in an unpredictable feedback loop. So instead, we simply acknowledge that the IOB calculation doesn't reflect sensitivity or resistance, and instead adjust the target to compensate. \
* Autosens is limited by the safety multipliers in preferences.json. We do not recommend widening these multipliers; but an easy way to turn "off" autosens after you've enabled it is so adjust the safety multipliers to 1. However, note that this will also disable autotune adjustments if you are running autotune. \
}