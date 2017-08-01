# Understanding your preferences and safety settings

All of the settings specific to OpenAPS (that can't be read from the pump) are in this file, so when running the setup scripts or building your loop, you will have the preferences.json file built for the system to read, in addition to your pump profile settings. Many of these are important safety settings, with reasonable default settings, so other than described below, you likely won’t need to adjust these. If you do decide to adjust a setting, the best practice is to adjust one setting at a time, and observe the impact for 3 days. Changing multiple variables at once is a recipe for a lot of headaches and a lot of painful troubleshooting.

## Editing your preferences.json

Your preferences are found in the directory `myopenaps/preferences.json`.  To edit any of your preferences, you can enter `edit-pref` (as a shortcut) or `cd ~/myopenaps && nano preferences.json`

To check your edits when you're done, use `cd ~/myopenaps && cat preferences.json`

## Commonly-adjusted preferences:

```
{
        "max_iob": 0,
        "max_daily_safety_multiplier": 3,
        "current_basal_safety_multiplier": 4,
        "autosens_max": 1.2,
        "autosens_min": 0.7,
        "rewind_resets_autosens": true,
        "adv_target_adjustments": true,
        "unsuspend_if_no_temp": false,
        "enableSMB_with_bolus": false,
        "enableSMB_with_COB": false,
        "enableSMB_with_temptarget": false,
        "enableUAM": false
}
```

#### max_iob: 

Max_IOB (or maxIOB as often described) is not a basal rate.  Max_IOB is the maximum amount of UNITS of basal (or SMB corrections) insulin that your loop is allowed to accumulate to treat higher-than-target BG. This setting is not dependent on the rate the temp basal is applied, however the greater a temp basal rate, the faster basal insulin is accumulated.  Therefore, some safety considerations are smart.

A good rule of thumb is for max-iob to be no more than 3 times your highest basal rate. Keep in mind you can start conservatively and change this number over time as you evaluate further how the system works for you. (This means it should be approximate to your other settings; not an absolute amount that you set without thinking about it.)

The setup script will prompt you for a max-iob setting.  Previous oref0 releases (0.4.3 or older) used a max-iob initial setting of 0 units.  This effectively made the initial loop build only capable of suspending to prevent lows...as it was not allowed to accumulate much corrective basal insulin.  oref0 0.5.0 or later will prompt you to enter a max-iob during setup.  This setting will be saved in the oref-runagain script and be used again if you need to rerun the script.  

#### the most commonly confused safety variables that are also the most important 

Note: The next two variables `max_daily_safety_multiplier` and `current_basal_safety_multiplier` work together, along with your pump's max basal rate setting (set on your pump), as a safety setting for your loop. **The system will use whichever of these three values is the lowest, at any given time, as the ceiling for the temp basal rates it will set.** So, if your pump’s max basal is 1.0u, but 3x your highest daily basal or 4x your current basal would be higher, the system will not set any temps higher than 1.0u, even if it thinks you need more insulin. On the flip side, if your 4x current multiplier says you can have max 1.6u/hr and your pump's max basal is 2u/hr; the maximum set temp at that time will be 1.6u/hr.

You can be able to alerted to being restricted by the max basal setting by looking at the OpenAPS pill message in Nightscout (or in pump-loop log), which will say  "adj. req. rate: XX to maxSafeBasal: XX"  

![max safe basal message](../Images/max-safe-basal.jpg) 

#### max_daily_safety_multiplier: 

This is a key OpenAPS safety cap. What this does is limit your basals to be 3x (in this example, which is the default and works for most people) your biggest basal rate. You likely will not need to change this, but you should be aware that’s what is discussed about “3x max daily; 4x current” for safety caps.

#### current_basal_safety_multiplier: 

This is the other half of the key OpenAPS safety caps, and the other half of “3x max daily; 4x current” of the safety caps. This means your basal, regardless of max basal set on your pump, cannot be any higher than this number times the current level of your basal. This is to prevent people from getting into dangerous territory by setting excessively high max basals before understanding how the algorithm works. Again, the default is 4x; most people will never need to adjust this and are instead more likely to need to adjust other settings if they feel like they are “running into” this safety cap.

#### autosens_max:

This is a multiplier cap for autosens (and autotune) to set a 20% max limit on how high the autosens ratio can be, which in turn determines how high autosens can adjust basals, how low it can adjust ISF, and how low it can set the BG target.

#### autosens_min: 

The other side of the autosens safety limits, putting a cap on how low autosens can adjust basals, and how high it can adjust ISF and BG targets.

#### rewind_resets_autosens:

This feature, enabled by default, resets the autosens ratio to neutral when you rewind your pump, on the assumption that this corresponds to a probable site change.  Autosens will begin learning sensitivity anew from the time of the rewind, which may take up to 6 hours.  If you usually rewind your pump independently of site changes, you may want to consider disabling this feature.

#### adv_target_adjustments:

This feature, enabled by default, lowers oref0's target BG automatically when current BG and eventualBG are high.  This helps prevent and mitigate high BG, but automatically switches to low-temping to ensure that BG comes down smoothly toward your actual target.  If you find this behavior too aggressive, you can disable this feature.  If you do so, please let us know so we can better understand what settings work best for everyone. 

#### unsuspend_if_no_temp:

Many people occasionally forget to resume / unsuspend their pump after reconnecting it.  If you're one of them, and you are willing to reliably set a zero temp basal whenever suspending and disconnecting your pump, this feature has your back.  If enabled, it will automatically resume / unsuspend the pump if you forget to do so before your zero temp expires.  As long as the zero temp is still running, it will leave the pump suspended.

### Advanced oref1 preferences:

These preference should **not** be enabled until you've been looping (and running autotune) for several weeks and are confident that all of your basals and ratios are correct.  Please read the [oref1 section of the docs](http://openaps.readthedocs.io/en/latest/docs/Customize-Iterate/oref1.html) before doing so.

#### enableSMB_with_bolus

This enables supermicrobolus for DIA hours after a manual bolus.

#### enableSMB_with_COB

This enables supermicrobolus (SMB) while carbs on board (COB) is positive.

#### enableSMB_with_temptarget 

This enables supermicrobolus (SMB) with eating soon / low temp targets. With this feature enabled, any temporary target below 100mg/dL, such as a temp target of 99 (or 80, the typical eating soon target) will enable SMB.

#### enableUAM

This enables detection of unannounced meal (UAM) carb absorption.

### Other preferences:

Generally, you won't need to adjust any of the preferences below.  But if you do wish to change the default behavior, you can add these into your preferences.json to do so (or use oref0-get-profile --updatePreferences to get the full list of all preferences added to your preferences.json).

#### autosens_adjust_targets: 

This is used to allow autosens to adjust BG targets, in addition to ISF and basals.

#### override_high_target_with_low: 

Defaults to false, but can be turned on if you have a situation where you want someone (a school caregiver, for example) to use the bolus wizard for meal boluses. If set to “True”, then the bolus wizard will calculate boluses with the high end of the BG target, but OpenAPS will target the low end of that range. So if you  have a target range of 100-120; and set this to true; bolus wizard will adjust to 120 and the loop will target 100. If you have this on, you probably also want a wide range target, rather than a narrow (i.e. 100-100) target.

#### skip_neutral_temps: 

Defaults to false, so that OpenAPS will set temps whenever it can, so it will be easier to see if the system is working, even when you are offline. This means OpenAPS will set a “neutral” temp (same as your default basal) if no adjustments are needed. If you are a light sleeper and the “on the hour” buzzing or beeping wakes you up (even in vibrate mode), you may want to turn this to “true” to skip this setting. However, we recommend it for most people who will be using this system on the go and out of constant connectivity.

#### bolussnooze_dia_divisor: 

Bolus snooze is enacted after you do a meal bolus, so the loop won’t counteract with low temps when you’ve just eaten. The example here and default is 2; so a 3 hour DIA means that bolus snooze will be gradually phased out over 1.5 hours (3DIA/2).

#### min_5m_carbimpact:

This is a setting for default carb absorption impact per 5 minutes. The default is an expected 8 mg/dL/5min. This affects how fast COB is decayed in situations when carb absorption is not visible in BG deviations.  The default of 8 mg/dL/5min corresponds to a minimum carb absorption rate of 24g/hr at a CSF of 4 mg/dL/g.

#### carbratio_adjustmentratio: 

This is another safety setting that may be useful for those with secondary caregivers who aren’t dedicated to looking up net IOB and being aware of the status of the closed loop system. The default is 1 (i.e. do not adjust the carb ratio; off). However, in the secondary caregiver situation you may want to set a higher carb ratio to reduce the size of a manual bolus given at any time. With this ratio set to 1.1, for example, the loop would multiple the carb inputs by 10%, and use that number to calculate additional insulin. This can also be used by OpenAPS users who rely on the bolus wizard to calculate their meal bolus, but who want to only bolus for a fraction of the meal, and allow advanced meal assist to high-temp for the rest.

#### maxCOB:

This defaults maxCOB to 120 because that's the most a typical body can absorb over 4 hours. (If someone enters more carbs or stacks more; OpenAPS will just truncate dosing based on 120. Essentially, this just limits AMA as a safety cap against weird COB calculations due to fluky data.)

#### remainingCarbsCap:

This is the amount of the maximum number of carbs we'll assume will absorb over 4h if we don't yet see carb absorption. 

#### remainingCarbsFraction:

This is the fraction of carbs we'll assume will absorb over 4h if we don't yet see carb absorption.

#### autotune_isf_adjustmentFraction:

The default of 0.5 for this value keeps autotune ISF closer to pump ISF via a weighted average of fullNewISF and pumpISF.  1.0 allows full adjustment, 0 is no adjustment from pump ISF.


