# Creating a loop and retry logic

To pull all of oref0 together, you could create a "loop" alias that looks something like `openaps alias add loop '! bash -c "openaps monitor-cgm 2>/dev/null && ( openaps preflight && openaps gather && openaps enact) || echo No CGM data."'`. If you want to also add some retry logic to try again if something failed, you could then do something like `openaps alias add retry-loop '! bash -c "until( ! mm-stick warmup || openaps loop); do sleep 5; done"'`.

Once all that is working and tested, you will have a command that can be run manually or on a schedule to collect data from the pump and cgm, calculate IOB and a temp basal suggestion, and then enact that on the pump. 

## A barebones loop

- Make sure all dirs that have new files generated are cleaned out
- Get CGM data
- Get pump data
- Get Basal Suggestions
- Check if you need to put suggestions in place and if you do, then run them

## A more advanced loop
**Pull pump settings once an hour**

**Log everything!**
- Make sure only one loop runs at a time
- Verify you can talk to the pump, you can't reset the USB carelink connection
- Make sure all dirs that have new files generated are cleaned out
- Get CGM data
- Get pump data
- Get Basal Suggestions
- Check if you need to put suggestions in place and if you do, then run them
	- Pull pump settings again since you just modified the pump
	- get latest ns treatment time
	- format latest nightscout treatments
	- upload recent treatments
