# Creating a loop and retry logic

To pull all of oref0 together, you could create a "loop" alias that looks something like `openaps alias add loop '! bash -c "openaps monitor-cgm 2>/dev/null && ( openaps preflight && openaps gather && openaps enact) || echo No CGM data."'`. If you want to also add some retry logic to try again if something failed, you could then do something like `openaps alias add retry-loop '! bash -c "until( ! mm-stick warmup || openaps loop); do sleep 5; done"'`.

Once all that is working and tested, you will have a command that can be run manually or on a schedule to collect data from the pump and cgm, calculate IOB and a temp basal suggestion, and then enact that on the pump. 
