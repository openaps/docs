
# Understanding this guide

Some conventions used in this guide:

* Wherever you see text that is formatted `like this`, it is a code snippet. You should copy and paste instead of attempting to type this out; this will save you debugging time for finding your typos.
* You will see a <tt>$</tt> at the beginning of many of the lines of code. This
  indicates that it is to be entered and executed at the terminal prompt. Do not type in the dollar sign <tt>$</tt>.
* Wherever there are `<bracketed_components>` in the the code, these are meant for you to insert your own information. Most of the time, it doesn't matter what you choose **as long as you stay consistent throughout this guide**. That means if you choose `Barney` as your  `<my_pump_name>`, you must use `Barney` every time you see `<my_pump_name>`. Choose carefully. Do not include the `< >` brackets in your name.

### Before you get started

Some familiarity with using the terminal will go a long way, so if you aren't comfortable with what `cd` and `ls` do, take a look at some of the Linux Shell / Terminal commands on the [Troubleshooting](../Resources/troubleshooting.md) page and the reference links on the [Technical Resources](../Resources/technical-resources.md) page.

One helpful thing to do before starting any software work is to log your terminal session. This will allow you to go back and see what you did at a later date. This will also be immensely helpful if you request help from other OpenAPS contributors as you will be able to provide an entire history of the commands you used. To enable this, just run `script <filename>` at the beginning of your session. It will inform you that `Script started, file is <filename>`. When you are done, simply `exit` and it will announce `Script done, file is <filename>`. At that point, you can review the file as necessary.

### What you won't see in this guide

You won't see a full loop where you can just download the code, press a button, and have a live loop. There are many places where there are examples, and instructions, but you must do the work to understand how to communicate between devices and transfer data between reports and files. This is key for helping you understand what you are building and how it will work.

In some cases, the documentation needs to be built out further, with easier to understand language and more examples. You should have full intent and autonomy in building your system for yourself.

### But wait - I need the "Dummy" version

Well, actually, you don't.  If you can deal with diabetes, invoking shell scripts isn't all that big a deal.  But it will probably help to have some idea what is going on here.

It may help to think of the OpenAPS setup as a tiny "diabetes brain" which is focused only on figuring out how much basal insulin you should be getting.  It does this by collecting all that background data we usually let our pumps deal with: what is your insulin sensitivity, your target BG, the duration of action for insulin, etc.  Then, it collects more immediate data, such as what is the current IOB, and basal rate, as well as checking out the CGM to see what your BG has been up to recently.  Then, it decides what should be changed (if anything) and tells your pump to go to a new temp basal rate, either higher or lower, depending on all the other factors.

As you go through the steps to run the loop, the longer-term data is collected in the "settings" directory, with file names indicating what sort of data they contain.  The data representing what is going on right now is in the "monitor" directory, and the recommendation for what should change goes in the "enact" directory.  To close the loop, you will have added a "cron" script, which just directs the computer to do something at a certain time interval.  
