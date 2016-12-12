# Troubleshooting the closed loop

If you haven't read this enough already: the DIY part of this is really important. You should be testing and validating your work, and asking questions as you go if anything is unclear. (And, if this documentation annoys you enough, put in a PR as you go through each part to update/improve the documentation to help the next person! We've all been there.) :)

Here are some things you might be asking, and if not, should be thinking through:

## What should BG target range be?

In the early testing, the OpenAPS settings may cause your BG to go both high and low.

It's tempting to set your targets to "perfect" on day one, and start your looping with those values. The problem with this is that if the algorithm incorrectly gives you too much insulin you don't have very much room to handle emergencies.

To start off, you should set your glucose target range "high and wide" (but perhaps no wider than a range of 10-20 mg/dl, i.e. a range of 20 might be 130-150 mg/dl). Once you can reproducibly get your sugars in a wider and higher band without going low, you can then *slowly* reduce the target range to your ideal range.

You should work toward a long-term goal here, rather than trying to do everything on day one.

Additionally, as you think about the lower end of your target range, remember the timing of your insulin activity and the fact that negative insulin corrections take about the same amount of time to go into effect; thus, you wouldn't want your low end of the target range set below 90, for example - otherwise the system will not be able to prevent lows by reducing the insulin.

Remember that you need to set your Nightscout profile to match your pump as you make changes, so that target BG, basal rates, ISF and carb ratios stay the same across both devices. Data from the pump is used to drive the loop, but it is best practice to keep Nightscout in synch.

## What should pump settings be?

You should set your maximum temporary basal limit on your pump to a reasonable value, to make sure that you don't go low by accident.

To start off, you should think about taking the largest basal rate in your profile and multiply it by a 1.3. Set that as your maximum temporary basal on the pump.

Once you're happy things are functioning correctly, you can increase this value to about 2x your basal.

Note that for children especially this can vary a lot based on age, weight, and activity. Err on the side of caution.

## What happens if the system gets out of range or gets bad data?

Test the range of the system. What happens if you walk out of range of the Carelink stick? What happens to the temporary basal rate? What happens with your cron job? What do you need to be aware of? Apply the same set of questions and thinking for other scenarios, including if you go out of range of your CGM and/or get ??? or another CGM error message.

Make sure you understand the limits of the transmitter and these other errors, especially in an overnight situation , and what the system can and can't do when you are out of effective range.

As your tests extends from minutes to hours, you'll want to check at least these scenarios: data corruption, lack of data, lack of connectivity, and other non-ideal operating conditions.

