# Optimizing your settings

Once you've been looping, you may look at your graphs and wonder how to achieve different results. It takes some time to do, but optimizing your settings is one of the keys to improving things, once you have basic looping up and running.

Note: if you're not familiar with the approach of optimizing settings, it's very important to understand that you should only change ONE thing at a time, and observe the impact for 2-3 days before choosing to change or modify another setting (unless it's obviously a bad change that makes things worse, in which case you should revert immediately to your previous setting). The human tendency is to turn all the knobs and change everything at once; but if you do so, then you may end up with further sub-optimal settings for the future, and find it hard to get back to a known good state. 

Think about this: when many people start looping, they often have too high basal and too low carb ratio or ISF. What this means is they're using basal insulin around mealtimes to compensate for not usually giving the amount of insulin needed for food. When you go on a DIY closed loop and the system begins to help with adjusting insulin for BGs, it can become apparent that settings need to be tweaked. Here are a series of general approaches you can take for optimizing your settings, with example patterns:

## Using Autotune

The most powerful tool at your disposal for adjusting settings is Autotune, which you can run nightly as part of your loop, and which will automatically start adjusting your basals, carb ratio, and ISF based on observed trends.  If your pump settings are too far from what autotune thinks is necessary, it won't be able to adjust further without some manual action on your part, so you'll want to review autotune's recommendations periodically and consider adjusting pump settings in the recommended direction.  As noted before, it's best to change things gradually, and observe the results before changing additional settings.

In oref0 0.6.0 and beyond, autotune runs every night on your rig automatically. You can `cat-autotune` to view your autotune recommendations log. ([More about Autotune in the docs here](http://openaps.readthedocs.io/en/latest/docs/Customize-Iterate/autotune.html).)

## Frequent negative IOB at the same time every day

Negative IOB happens when you are getting less insulin than your normal basal amount. We created [Autotune](http://openaps.readthedocs.io/en/latest/docs/Customize-Iterate/autotune.html) to help deal with these situations and to automatically tune your basal rates for any recurring patterns where you need more or less basal. However, if you're not running autotune, and you're observing patterns of negative IOB (for more than a day or two in a row), indicating a trend, you may need to change your settings. Things to test include:

* Adjusting your DIA. In oref0 0.6.0 and beyond, regardless of what is in your pump, it will default to using a DIA of 5. It is also very common for OpenAPS users to have DIA of 6 or 7 set (in `preferences.json`)
* Basal rates are too high for the hours preceding the pattern of negative IOB.
* ISF is wrong. (Usually not this; start with testing and tweaking basals and DIA first.)

## Hills and valleys / Peaks and troughs / Up and down patterns

Sometimes people observe "roller coasters" in their BG graph. Remember this is all relative - to different people, BG rising and falling by 20 points may or may not be a big deal (but a 50 point rise or drop might feel like a roller coaster).

First, you should eliminate human behaviors that cause these. Usually, it's things like giving a traditional dose of "fast carbs" (such as 15g+ of sugar, glucose tabs, candy, etc.) that is more than needed for a low or a pending low. Remember the system is reducing insulin, and so you often need way fewer carbs to deal with a low, so you may rise afterward if you do too large of a carb correction. If you're unsure how large a carb correction is needed, OpenAPS has the ability to send carbsReq notifications via Pushover. Overcorrections like that generally can't be fixed by changing settings: you have to also change behaviors. Ditto for human-driven drops; e.g. by rage bolusing or otherwise bolusing too much when BG is high. A better approach is to set a low temporary target, which asks OpenAPS to do "more", but will still keep you in a safe range.

Human behaviors set aside, if you are still seeing hills and valleys in your BG graphs, consider the following:
* ISF may be off, so you may want to raise ISF to make corrections less aggressive. Remember, make small changes (say, 2-5 points for mg/dl, and .5 or less for mmol) and observe over 2-3 days. Before changing ISF or any other setting, check to see what autotune recommends.
* If you're seeing highs followed by lows after meals, CR may need adjusting. One common mistake is to compensate for rapid post-meal rises with a very aggressive (low) CR, which then causes subsequent low BG. One tool for preventing meal spikes include setting an "eating soon" low temp target before and/or right after a meal, to get more insulin started earlier, and then allow OpenAPS to reduce insulin once the temp target expires, to help prevent a post-meal low. Similarly, a small manual "eating soon" bolus up to an hour before a meal, or a larger prebolus right before a fast-carbs meal, can help match insulin timing to carb absorption without increasing the total amount of insulin delivered (and subsequently causing a post-meal low). ([Here are some tips on using temp targets](http://openaps.readthedocs.io/en/latest/docs/Customize-Iterate/usability-considerations.html#how-can-you-make-adjustments-to-insulin-delivery-while-on-the-go-optimizing-with-temporary-targets), and you can [use IFTTT to make it easy to enter them from your phone or watch or device of choice](http://openaps.readthedocs.io/en/latest/docs/Customize-Iterate/ifttt-integration.html).)


