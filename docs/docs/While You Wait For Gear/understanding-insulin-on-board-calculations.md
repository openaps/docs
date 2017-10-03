# Understanding Insulin on Board (IOB) Calculations

The amount of Insulin on Board (IOB) at any given moment is a key input into the `determine-basal` logic, which is where all the calculations for setting temporary basal rates or small microboluses (SMBs) takes place. This amount of insulin on board gets passed into [`oref0/lib/determine-basal/determine-basal.js`](https://github.com/openaps/oref0/blob/master/lib/determine-basal/determine-basal.js) as part of the `iob.json` file. That information is then used to project forward blood glucose (BG) trends, which the `determine-basal` logic then responds to in order to correct course. This piece of the OpenAPS documentation provides an explanation of the assumptions used about how insulin is absorbed and how those assumptions translate into the insulin on board calculations used to project BG trends.

## First, some definitions:
* **dia:** Duration of Insulin Activity. This is the user specified time (in hours) that insulin lasts in their body after a bolus. This value comes from the user's pump settings. 


* **end:** Duration (in minutes) that insulin is active. `end` = `dia` * 60.


* **peak:** Duration (in minutes) until insulin action reaches it's peak activity level.


* **activity:** This is percent of insulin treatment that was active in the previous minute." 

     
## Insulin Activity

The code in [oref0/lib/iob/calculate.js](https://github.com/openaps/oref0/blob/master/lib/iob/calculate.js) calculates a variable called `activityContrib`, which has two components: `treatment.insulin` and a component referenced here as `actvity`.  The unit of measurement for `treatment.insulin` is *units of insulin*; the unit of measurement for `activity` is *percent of insulin used each minute* and is used to scale the `treatment.insulin` value to *units of insulin used each minute*. (There is no variable `activity` created in [oref0/lib/iob/calculate.js](https://github.com/openaps/oref0/blob/master/lib/iob/calculate.js). There is, however, a variable called `activity` created in [oref0/lib/iob/total.js](https://github.com/openaps/oref0/blob/master/lib/iob/total.js), which represents a slightly different concept. See the FINAL NOTE, below, for more details.)

There are three key assumptions the OpenAPS algorithm makes about how insulin activity works in the body:

* **Assumption #1:** Insulin activity increases linearly (in a straight line) until the `peak` and then decreases linearly (but at a slightly slower rate) until the `end`. 

* **Assumption #2:** All insulin will be used up.

* **Assumption #3:** When insulin activity peaks (and how much insulin is used each minute) depends on a user's setting for how long it takes for all their insulin to be used up. That setting is their duration of insulin activity (`dia`) and generally ranges between 2 and 8 hours. The OpenAPS logic starts off with a default value of 3 hours for `dia`, which translates into 180 minutes for `end`, and assumes that insulin activity peaks at 75 minutes. (This is generally in line with findings that rapid acting insluins (Humalog, Novolog, and Apidra, for example) peak between 60 and 90 minutes after an insulin bolus.) This assumption, however, is generalizable to other user `dia` settings. That is, `peak` can be expressed as a function of `dia` by multiplying by the ratio (75 / 180):
    
    `peak` = f(`dia`) = (`dia` \* 60 \* (75 / 180))
    
    So, for example, for a `dia` of 4 hours, `peak` will be at 100 minutes:
    
    100 = (4 \* 60 \* (75 / 180))

> **NOTE:** The insulin action assumptions described here are set to change with the release of [oref0, version 0.6.0](https://github.com/openaps/oref0/tree/0.6.0-dev). The new assumptions will use exponential functions for the insulin action curves and will allow some user flexibility to use pre-set parameters for different classes of fast-acting insulins (Humalog, Novolog, and Apidra vs. Fiasp, for example). For a discussion of the alternate specifications of insulin action curves, see [oref0 Issue #544](https://github.com/openaps/oref0/issues/544). When oref0, version 0.6.0 is released and the current assumptions are no longer recommended, this documentation will be updated.
 

## What The Insulin Activity Assumptions Look Like
Given a `dia` setting of 3 hours, insulin activity peaks at 75 minutes, and between the 74th and 75th minutes, approximately 1.11 percent of the insulin gets used up.

![activity_dia_3](../Images/OpenAPS_activity_dia_3.png)


Adding up all the insulin used *each minute* between 0 and `end`, will sum to 100 percent of the insulin being used. 

![activity_dia_3_area](../Images/OpenAPS_activity_dia_3_area.png)

The area under the "curve" can be calculated by taking the [definite integral](https://en.wikipedia.org/wiki/Integral) for the `activity` function, but in this simple case the formula for the area of a triangle is much simpler:  

 	Area of a triangle = 1/2 * width * height 

 			    = 1/2 * 180 * 1.11 

 			    = 99.9 (close enough to 100 -- the actual value for activity is 1.1111111, which gets even closer to 100)


For shorter `dia` settings, the `peak` occurs sooner and at a higher rate. For longer `dia` settings, the `peak` occurs later and at a lower rate. But for each triangle, the area underneath is equal to 100 percent.

![activity_dia_2_8](../Images/OpenAPS_activity_by_dia_2_8.png)


## Cumulative Insulin Activity

Given these `activity` profiles, we can plot cumulative `activity` curves, which are S-shaped and range from 0 to 100 percent.  (Note: This step isn't taken in the actual  [`oref0/lib/determine-basal/determine-basal.js`](https://github.com/openaps/oref0/blob/master/lib/determine-basal/determine-basal.js) program, but  plotting this out is a useful way to visualize/understand the insulin on board curves.)

![activity_dia_3](../Images/OpenAPS_cum_activity_dia_3.png)

Just like how the insulin activity curves shift depending on the setting for `dia`, the cumulative activity curves do as well.

![activity_dia_3](../Images/OpenAPS_cum_activity_by_dia_2_8.png)

## Insulin on Board

Insulin on board (`iob`), is the inverse of the cumulative activity curves. Instead of ranging from 0 to 100 percent, they range from 100 to 0 percent. With `dia` set at 3 hours, about 70 percent of insulin is still available an hour after an insulin dosage, and about 17 percent is still available two hours afterwards.

![activity_dia_3](../Images/OpenAPS_iob_curve_dia_3.png)

Similar to how the `activity` "curves" (triangles) and cumulative `actvity` curves vary by `dia` settings, the `iob` curves also vary by `dia` setting.

![activity_dia_3](../Images/OpenAPS_iob_curves_by_dia_2_8.png)

Similar to calculations above, the code in [oref0/lib/iob/calculate.js](https://github.com/openaps/oref0/blob/master/lib/iob/calculate.js) calculates a variable called `iobContrib`, which has two components: `treatment.insulin` and and a component referenced here as `iob`.  The unit of measurement for `treatment.insulin` is *units of insulin*; the unit of measurement for `iob` is *percent of insulin remaining each minute* and is used to scale the `treatment.insulin` value to *units of insulin remaining each minute*. (There is no variable `iob` created in [oref0/lib/iob/calculate.js](https://github.com/openaps/oref0/blob/master/lib/iob/calculate.js). There is, however, a variable called `iob` created in [oref0/lib/iob/total.js](https://github.com/openaps/oref0/blob/master/lib/iob/total.js), which represents a slightly different concept. See the FINAL NOTE, below, for more details.)

Finally, two sources to benchmark the `iob` curves against can be found [here](http://journals.sagepub.com/doi/pdf/10.1177/193229680900300319) and [here](https://www.hindawi.com/journals/cmmm/2015/281589/).

---

> **FINAL NOTE:**  A separate program&mdash;[oref0/lib/iob/total.js](https://github.com/openaps/oref0/blob/master/lib/iob/total.js)&mdash;creates variables named `activity` and `iob`. Those two variables, however, are not the same as the `activity` and `iob` variables plotted in this documentation page. Those two variables are summations of all insulin treatments still active. The `activity` and `iob` concepts plotted here are expressed in percentage terms and are used to scale the `treatment.insulin` dosage amounts, so the units for the `activityContrib` and `iobContrib` variables are *units of insulin per minute* and *units of insulin remaining at each minute*, respectively. Because the `activity` and `iob` variables in [oref0/lib/iob/total.js](https://github.com/openaps/oref0/blob/master/lib/iob/total.js) are just the sums of all insulin treatments, they're still in the same units of measurements: *units of insulin per minute* and *units of insulin remaining each minute*.

---
