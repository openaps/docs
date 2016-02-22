#Understanding the output of oref0-determine-basal

The key logic behind any oref0 implementation of OpenAPS lies in the oref0-determine-basal.js code, which is what takes all of the inputs you've collected and makes a temp basal recommendation you can then enact if appropriate.  As such, it is important to understand how determine-basal makes its decisions, and how to interpret its output, so you can decide for yourself whether the recommendations it is making are appropriate for your situation, or if further adjustments are required before closing the loop or letting it run unattended.

## Summary of inputs

The determine-basal algorithm requires a number of inputs, which are passed in JSON files such as iob.json, currenttemp.json, glucose.json, profile.json, and optionally meal.json.  When running oref0-determine-basal.js with the appropriate inputs, the first thing you'll see is a summary of all the provided inputs, which might look something like this:

```
{"carbs":0,"boluses":0}
{"delta":-2,"glucose":110,"avgdelta":-2.5}
{"duration":0,"rate":0,"temp":"absolute"}
{"iob":0,"activity":0,"bolussnooze":0,"basaliob":0}
{"carbs_hr":28,"max_iob":1,"dia":3,"type":"current","current_basal":1.1,"max_daily_basal":1.3,"max_basal":3,"max_bg":120,"min_bg":115,"carbratio":10,"sens":40}
```

* The first line is meal.json, which, if provided, allows determine-basal to decide when it is appropriate to enable Meal Assist.
* The second line is from glucose.json, and represents the most recent BG, the change from the previous BG (usually 5 minutes earlier), and the average change since 3 data points earlier (usually 15 minutes earlier).
* The third line is the currently running temporary basal.  A duration of 0 indicates none is running.
* Fourth is the IOB and insulin activity summary.  Insulin activity is used (when multiplied by ISF) to calculate BGI, which represents how much BG should be rising or falling every 5 minutes based solely on insulin activity.  Basal IOB excludes the IOB effect of boluses, and Bolus Snooze is used in determining how long to avoid low-temping after a bolus while waiting for any carbs to kick in.
* Fifth is the contents of profile.json, which contains all of the user's relevant pump settings, as well as their configured maximum (basal) IOB.

## Output

After displaying the summary of all input data, oref0-determine-basal outputs a recommended temp basal JSON, which includes an explanation of why it's recommending that.  It might look something like this:

```
{"temp":"absolute","bg":110,"tick":-2,"eventualBG":95,"snoozeBG":95,"mealAssist":"Off: Carbs: 0 Boluses: 0 Target: 117.5 Deviation: -15 BGI: 0","reason":"Eventual BG 95<115, setting -1.15U/hr","duration":30,"rate":0}
```

In this case, BG is 110, and falling slowly.  With zero IOB, you would expect BG to be flat, so the falling BG generates a "deviation" from what's expected.  In this case, because avgdelta is -2.5 mg/dL, vs. BGI of 0, that avgdelta is extrapolated out for the next 30 minutes, resulting in a deviation of -30 mg/dL.  That is then applied to the current BG to get an eventualBG of 80.  There is no bolussnooze IOB, so snoozeBG is also 80, and because (among other things) avgdelta is negative, mealAssist remains off.  To correct from 80 up to 115 would require a -2.65U/hr temp for 30m, and since that is impossibly low, determine-basal recommends setting a temp basal to zero and stopping all insulin delivery for now.

## Exploring further

For each different situation, the determine-basal output will be slightly different, but it should always provide a reasonable recommendation and list any temp basal that would be needed to start bringing BG back to target.  If you are unclear on why it is making a particular recommendation, you can explore further by searching lib/determine-basal/determine-basal.js (the library with the core decision tree logic) for the keywords in the reason field (for example, "setting" in this case would find a line (`rT.reason += ", setting " + rate + "U/hr";`) matching the output above, and from there you could read up and see what `if` clauses resulted in making that decision.  In this case, it was because (working backwards) `if (snoozeBG > profile.min_bg)` was false (so we took the `else`), but `if (eventualBG < profile.min_bg)` was true (with the explanatory comment to tell you that means "if eventual BG is below target").

If after reading through the code you are still unclear as to why determine-basal made a given decision (or think it may be the wrong decision for the situation), please join the #intend-to-bolus channel on Gitter, paste your output and any other context, and we'll be happy to discuss with you what it was doing and why, and whether that's the best thing to do in that and similar situations.
