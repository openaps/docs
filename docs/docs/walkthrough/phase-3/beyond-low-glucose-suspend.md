# Going beyond low glucose suspend mode

You may have noticed that in the previous phase, in observing low glucose suspend mode, the loop did not temp you to get your netIOB above 0.

Once you have spent several days observing the loop in the previous mode and made sure your basals and bolus strategies are in good shape, you may consider moving to the next step.

This means adjusting your max iob amount in your preferences.json file.

Keep in mind this is one of the key safety features of OpenAPS. You do NOT want this to be a super large amount. The point of this setting is to ensure that the loop can not excessively high temp you; if you need high temps consistently to get you to this amount, your baseline basals are off OR you missed a meal bolus OR you are sick OR there is some other extenuating circumstance; but in all of these cases, they should require manual intervention and you should not expect the loop to solve for this.

A good rule of thumb is for max iob to be 3 times your highest basal rate.

(This means it should be approximate to your other settings; not an absolute amount that you set without thinking about it.)
