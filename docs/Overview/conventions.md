# Conventions

Some conventions used in this guide:
* Wherever you see text that is formatted `like this`, it is code.
* You will see a `$ ` at the beginning of many of the lines of code. This indicates that it is to be entered and executed at the terminal prompt. Do not type in the `$`. 
* Wherever there are `<bracketed_components>` in the the code, these are meant for you to insert your own information. Most of the time, it doesn't matter what you choose **as long as you stay consistent throughout this guide**. That means if you choose `Barney` as your  ` < my_pump_name > `, you must use `Barney` every time you see `< my_pump_name >`. Choose carefully. Do not include the `< >` brackets in your name.
 

Some familiarity with using the terminal will go a long way, so if you aren't comfortable with what `cd` and `ls` do, take a look at some of the Linux Shell / Terminal links on the [Technical Resources](../Resources/technical-resources.md) page.

One helpful thing to do before starting is to log your terminal session. This will allow you to go back and see what you did at a later date. This will also be immensely helpful if you request help from other OpenAPS contributors as you will be able to provide an entire history of the commands you used. To enable this, just run `$ script <filename>` at the beginning of your session. It will inform you that `Script started, file is <filename>`. When you are done, simply `$ exit` and it will announce `Script done, file is <filename>`. At that point, you can review the file as necessary.