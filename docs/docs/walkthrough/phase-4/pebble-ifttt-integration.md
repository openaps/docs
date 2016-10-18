#Pebble / IFTTT Integration

Want to be able to set or cancel temp targets from your Pebble watch easily?  You need an IFTTT.com and Maker account and a Pebble watch connected to a phone with Internet access to make it work.  Check it the YouTube Video below:

<a href="https://www.youtube.com/watch?v=0ck23JTa2Wk&feature=youtu.be" target="_blank"><img src="../../Images/PebbleTempTargets.png" alt="Pebble and OpenAps" width="400" height="400" border="10" title="Click on the hairy arm to watch how it works!" /></a>


Cool and handy, right?  I saw my daughter was double arrows down yesterday while I was in the shower and I was able to issue an activity mode temp target (140 for one hour) to help pull her out of a nose dive.

##Prerequisites
* Get an IFTTT.com accout
* Make sure you have a [Maker account](https://ifttt.com/maker)
* Find out what your NS hashed secret key is
  Run the command to find out: `nightscout hash-api-secret <your_secret_key>`
* Get the app ThisButton for your Pebble

##Putting it all together
1. Create a new recipe on IFTTT.com that starts and ends with Maker requests
  * Event Name: eating_soon (Maker requests must be lowercase and use underscores and not spaces)
  * Action:  https://your_url_hereish.azurewebsites.net/api/v1/treatments.json
  * Method: Post
  * Content Type: application/json
  * Body: 
````
  {"enteredBy": "ThisButton-Maker", "eventType": "Temporary Target", "reason": "Eating Soon", "targetTop": 80, "targetBottom": 80, "duration": 60, "secret": "a_totally_hashed_password_goes_here!!!"}
 ````
![Maker Request](../../Images/maker_request.png)

2. Understanding the JSON in the Body:
  * enteredBy: Will show up on the NS website this way - enter what you want
  * eventType: defines what we are doing - leave as is
  * reason: will show up on the NS website - enter what you want
  * targets: specify the range you want - enter what you want
  * duration: you can make them as long or as short as you want - enter what you want
  * secret: your hashed API secret key

3. Create more!
  * activity_mode would be 140 for an hour...or whatever you want.  You definitely want to create a cancel_temp_target as well.  It would look like this: 
````
{"enteredBy": "Alexa-Maker", "eventType": "Temporary Target", "duration": 0, "secret": "a_totally_hashed_password_goes_here!!!"}
````

4. Hook it up with ThisButton
  * You need to enter / get your Maker API key in the Settings for ThisButton on your phone
  * Under Events, there are two fields
     * Name: what shows up on your watch
     * Event: the name of the Maker event to fire.  It will have underscores in it like: eating_soon . 
 * Enter all the different events you created here and Submit them.
 * Fire up the ThisButton app on your Pebble and try setting a new temp target.

5. Since you have IFTTT / Maker requests working, you can get it to work with anything that supports IFTTT, including Alexa.
  ![Maker Request](../../Images/alexa_maker.png)
  * Alexa requests do not need underscores, FYI.

#Big thanks
To Jason Calabrese for coming up with this method and sharing it!
