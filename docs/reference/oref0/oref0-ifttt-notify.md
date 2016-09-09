# `oref0-ifttt-notify`

## Help
Usage:
`oref0-ifttt-notify <IFTTT_TRIGGER> <NOTIFY_USAGE>`

## Setup IFTTT Account

You need to create an account and connect to the Maker channel and the
notification channel of your choice. I use pushover as I already had the app
and it allows me more control over the notification on my phone.

## Create an IF recipe
The trigger is the maker channel. You can customize the notification message
if you wish.

## Get the event trigger
On the Maker channel there is a "how to trigger" link. Copy and paste the url
for the example curl command, be sure to change the event name field.
The URL, something like:

    `https://maker.ifttt.com/trigger/{event}/with/key/MyKey`

You can pass the IFTTT_TRIGGER, which is the trigger URL as the first
argument, or define it as an environment variable in your crontab.

Command line:

      `oref0-ifttt-notify https://maker.ifttt.com/trigger/{event}/with/key/MyKey`


Crontab:
      `IFTTT_TRIGGER=https://maker.ifttt.com/trigger/{event}/with/key/MyKey`

By default oref0-ifttt-notify will check that the stick works, and notify the IFTTT_TRIGGER
endpoint only if the the stick fails to check out.  If the stick diagnostics
indicate the carelink stick is working, oref0-ifttt-notify will run:

      `openaps use pump model`

You can specify which openaps use command to use in the second argument, or by
setting the IFTTT_NOTIFY_USAGE environment variable in crontab:

Command line, note the quotes, the second term must be passed as single word.

      `oref0-ifttt-notify https://maker.ifttt.com/trigger/{event}/with/key/MyKey 'pump model'`

Crontab:

      `IFTTT_NOTIFY_USAGE='pump model'`

Author: @audiefile
