## Using cron to create a schedule for your loop

You should use [cron](http://bit.ly/1QpJFk1) to create a schedule for your loop. 

There is not more instructions around this at this time, due to the need for you to be very certain you want to automate your loop. That being said, there are some examples and many discussions around this step in the Gitter channel. Look in the web interface and use the search function to see some discussions on this topic, and ask additional questions as needed as you learn about this step.

That being said, we do recommend making sure your OpenAPS git environment is healthy prior to running you loop, and we have a tool for that: `oref0-reset-git`.  We recommend running it fairly frequently, so your cron entry should look something like this:

`* * * * * cd [YOUR OPENAPS DIRECTORY] && oref0-reset-git`
