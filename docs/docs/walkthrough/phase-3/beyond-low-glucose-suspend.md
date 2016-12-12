# Going beyond low glucose suspend mode

You may have noticed that in the previous phase, in observing low glucose suspend mode, the loop did not temp you to get your netIOB above 0.

Once you have spent several days observing the loop in the previous mode and made sure your basals and bolus strategies are in good shape, you may consider moving to the next step.

This means adjusting your max iob amount in your preferences.json file.

Keep in mind this is one of the key safety features of OpenAPS. You do NOT want this to be a super large amount. The point of this setting is to ensure that the loop can not excessively high temp you; if you need high temps consistently to get you to this amount, your baseline basals are off OR you missed a meal bolus OR you are sick OR there is some other extenuating circumstance; but in all of these cases, they should require manual intervention and you should not expect the loop to solve for this.

A good rule of thumb is for max iob to be no more than 3 times your highest basal rate. Keep in mind you can start conservatively and change this number over time as you evaluate further how the system works for you.

(This means it should be approximate to your other settings; not an absolute amount that you set without thinking about it.)

## Editing your preferences.json

To change your max iob in your preferences.json file:

First, you need to change directory:

`cd <myopenaps>`

Use the nano text editor to open your preferences.json file:

`nano preferences.json`

Then amend the "max_iob": 0 to the figure you want.

To check that you have done this successfully run the following:

`cat preferences.json`

You should see the amended max IOB you have entered. Remember if you run the setup script in the future, it will default back to 0 max IOB, but you can always follow this same process to change it again.


