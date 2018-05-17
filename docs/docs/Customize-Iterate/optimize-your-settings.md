# Optimizing your settings

Once you've been looping, you may look at your graphs and wonder how to achieve different results. It takes some time to do, but optimziing your settings is one of the keys to improving things, once you have basic looping up and running.

Note: if you're not familiar with the approach of optimizing settings, it's very important to understand that you should only change ONE thing at a time, and observe the impact for 2-3 days before choosing to change or modify a setting (unless it's obviously a bad change that makes things worse). The human tendency is to turn all the knobs and change everything at once; but if you do so, then you may end up with further sub-optimal settings for the future. 

Think about this: when many people start looping, they often have too high basal and too low carb ratio or ISF. What this means is they're using basal insulin around mealtimes to compensate for not usually giving the amount of insulin needed for food. When you go on a DIY closed loop and the system begins to help with adjusting insulin for BGs, it can become apparent that settings need to be tweaked. Here are a series of general approaches you can take for optimizing your settings, with example patterns:

## Frequent negative IOB at the same time every day

Negative IOB happens when you are getting less insulin than your normal basal amount. We created Autotune to help deal with these situations and to automatically tune your basal rates for any recurring patterns where you need more or less basal. However, if you're not running autotune, and you're observing patterns of negative IOB (more than a day or two), indicating a trend, you may need to change your settings. Things to test include:

* Adjusting your DIA. In oref0 0.6.0 and beyond, regardless of what is in your pump, it will default to using a DIA of 5. It is also very common for OpenAPS users to have DIA of 6 or 7 set (in `preferences.json`)
* Basal rates are too high for the hours preceding the pattern of negative IOB.
* ISF is off. (Usually not this; start with testing and tweaking basals and DIA first)

## Hills and valleys / Peaks and troughs / Up and down patterns

Sometimes people observe "roller coasters" in their BG graph. Remember this is all relative - so a roller coaster to you of 20 points may not be a big deal (and a 50 point rise or drop is a roller coaster); to others, that bugs them. 

First, you should eliminate human behaviors that cause these. Usually, it's things like giving a traditional dose of "fast carbs" (sugar, glucose tabs, candy, etc.) that is more than needed for a low or a pending low. Remember the system is reducing insulin, and so you often need way less carbs to deal with a low. As a result, you may rise afterward. That's a human-driven rise that won't be fixed by changing settings; just behaviors. Ditto for human-driven drops; e.g. by rage bolusing or otherwise bolusing too much. A better approach is to set a low temporary target, which asks OpenAPS to do "more", but will still keep you in a safe range.

Human behaviors set aside, if you are still seeing hills and valleys in your BG graphs, consider the following:
* ISF is often off. You may want to change your ISF. Remember, make small changes (say, 2-5 points for mg/dl, and .5 or less for mmol) and observe over 2-3 days. 




