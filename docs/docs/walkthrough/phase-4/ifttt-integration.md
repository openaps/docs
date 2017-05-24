# IFTTT Integration

Want to be able to set or cancel temp targets from your phone, Pebble, Alexa, or anything that supports If This, Then That (IFTTT)?  Check out the YouTube Video below to see some sample integrations (click on the watchface photo to start video):

<a href="https://youtu.be/0ck23JTa2Wk" target="_blank"><img src="https://raw.githubusercontent.com/openaps/docs/master/docs/docs/Images/PebbleTempTargets.png" alt="Pebble and OpenAps" width="400" height="400" border="10" title="Click on the hairy arm to watch how it works!" /></a>


## IFTTT Setup for phones

* First we need to gather one thing called your "hashed API Secret".  This is basically your Nightscout site's API secret, but scrambled into a confusing long string for safety.  Find out what your NS hashed secret key is by running the command to find out: `nightscout hash-api-secret <your_API_secret>` while logged into your rig 
---OR----
* In your internet browser, open a console window while viewing your Nightscout site.  Make sure you have "authenticated" your site by using your API secret in the Nightscout settings area (hint: if you see a little padlock in the upper left corner of the site, you haven't authenticated it).  Refresh the site and your hashed secret key will be shown as "apisecrethash: "xxxxxxxxxx...""  For Safari users on Mac, you can open the console window by selecting "Develop" from the Safari top menu, and then "Show Page Source" (if you do not see "Develop" in the top menu, activate it by going to Safari > Preferences... > Advanced, and checking the "Show Develop menu in menu bar" option).  If you're having problems seeing the apisecrethash, click the little grey triangle next to the "status isAuthenticated" line and the objects below it will display (see screenshot).  Your hashed API secret can be copied and pasted from that line, as shown below.  Save that somewhere easy to get to again, because you will be using it later.

![IFTTT sign up](../../Images/hashed_API.png)

* Get an [IFTTT account](https://ifttt.com/join) 

![IFTTT sign up](../../Images/IFTTT_signup.png)

* Login to your IFTTT.com account and select the "New Applet" button.

![IFTTT new applet](../../Images/IFTTT_newapplet.png)

* In the screen that appears, click on the blue "+this" part of the screen

![IFTTT this](../../Images/IFTTT_this.png)

* In the next screen, type "button" in the search field and then click on the red box labelled "ButtonWidget"

![IFTTT button widget](../../Images/IFTTT_button.png)

* Connect the buttonwidget by clicking on the large red "connect" button

![IFTTT button connect](../../Images/IFTTT_connect1.png)

* Click on the large red "button press" box 

![IFTTT button press](../../Images/IFTTT_buttonpress.png)

* Click on the blue "+that" text

![IFTTT then](../../Images/IFTTT_that.png)

* Enter "maker" in the search field and click on the Maker Webhooks app

![IFTTT maker](../../Images/IFTTT_maker.png)

* Connect the Maker app

![IFTTT maker connect](../../Images/IFTTT_connect2.png)

* Select the green "Make a Web Request" box

![IFTTT web request](../../Images/IFTTT_webrequest.png)

*  Now you will have a blank web request template to complete.  

![IFTTT action fields](../../Images/IFTTT_actionfields.png)

The following info should be filled in:

URL: https://yoursite.herokuapp.com/api/v1/treatments.json (change the "yoursite" part to your NS info)

Method: POST

Content Type: application/json

Body:  The content of the body will depend on the action that you would like this particular button press to perform.  You can only do ONE of the actions per button.  Some sample content:

### Example IFTTT trigger conent

Eating soon
```
  {"enteredBy": "IFTTT-button", "eventType": "Temporary Target", "reason": "Eating Soon", "targetTop": 80, "targetBottom": 80, "duration": 60, "secret": "your_hashed_api_goes_here!!!"}
```
Activity
```
  {"enteredBy": "IFTTT-button", "eventType": "Temporary Target", "reason": "Activity", "targetTop": 140, "targetBottom": 120, "duration": 120, "secret": "your_hashed_api_goes_here!!!"}
```
Cancel Temp Target
```
{"enteredBy": "IFTTT-button", "eventType": "Temporary Target", "duration": 0, "secret": "your_hashed_api_goes_here!!!"}
```
Low Treatment (change carb amount to match your typical low treatment)
```
{"enteredBy": "IFTTT-button", "reason": "low treatment", "carbs": 10, "secret": "your_hashed_api_goes_here!!!"}
```
Low Treatment with a 60 min high target to help recovery
```
{"enteredBy": "IFTTT-button", "eventType": "Temporary Target", "reason": "low treatment", "carbs": 5, "targetTop": 120, "targetBottom": 120, "duration": 60, "secret": "your_hashed_api_goes_here!!!"}
```
Pump Site Change
```
{"enteredBy": "IFTTT-button", "eventType": "Site Change", "duration": 0, "secret": "your_hashed_api_goes_here!!!"}
```
CGM Sensor Start
```
{"enteredBy": "IFTTT-button", "eventType": "Sensor Start", "duration": 0, "secret": "your_hashed_api_goes_here!!!"}
```

### Understanding the JSON in the Body:

* enteredBy: Will show up on the NS website this way - enter what you want
* eventType: defines what we are doing - leave as is
* reason: will show up on the NS website - enter what you want
* targets: specify the range you want - enter what you want
* duration: you can make them as long or as short as you want - enter what you want
* secret: your hashed API secret key

* Click the "Create Action" button on the bottom of the screen when you finish.


* Now is your chance to change the title of your Applet now to something meaningful.  You can turn on notifications, too, using the slider shown.  If you turn on the notifications, you will get an alert on your phone and pebble watch when the button press has been successfully deployed.  Finish the IFTTT button by clicking on the Finish button that appears.  

![IFTTT finish](../../Images/IFTTT_finish.png)

* Repeat the setup for New Applets for as many automated actions as you would like to setup.

![IFTTT applets](../../Images/IFTTT_applets.png)

## Enable IFTTT in your Nightscout site

* Find your Maker Key by going to your IFTTT account, Services and then clicking on Maker, then Maker settings.

![IFTTT services account](../../Images/IFTTT_services.png)

![IFTTT services2](../../Images/IFTTT_services2.png)

* You will see your Maker Key as the last part of the URL; copy and paste that last part (the red underlined part as shown)

![IFTTT markerkey](../../Images/IFTTT_makerkey.png)

* Login to your Nightscout site host (azure or heroku) and (1) add your Maker Key to the MAKER_KEY line and (2) add "maker" to your ENABLE line.

![IFTTT NS marker key](../../Images/IFTTT_NSkey.png)

![IFTTT NS enable](../../Images/IFTTT_enable.png)

## Install IFTTT app on your iPhone/Android

* Download the IFTTT app on your phone and log in.

* You can add homescreen quick buttons.  Click on your IFTTT app and login, click on My Applets in the bottom right corner, and then click on the applet that you'd like to work with.  From the the middle of the applet, click on the Widget Settings, and then click on the Add button for the Homescreen Icon.

![IFTTT homescreen](../../Images/IFTTT_homescreen.png)

* For iPhone users, if you downswipe from the top of your iPhone screen, you will have the Today view or Notifications showing.  They are separate pages; Today view is on the left, Notifications is on the right.  You can left/right swipe to go between them.  Go into the Today view and scroll to the bottom, click "edit". This should show a list of existing widgets, followed by a list of "more widgets" with green + signs.  Click on the IFTTT's green circle and the widget will be moved to the top, active widgets area.  You can hold your finger on the three left lines of the IFTTT widget row to drag it to the top of your widget panel, if you prefer to have it as the top-most widget. 

![IFTTT Today View](../../Images/IFTTT_today.png)

If you end up with more than four IFTTT applets, they will appear in reverse-order of when they were created...which may not be the same as you'd prefer them to appear on your widget bar.  If you'd like to reorder them:

  * go into your iPhone's IFTTT app
  * click on My Applets
  * click on the gear icon in upper left of screen
  * click on Widgets
  * click on the pencil icon in upper right of screen
  * click and hold the three lines that appear on the right side of the widget that you want to move.  Drag the widget to the order in the list that you'd like it to appear in your widget quickscreen.

![IFTTT Today View](../../Images/IFTTT_reorder.png)

## ThisButton for the Pebble Watch - pictured at the very top of this page

* Load the ThisButton app from the Pebble Store.
* You need to enter your Maker key in the Settings for ThisButton on your phone when you go into the Pebble App
* Under Events, there are two fields
   * Name: what shows up on your watch
   * Event: the name of the Maker event to fire.  It will have underscores in it like: `eating_soon`.
* Enter all the different events you created here and submit them.
* Fire up the ThisButton app on your Pebble and try setting a new temp target.
* You can also add the ThisButton app as a short cut on your Pebble. If you don’t have shortcuts already, press and hold either the up, down, or middle button and follow the prompts. If you have both shortcuts programmed and want to change one, go to menu > settings> quick launch and follow prompts.

Note: ThisButton does not work on Pebble Round watches.  You can search for IFTTT apps in the pebble store and choose one that is similar, however.  The concept of setting up the events is similar.

## Alexa integration
* Since you have IFTTT/Maker requests working, you can get it to work with anything that supports IFTTT, including Alexa. You will need to add "alexa" to your ENABLE line in your Nightscout host settings (azure) or config vars (heroku).  And then repeat the steps above, but instead of using "ButtonWidget" service we started with earlier (the "+if" part of the setup)...you will use the "AmazonAlexa" service.

  ![Maker Request](../../Images/alexa_maker.png)
  * Alexa requests do not need underscores, FYI.
  
## Google Calendar integration

* Using the Google Calendar Applet with IFTTT is useful to trigger temp targets that may occur on a recurring schedule, although you can also schedule a one-time event in advance as well.  If you already have IFTTT/Maker requests working it's easy to add.  Follow the directions for Setup for Phones above, but rather than choosing "Button Widget" type "Google Calendar" in the search field and then click on the box labeled "Google Calendar".  
* You will need make sure to allow the Google Calendar Applet access to your Google Calendar.  When you do this it will ask which calendar you want to connect.  You can use your main calendar, or a calendar you've set up especially for IFTTT events.  You'll need to do this ahead of time using the administrative functions of Google Calendar.  To do this click on the gear icon at the upper right of Google Calendar (google.com/calendar, not the Applet in IFTTT), choose settings, choose the calendar tab (upper left) and then click the button to make a new calendar.  Call it whatever you want and set permissions as appropriate.  
* Once you've connected the appropriate calendar, continue your setup in IFTTT and choose "Event from search starts".  Type a phrase that you'll use on the Google Calendar to denote a temp target (or other event).  For example "Eating Soon" or "Activity" and then click the button that says create trigger. Click on the blue "+that" text and continue to follow the directions as above from Setup for Phones above to connect the Maker app and make the appropriate Web request.  
* Now on your Google Calendar (make sure you create the event on whichever calendar you've connected to the Google Calendar IFTTT applet) you can create recurring events or one-time events to trigger temp targets.  Use the same phrase that you used to create the trigger (Eating Soon, Activity, etc).  For example, if you get up every day and eat at the same time during the week, schedule Eating Soon on those days at the appropriate time.  If you know you're going to take a day off work or school just remember to delete the event ahead of that date, or change as appropriate.  Gym class for a child or sports practice only some days of a month?  Sit down and schedule Activity Mode for those dates well in advance so you don't have to remember at the time and they'll trigger automatically.   
