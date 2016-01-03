# Validating and Testing

If you haven't read this enough already: the DIY part of this is really important. If you've been copying and pasting, and not understanding what you're doing up to this point - please stop. That's dangerous. You should be testing and validating your work, and asking questions as you go if anything is unclear. (And, if this documentation annoys you enough, put in a PR as you go through each part to update/improve the documentation to help the next person! We've all been there.) :)

That being said, at this stage, you have both a manual loop and a schedule (using cron) to create an automated loop. At this point, you're in the "test and watch" phase. In particular, you should make sure the loop is recommending and enacting the types of temporary basal rates that you might do manually; and that the communication is working between the devices. And, as your test extends from minutes to hours, you'll want to check at least these scenarios: data corruption, lack of data, lack of connectivity, and other non-ideal operating conditions.

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

