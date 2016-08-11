# Running an open loop with oref0

To pull all of oref0 together, you could create a "loop" alias that looks something like `openaps alias add loop '! bash -c "( openaps preflight && openaps gather && openaps enact) || echo LOOP FAILED."'`. If you want to also add some retry logic to try again if something failed, you could then do something like `openaps alias add retry-loop '! bash -c "openaps preflight && until( ! mm-stick warmup || openaps loop); do sleep 5; done"'`.

Once all that is working and tested, you will have a command that can be run manually or on a schedule to collect data from the pump and cgm, calculate IOB and a temp basal suggestion, and then enact that on the pump.

## Automatically receiving oref0 suggestions
If you have a device that can be used with [Pushbullet](https://www.pushbullet.com), then you can get your OpenAPS device to automatically send you a notificaiton when it wants you to change your basal rate. 

First, sign up on their website, then go to the [Account Settings](https://www.pushbullet.com/#settings/account) page and click on "Create Access Token". The string it produces is like a password, and should not be given to anyone.

Next, create a script file on your looping device `format_enact_for_push.sh`
```
#!/bin/bash
input=`cat enact/suggested.json | json -k | grep -q rate && cat enact/suggested.json  | json rate duration reason`
input=${input//$'\n'/ }

if [ ! -z "$input" ]; then
  duration=`echo $input | awk '{print $2;}'`
  rate=`echo $input | awk '{print $1;}'`
  reason=`echo $input | awk '{$1 = ""; $2 = ""; print $0;}' | sed 's/^ *//'`
  if [ $duration = "0" ]; then
    echo Cancel temp basal\\n$reason
  else
    echo $duration m @ $rate U/hr\\n$reason
  fi
fi
```
This assumes that your oref0 suggestions can be found in enact/suggested.json

Next, create `ping.sh`
```
#!/bin/bash
input="${1:-$(</dev/stdin)}"
input=${input//$'\n'/\\n}
echo $input
if [ ! -z "$input" ]; then
  echo "{\"body\": \"$input\"}"
  echo "{\"type\": \"note\", \"title\":\"openAPS\", \"body\":\"$input\"}" | \
    curl -u ACCESS_KEY: -X POST https://api.pushbullet.com/v2/pushes \
    --header 'Content-Type: application/json' --data-binary @-
fi
```
Replace `ACCESS_KEY` with the access key you got earlier from Pushbullet.

Make the scripts executable:
```
chmod 755 format_enact_for_push.sh ping.sh
```

In your loop, once the suggestion has been created, run `./format_enact_for_push.sh | ./ping.sh`, and you should get a notification on your pushbullet application.
