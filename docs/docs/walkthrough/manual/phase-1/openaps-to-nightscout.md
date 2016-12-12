# Alternate Nightscout OpenAPS Instructions

To get your OpenAPS viewed onto your Nightscout site, start by using the following tool:(It would be a good idea to be disconnected from your pump and do a Bolus Wizard so you can check the status of your Nightscout uploading.)
$nightscout autoconfigure-device-crud
To view your data on your Nightscout site, start by doing the following:

`nightscout autoconfigure-device-crud <https://yourname.com yourplainapisecret>`

So this would be your actual https://myname.azurewebsites.net  or https://myname.herokuapp.com (without the carrots of course). Your API_SECRET is listed in your Azure or Heroku settings.

To test this: `openaps use ns shell preflight`\
It should return "True"

After the nightscout autoconfigure-device-crud has run successfully you may want to add ns.ini to your .gitignore file to protect your nightscout site location and secret key. You can find more information about this in the 
<a href="https://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-1/using-openaps-tools.html#backing-up-your-openaps-instance">Backing up your openaps instance</a> section.

To get a good list of aliases:

`curl -sg https://gist.githubusercontent.com/bewest/d3db9ca1c144b845382c885138a8f66e/raw/181c5d6f29cd6489ecc9630786cf2c4937ddde79/bewest-aliases.json > bewest-aliases.json`

`nano bewest-aliases.json` and make sure that the script references the report names that you created.  If not, change the report names to the names that you set up.

`cat bewest-aliases.json | openaps import`

To pull data:  `openaps gather-clean-data`

To set up Nightscout reports:

`curl -sg https://gist.githubusercontent.com/bewest/d3db9ca1c144b845382c885138a8f66e/raw/522155bae116983499bb1de30f10f52eb3c4b6b7/ns-reports.json > ns-reports.json`

`nano ns-reports.json` and make sure that the script references the report names that you created.  If not, change the report names to the names that you set up.

`cat ns-reports.json | openaps import`

To see your progress: `openaps do-everything`

To add the Maximum Insulin On Board to be 2 units:
`oref0-mint-max-iob 2 max-iob.json`

Then again, to check your progress:  `openaps do-everything`
At this point, you should see treatment circles, information about the battery, etc.

To verify what was uploaded to Nightscout:
`cat nightscout/uploaded.json`

Then to add the ns-status device to your openaps.ini:
`oref0 device-helper ns-status 'ns-status $*' | openaps import`

Then test the ns-status device (Adjust the report directories as needed):
`openaps use ns-status shell monitor/clock.json oref0-monitor/iob.json oref0-predict/oref0.json oref0-enacted/enacted-temp-basal.json monitor/battery.json monitor/reservoir.json monitor/status.json`

You should see a lot of info. (Side note: the word "received" under the "enacted" heading is typoed.)\

If you receive an error you have most likely not included all reports;\
running `openaps use ns-status shell -h` will show positional arguments.
These arguments are required; `clock iob suggested enacted battery reservoir status`
you can also supplement additional reports (i.e., remainder).

Make sure to save this as a report:
`openaps report add nightscout/openaps-status.json JSON ns-status shell monitor/clock.json oref0-monitor/iob.json oref0-predict/oref0.json oref0-enacted/enacted-temp-basal.json monitor/battery.json monitor/reservoir.json monitor/status.json`

Now it needs to be invoked to test that it is getting data.
`openaps report invoke nightscout/openaps-status.json`

Test uploading it:
`openaps use ns shell upload devicestatus.json nightscout/openaps-status.json`

If it works, save it as a report:
`openaps report add nightscout/uploaded-recent-devicestatus.json JSON ns shell upload devicestatus.json nightscout/openaps-status.json added ns://JSON/shell/nightscout/uploaded-recent-devicestatus.json`

Now those aliases we did earlier need adjustment for all of the recent work we just did:
`openaps alias add report-nightscout "report invoke nightscout/preflight.json nightscout/recent-treatments.json nightscout/uploaded.json nightscout/recent-missing-entries.json nightscout/uploaded-entries.json nightscout/openaps-status.json nightscout/uploaded-recent-devicestatus.json"`

SUCCESS!!

To upload to Nightscout, use:  `openaps do-everything`
To just test uploading to Nightscout, use: ` $openaps report-nightscout`

Make sure to backup all the work you have just done:
`oref0 export-loop | tee backup-loop.json`

