# Understanding the output of oref0-determine-basal

The key logic behind any oref0 implementation of OpenAPS lies in the oref0-determine-basal.js code, which is what takes all of the inputs you've collected and makes a temp basal recommendation you can then enact if appropriate.  As such, it is important to understand how determine-basal makes its decisions, and how to interpret its output, so you can decide for yourself whether the recommendations it is making are appropriate for your situation, or if further adjustments are required before closing the loop or letting it run unattended.

The recommendation is to run for several days in "low glucose management" loop mode, watching the output, in order to decide what your "max basal" setting should be. Based on how often you disagreed or counteracted what the loop was recommending, this might influence how you set your max basal.

## Summary of inputs

The determine-basal algorithm requires a number of inputs, which are passed in JSON files such as iob.json, currenttemp.json, glucose.json, profile.json, and optionally meal.json.  When running oref0-determine-basal.js with the appropriate inputs, the first thing you'll see is a summary of all the provided inputs, which might look something like this:

```
{"carbs":0,"boluses":0}
{"delta":-2,"glucose":110,"avgdelta":-2.5}
{"duration":0,"rate":0,"temp":"absolute"}
{"iob":0,"activity":0,"bolussnooze":0,"basaliob":0}
{"carbs_hr":28,"max_iob":1,"dia":3,"type":"current","current_basal":1.1,"max_daily_basal":1.3,"max_basal":3,"max_bg":120,"min_bg":115,"carbratio":10,"sens":40}
```

* meal.json = {"carbs":0,"boluses":0} 
      * If provided, allows determine-basal to decide when it is appropriate to enable Meal Assist.
      * carbs = # of carbs consumed 
      * boluses = amount of insulin delivered 
      * This data comes from what is entered by user into pump/nightscout
* glucose.json = {"delta":-2,"glucose":110,"avgdelta":-2.5}
      * delta = change from the previous BG (usually 5 minutes earlier) 
      * glucose = most recent BG 
      * avgdelta = average change since 3 data points earlier (usually 15 minutes earlier)
      * This data comes from your connected cgm or from nightscout
* temp_basal.json = {"duration":0,"rate":0,"temp":"absolute"}
      * duration = length of time temp basal will run. A duration of 0 indicates none is running
      * rate = Units/hr basal rate is set to
      * temp = type of temporary basal rate in use. OpenAPS uses absolute basal rates only
      * This data comes from the pump
* iob.json = {"iob":0,"activity":0,"bolussnooze":0,"basaliob":0,"netbasalinsulin":0,"hightempinsulin":0,"time":"2016-10-26T20:07:37.000Z"}
      * iob = net insulin on board compared to preprogrammed pump basal rates. This takes all basal, temp basal, and bolus information into account
      * activity = the amount that BG "should" be rising or falling based on iob
      Insulin activity is used (by multiplying activity * ISF) to determine BGI (blood glucose impact), the amount that BG "should" be rising or falling based on insulin activity alone.
      * bolussnooze = used to determine how long to avoid low-temping after a bolus while waiting for carbs to kick in
      * basaliob = insulin on board attributed to basal rate, excluding the IOB effect of boluses
      * netbasalinsulin = net of basal insulin compared to preprogrammed pump basal rate
      * time = current time
      * This data calculated based on information received from your pump
* preferences.json ={"carbs_hr":28,"max_iob":1,"dia":3,"type":"current","current_basal":1.1,"max_daily_basal":1.3,"max_basal":3,"max_bg":120,"min_bg":115,"carbratio":10,"sens":40}
	* Contains all of the user’s relevant pump settings
	* max_iob = maximum allowed insulin on board. This is an important safety measure and integral part of the OpenAPS design.
	* This data is set during the openAPS setup script (or modified by you directly) and based on information received from your pump

## Output

After displaying the summary of all input data, oref0-determine-basal outputs a recommended temp basal JSON (stored in suggested.json), which includes an explanation of why it's recommending that.  It might look something like this:

```
{"temp":"absolute","bg":110,"tick":-2,"eventualBG":95,"snoozeBG":95,"mealAssist":"Off: Carbs: 0 Boluses: 0 Target: 117.5 Deviation: -15 BGI: 0","reason":"Eventual BG 95<115, setting -1.15U/hr","duration":30,"rate":0}
```

In this case, BG is 110, and falling slowly.  With zero IOB, you would expect BG to be flat, so the falling BG generates a "deviation" from what's expected.  In this case, because avgdelta is -2.5 mg/dL, vs. BGI of 0, that avgdelta is extrapolated out for the next 30 minutes, resulting in a deviation of -15 mg/dL.

deviation = avgdelta * 6 (or every 5 minutes for the next 30 minutes) = -15

The deviation is then applied to the current BG to get an eventualBG of 95.  There is no bolussnooze IOB, so snoozeBG is also 95, and because (among other things) avgdelta is negative, mealAssist remains off.  To correct from 95 up to 115 would require a -1.15U/hr temp for 30m, and since that is impossibly low, determine-basal recommends setting a temp basal to zero and stopping all insulin delivery for now.

Full definition of suggested.json:
* temp = type of temporary basal - always "absolute"
* bg = current blood glucose
* tick = change since last blood glucose
* eventualBG = predicted value of blood glucose (based on openaps logic) after full effect of IOB
* snoozeBG = predicted value of blood glucose adjusted for bolussnooze IOB
* predBGs = predicted blood sugars over next N many minutes based on openAPS logic, in 5 minute increments
* IOB = net insulin on board
* reason = summary of why the decision was made
* duration = time for recommended temp basal
* rate = rate of recommended temp basal in units/hour


## Exploring further

For each different situation, the determine-basal output will be slightly different, but it should always provide a reasonable recommendation and list any temp basal that would be needed to start bringing BG back to target.  If you are unclear on why it is making a particular recommendation, you can explore further by searching lib/determine-basal/determine-basal.js (the library with the core decision tree logic) for the keywords in the reason field (for example, "setting" in this case would find a line (`rT.reason += ", setting " + rate + "U/hr";`) matching the output above, and from there you could read up and see what `if` clauses resulted in making that decision.  In this case, it was because (working backwards) `if (snoozeBG > profile.min_bg)` was false (so we took the `else`), but `if (eventualBG < profile.min_bg)` was true (with the explanatory comment to tell you that means "if eventual BG is below target").

If after reading through the code you are still unclear as to why determine-basal made a given decision (or think it may be the wrong decision for the situation), please join the #intend-to-bolus channel on Gitter, paste your output and any other context, and we'll be happy to discuss with you what it was doing and why, and whether that's the best thing to do in that and similar situations.

## Note about Square Boluses and Dual Wave Boluses

Due to the way the Medtronic Pumps operate, it should be known that temp basals can only be set when there is no bolus running, including extended (square) / dual wave boluses.  

Thus it should be noted that if you use an extended bolus for carb heavy meals (e.g. Pizza), which may still be the optimal approach for you, OpenAPS will not be able to provide temp basals during the extended bolus. 
