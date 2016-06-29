## Using cron to create a schedule for your loop

You should use [cron](http://bit.ly/1QpJFk1) to create a schedule for your loop.
Use `oref0 cron-5-minute-helper` to generate a simple cron job.  It
can be imported into crontab using `oref0 cron-5-minute-helper
do-loop | crontab -`.  By default, it will list a suggested cron job
that runs once every 5 minutes.

The symbols to the left of the command indicate how often the command should run.  Each symbol represents a unit of time, as follows.  Putting / before a number means the command will run every time that unit of time passes.
<Minute> <Hour> <Day_of_the_Month> <Month_of_the_Year> <Day_of_the_Week>

Here's an example:

```
$ oref0 cron-5-minute-helper openaps do-foo-bar
SHELL=/bin/bash
PATH=/home/bewest/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/bewest/.cabal/bin:/home/bewest/.cabal/bin

*/5 * * * * (cd /home/bewest/src/openaps/docs && time openaps do-foo-bar) 2>&1 | logger -t openaps-loop

```

Another example would be to use cron to automatically resolve git corruption issues:

```
# Below line resets git repository every 1 minute in order to automatically resolve git corruption
*/1 * * * * cd /home/pi/myopenaps && oref0-reset-git  

```

It prepares a cron template to change to the current directory and runs
whatever was specified, sending all output to syslog.
