# Preparing to Loop

If you're at this stage, you've got the pump and CGMS communicating correctly. To be able to safely proceed to the next phase (automatic looping), you are going to have to do a few things:

1. Sanity Check what the loop would do.
2. Fully understand how the loop would behave in *your* specific circumstance
3. Understand what the pump can do to bring blood glucose *down*
4. Understand what the pump can do to bring blood glucose *up* (spoiler: not much!)

This process is going to take time. As you know, glucose and insulin response varies with exercise, food intake, stress, and more. You need to make sure that the loop would do the right thing in all of these situations.

So you need to test the pump in all these situations. And that means you can't do this step quickly. You need to gain confidence in the pump and in it's correct handling of many many situations.

# Experiment

It's important to consider this a set of experiments. For a while, you're going to have to take careful note of how your days differ from previous days. Don't let yourself get frustrated. If you have trouble, ask on Gitter chat or on the mailing list. It's better to get proper guidance than try and shortcut the process.

# General Guidance - When to Do it

The first time you test, you should have had a relaxed and calm day at home. You should set an alarm and check your glucose levels every 15-30 minutes.

You should not test overnight until you are supremely confident in the operation of the system! And you should probably have someone committed to watching your response while you sleep, and alarms to ensure that everything goes as planned.

Preparation list. Please tick off each of these items:

1 - Someone else present, engaged, and aware of how to handle diabetic emergencies.
2 - Multiple (at least 4!) doses of hypo treatment such as Glucose Gel (15-20g fast acting glucose)
3 - Local emergency numbers and transport routes - just in case! We've no occurrences where this has happened so far, but you should be conservative about things.

# Setting your Targets

In the early testing, the OpenAPS settings may cause your sugar to go both high and low.

It's tempting to set your targets to "perfect sugars" on day one, and start your looping with those values. The problem with this is that if the algorithm incorrectly gives you too much insulin you don't have very much room to handle emergencies.

To start off, you should set your glucose target range "high and wide". Once you can reproducibly get your sugars in a wider and higher band without going low, you can then *slowly* reduce the target range to your ideal range.

You've got to work towards a long-term goal here, rather than trying to do everything on day one.

# Check Pump Settings

You should set your maximum temporary basal limit on your pump to a reasonable value, to try and make sure that you don't go low by accident.

To start off, you should take the largest basal rate in your profile and multiply it by a 1.3. Set that as your maximum temporary basal.

Once you're happy things are functioning correctly, you can increase this value to about 2x your basal.

Note that for children especially this can vary a lot based on age, weight, and activity. Err on the side of caution.

# Understand Transmission Range Limits

Test the range of the OpenAPS device. What happens if you walk out of range? What happens to the temporary basal? What do you need to be aware of?

Make sure you understand the limits of the transmitter especially overnight, and what the system can and can't do when you are out of effective range.
