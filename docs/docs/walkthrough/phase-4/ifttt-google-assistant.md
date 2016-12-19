# IFTTT Integration for Google Assistant

Want to use Google Assistant to set your carb intake, insulin given, eating soon, etc.? Follow the instructions below to use IFTTT with the Google Assistant service.

## Prerequisites

* Get an IFTTT.com account
* Make sure you have [Maker](https://www.ifttt.com/maker) connected to your IFTTT account.
* Make sure you have [Google Assistant](https://www.ifttt.com/google_assistant) connected to your IFTTT account.
* Find out what your NS hashed secret key is by running the command to find out: `nightscout hash-api-secret <your_secret_key>`
* Or, open a console window in your browser while viewing your Nightscout site, hit refresh, and your hashed secret key will be shown as "apisecrethash: "xxxxxxxxxx...""

## Putting it all together

* Create a new recipe on IFTTT.com that starts with the Google Assistant trigger service and ends with Maker action service.
* Select "My Applets" -> "New Applet" -> click the large "+This" -> search for Google Assistant
* Choose "Say a phrase with a number"
* Enter the phrase you want to say to Google Assistant and what you want the Assistant to say in response. For example: "Enter # carbs" where the "#" is used to signify the number of carbs you'll be speaking. Click the "Create Trigger" button.
* Now select "+That" and search for Maker -> Make web request
* URL:  https://your_url_hereish.herokuapp.com/api/v1/treatments.json <- Only change your url, don't modify what comes after it
* Method: Post
* Content Type: application/json
* Body:
```
  {"enteredBy": "GoogleAssistant", "carbs": {{NumberField}}, "secret": "your_secret_hashed_key_goes_here"}
```

## Understanding the JSON in the Body:

* enteredBy: Will show up on the NS website this way - enter what you want
* carbs: Uses the NumberField ingredient to post the number you stated
* secret: Your hashed API secret key

## Test your Google Assistant:

* Test your Google Assistant request by saying "Ok Google" and then speaking whatever your trigger saying was.
* Go to your Nightscout site and look for the entry
  * It should show in about 5 seconds
  * If you don't see the entry, go back to IFTTT and review the applet activity log under the applets settings for any errors

## Create more events / requests:

* Create other triggers by repeating the process and changing up the wording  
* An example to enter insulin is shown below:
```
{"enteredBy": "GoogleAssistant", "insulin": {{NumberField}}, "secret": "your_secret_hashed_key_goes_here"}
```
