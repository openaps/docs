-------------------------------
Installing OpenAPS on your rig
-------------------------------

Getting OpenAPS running on your rig generally takes five steps:

1. **Jubilinux installation** (called "flashing" the Edison - Pi users can skip to step 2). This may already be done for you if you purchased a pre-flashed Edison board.  
2. **Getting first wifi network connection and installing "dependencies"** (helper code that make all the OpenAPS code function). This is done using what is called the "bootstrap" script.
3. **Installing your OpenAPS loop**. This is done using what is called the "setup" script.
4. **Watching the Pump-loop Log**. This is an important, required step. You need to be familiar with how to read and access your logs.
5. **Finish your setup**: all the polishing steps to your OpenAPS setup.  Things like optimizing your settings, preferences, BT-tethering, IFTTT, etc.

Going through steps 1-2 may take about 1-3 hours depending on your internet connection, whether the edison was pre-flashed, and comfort level with the instructions.  At the end of the bootstrap script (step 2), you will be asked if you want to continue on with the set-up script (step 3).  If you need to take a break and come back to step 3 later, you can answer "no" to continuing on and come back later.

Some conventions used in these docs:

* Wherever you see text that is formatted `like this`, it is a code snippet. You should copy and paste those code snippets instead of attempting to type these out; this will save you debugging time for finding your typos.
* Double check that your copy-paste has copied correctly.  Sometimes a paste may drop a character or two and that will cause an error in the command that you are trying to execute.  Sometimes, depending on what step you are doing, you may not see the issue.  So, do make a point of double checking the paste before pressing return.
* You will see a <tt>$</tt> at the beginning of many of the lines of code. This
  indicates that it is to be entered and executed at the terminal prompt. Do not type in the dollar sign <tt>$</tt>.
* Wherever there are `<bracketed_components>` in the code, these are meant for you to insert your own information. Most of the time, it doesn't matter what you choose **as long as you stay consistent throughout this guide**. That means if you choose `myedison` as your  `<edisonhostname>`, you must use `myedison` every time you see `<edisonhostname>`. Do not include the `< >` brackets in your commands when you enter them.  So for the example above, if the code snipped says `ssh root@<edisonhostname>.local`, you would enter `ssh root@myedison.local`



.. toctree::
   :maxdepth: 4
   :hidden:
   
   step-1-flashing
   step-2-wifi-dependencies
   step-3-setup-script
   step-4-watching-log
   step-5-finishing-setup
   x12-users
