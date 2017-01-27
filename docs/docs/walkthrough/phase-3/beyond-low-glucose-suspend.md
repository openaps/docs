# Going beyond low glucose suspend mode

You may have noticed that in the previous phase, in observing low glucose suspend mode, the loop did not temp you to get your netIOB above 0.

Once you have spent several days observing the loop in the previous mode and made sure your basals and bolus strategies are in good shape, you may consider moving to the next step.

This means adjusting your max iob amount in your preferences.json file.

Keep in mind this is one of the key safety features of OpenAPS. You do NOT want this to be a super large amount. The point of this setting is to ensure that the loop can not excessively high temp you; if you need high temps consistently to get you to this amount, your baseline basals are off OR you missed a meal bolus OR you are sick OR there is some other extenuating circumstance; but in all of these cases, they should require manual intervention and you should not expect the loop to solve for this.

A good rule of thumb is for max iob to be no more than 3 times your highest basal rate. Keep in mind you can start conservatively and change this number over time as you evaluate further how the system works for you.

(This means it should be approximate to your other settings; not an absolute amount that you set without thinking about it.)

## Understanding your preferences.json

All of the settings specific to OpenAPS (that can't be read from the pump) are in this file, so when running the setup scripts or building your loop, you will have the preferences.json file built for the system to read, in addition to your pump profile settings. Many of these are important safety settings, with reasonable default settings, so other than described below, you likely won’t need to adjust these. If you do decide to adjust a setting, the best practice is to adjust one setting at a time, and observe the impact for 3 days. Changing multiple variables at once is a recipe for a lot of headaches and a lot of painful troubleshooting.

Note: the “max basal” rate is the one safety setting that you set in your pump. It should not be confused with “max daily” or “max current” as described below. The system will use whichever of these three values is the lowest as the ceiling for the temps it will set. So, if your pump’s max basal is 1.0u, but your 3x and 4x multipliers would be higher, the system will not set any temps higher than 1.0u, even if it thinks you need more insulin. On the flip side, if your 4x current multiplier says you can have max 1.6u/hr and your max basal is 2u/hr; the maximum set temp at that time will be 1.6u/hr.

{
	"max_iob": 0,
	"type": "current",
	"max_daily_safety_multiplier": 3,
	"current_basal_safety_multiplier": 4,
	"autosens_max": 1.2,
	"autosens_min": 0.7,
	"autosens_adjust_targets": true,
	"override_high_target_with_low": false,
	"skip_neutral_temps": false,
	"bolussnooze_dia_divisor": 2,
	"min_5m_carbimpact": 3,
	"carbratio_adjustmentratio": 1
}

#### Max IOB: 

This will default to zero. After several days or weeks, depending on your comfort level, you may choose to adjust this number. (Remember in the future if you re-run the setup scripts, it will default back to zero so you will come in here to adjust the max iob, as it is an OpenAPS-specific setting).

#### max_daily_safety_multiplier: 

This is a key OpenAPS safety cap. What this does is limit your basals to be 3x (in this example, which is the default and works for most people) your biggest basal rate. You likely will not need to change this, but you should be aware that’s what is discussed about “3x max daily; 4x current” for safety caps.

#### current_basal_safety_multiplier: 

This is the other half of the key OpenAPS safety caps, and the other half of “3x max daily; 4x current” of the safety caps. This means your basal, regardless of max basal set on your pump, cannot be any higher than this number times the current level of your basal. This is to prevent people from getting into dangerous territory by setting excessively high max basals before understanding how the algorithm works. Again, the default is 4x; most people will never need to adjust this and are instead more likely to need to adjust other settings if they feel like they are “running into” this safety cap.

#### autosens_max:

This is a multiplier cap for autosens (and soon autotune) to set a 20% max limit on how high the autosens ratio can be, which in turn determines how high autosens can adjust basals, how low it can adjust ISF, and how low it can set the BG target.

#### autosens_min: 

The other side of the autosens safety limits, putting a cap on how low autosens can adjust basals, and how high it can adjust ISF and BG targets.

#### autosens_adjust_targets: 

This is used to allow autosens to adjust BG targets, in addition to ISF and basals.

#### override_high_target_with_low: 

Defaults to false, but can be turned on if you have a situation where you want someone (a school caregiver, for example) to use the bolus wizard for meal boluses. If set to “True”, then the bolus wizard will calculate boluses with the high end of the BG target, but OpenAPS will target the low end of that range. So if you  have a target range of 100-120; and set this to true; bolus wizard will adjust to 120 and the loop will target 100. If you have this on, you probably also want a wide range target, rather than a narrow (i.e. 100-100) target.

#### skip_neutral_temps: 

Defaults to false, so that OpenAPS will set temps whenever it can, so it will be easier to see if the system is working, even when you are offline. This means OpenAPS will set a “neutral” temp (same as your default basal) if no adjustments are needed. If you are a light sleeper and the “on the hour” buzzing or beeping wakes you up (even in vibrate mode), you may want to turn this to “true” to skip this setting. However, we recommend it for most people who will be using this system on the go and out of constant connectivity.

#### bolussnooze_dia_divisor: 

Bolus snooze is enacted after you do a meal bolus, so the loop won’t counteract with low temps when you’ve just eaten. The example here and default is 2; so a 3 hour DIA means that bolus snooze will be gradually phased out over 1.5 hours (3DIA/2).

#### min_5m_carbimpact:

This is a setting for default carb absorption impact per 5 minutes. The default is an expected 3mg/dl/5min. This affects how fast COB are decayed, and how much carb absorption is assumed in calculating future predicted BG, when BG is falling more than expected, or not rising as much as expected.

#### carbratio_adjustmentratio: 

This is another safety setting that may be useful for those with secondary caregivers who aren’t dedicated to looking up net IOB and being aware of the status of the closed loop system. The default is 1 (i.e. do not adjust the carb ratio; off). However, in the secondary caregiver situation you may want to set a higher carb ratio to reduce the size of a manual bolus given at any time. With this ratio set to 1.1, for example, the loop would multiple the carb inputs by 10%, and use that number to calculate additional insulin. This can also be used by OpenAPS users who rely on the bolus wizard to calculate their meal bolus, but who want to only bolus for a fraction of the meal, and allow advanced meal assist to high-temp for the rest.


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


