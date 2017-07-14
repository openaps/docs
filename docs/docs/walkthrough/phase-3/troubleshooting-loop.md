# Troubleshooting the closed loop

If you haven't read this enough already: the DIY part of this is really important. You should be testing and validating your work, and asking questions as you go if anything is unclear. (And, if this documentation annoys you enough, put in a PR as you go through each part to update/improve the documentation to help the next person! We've all been there.) :)

Here are some things you might be asking. 

## What should BG target range be?

In the early testing, the OpenAPS settings may cause your BG to go both high and low.

It may be tempting on day one to set your targets to mirror your traditional BG target and start looping. The problem with this is that if the algorithm incorrectly gives you too much insulin you don't have very much room to handle emergencies. As you think about the lower end of your target range remember the timing of insulin activity and the fact that negative insulin corrections take time to go into effect. Thus you don't want the low end of your target range set below 90 or the system will not be able to prevent lows even if it  suspended insulin delivery.

Don't try to do everything the first week: think long term. You should start setting your glucose target range higher and wider, i.e. 130-150 mg/dL (7.2-8.3 mmol/L). However, do not set your range wider than about 20 mg/dL, as this often causes confusions for new loopers. Once you can reproducibly get your sugars in a wider and higher band without going low, you can then *slowly* reduce the target range to your ideal target range.

Target BG target is set on your pump. Navigate to Bolus -> Bolus Wizard Setup -> Edit Settings -> BG Target

Try to remember to set your Nightscout profile to match your pump as you make changes, to also limit confusion. Update target BG, basal rates, ISF and carb ratios to stay the same as on your pump. Data from the pump not Nightscout is used to drive the closed loop; having Nightscout display different targets and incorrect settings may be confusing. When setting your Target BG range (low and high targets) in Nightscout Profile Editor understand these values are what Nigthscout will use to create reports. 

## What should pump settings be?

You should set your maximum temporary basal limit on your pump to a reasonable value. You can change this value over time, so there is no reason not to start conservatively and have your max basal rate be similar to your highest basal rate.

To start off, you should think about taking the largest basal rate in your profile and multiply it by a 1.3. Set that as your maximum temporary basal on the pump.

Once you're happy things are functioning correctly, you can increase this value. Many people continue to 2x your basal.

Note that for children especially this can vary a lot based on age, weight, and activity. Err on the side of caution.

## What happens if the system gets bad data or looses data connections?

Test the range of the system. What happens if you walk out of range of your system? Do you need to start watching something? How do you know if you are or are not looping? Are corrections going to be needed? What happens when various batteries die or go too low? Think through other scenarios, including if CGM shows ??? instead of numbers, other CGM error message.

Make sure you know what the system can and can't do when you are out of communication range. Know what can happen overnight. These are suggestions to get you accquainted with the system. As your tests extend from minutes to hours check at least these scenarios: data corruption, lack of data, lack of connectivity, non-ideal operating conditions.

