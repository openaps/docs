# Validating and Testing

If you haven't read this enough already: the DIY part of this is really important. If you've been copying and pasting, and not understanding what you're doing up to this point - please stop. That's dangerous. You should be testing and validating your work, and asking questions as you go if anything is unclear. (And, if this documentation annoys you enough, put in a PR as you go through each part to update/improve the documentation to help the next person! We've all been there.) :)

That being said, at this stage, you have both a manual loop and a schedule (using cron) to create an automated loop. At this point, you're in the "test and watch" phase. In particular, you should make sure the loop is recommending and enacting the types of temporary basal rates that you might do manually; and that the communication is working between the devices. 

Additionally, most loopers, after automating their system with cron jobs, begin to think through some of the following things and run the following tests, including unit tests:

## How often should the cron run?

Think about how often you get new BG data and may want to act on it. Or, time how long it takes your loop to run, and add another minute to that. You probably want to add preflight checks to make sure a loop is not already running before your next one starts. 

## What should BG target range be?

In the early testing, the OpenAPS settings may cause your BG to go both high and low.

It's tempting to set your targets to "perfect" on day one, and start your looping with those values. The problem with this is that if the algorithm incorrectly gives you too much insulin you don't have very much room to handle emergencies.

To start off, you should set your glucose target range "high and wide". Once you can reproducibly get your sugars in a wider and higher band without going low, you can then *slowly* reduce the target range to your ideal range.

You should work toward a long-term goal here, rather than trying to do everything on day one.

Additionally, as you think about the lower end of your target range, remember the timing of your insulin activity and the fact that negative insulin corrections take about the same amount of time to go into effect; thus, you wouldn't want your low end of the target range set below 90, for example - otherwise the system will not be able to prevent lows by reducing the insulin.

## What should pump settings be?

You should set your maximum temporary basal limit on your pump to a reasonable value, to try and make sure that you don't go low by accident.

To start off, you should think about taking the largest basal rate in your profile and multiply it by a 1.3. Set that as your maximum temporary basal on the pump.

Once you're happy things are functioning correctly, you can increase this value to about 2x your basal.

Note that for children especially this can vary a lot based on age, weight, and activity. Err on the side of caution.

## What happens if the system gets out of range or gets bad data?

Test the range of the system. What happens if you walk out of range of the Carelink stick? What happens to the temporary basal rate? What happens with your cron job? What do you need to be aware of? Apply the same set of questions and thinking for other scenarios, including if you go out of range of your CGM and/or get ??? or another CGM error message.

Make sure you understand the limits of the transmitter and these other errors, especially in an overnight situation , and what the system can and can't do when you are out of effective range.

As your tests extends from minutes to hours, you'll want to check at least these scenarios: data corruption, lack of data, lack of connectivity, and other non-ideal operating conditions.

##Unit testing

Additionally, you may want to consider some unit testing. There is a basic unit testing framework in oref0 that you can use, and add to. 

###To help with unit test cases:

If you'd like to help out with defining all the desired behaviors in the form of unit test cases:

1) Please clone / checkout [oref0] (https://github.com/openaps/oref0)

2) Type `sudo npm install -g mocha` and `sudo npm install -g should`

3) You should then be able to run `make` (or something like `mocha -c tests/determine-basal.test.js 2>&1 | less -r`) from the openaps-js directory to run all of the existing unit tests

4) As you add additional unit tests, you'll want to run `make` again after each one. 

###How to add more test cases:
 
We'll want to cover every section of the code, so if you see a "rT.reason" in bin/oref0-determine-basal.js that doesn't have a corresponding "output.reason.should.match" line in an appropriate test in tests/determine-basal.test.js, then you should figure out what glucose, temp basal, IOB, and profile inputs would get you into that section of the code (preferably representing what you're likely to see in a real-world situation), and create a test case to capture those inputs and the desired outputs.  Then run the tests and see if your test passes, and the output looks reasonable.  If not, then modify your test case accordingly, or if you think you've found a bug in determine-basal.js, ask on Gitter.
