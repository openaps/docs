# Information about compatible insulin pumps

!["Can I do OpenAPS with this pump?"](../Images/Can_I_close_the_loop_with_this_pump_May_18_2018.png)

As you can see from the flowchart above, most of the commercial pumps currently available are not compatible with OpenAPS; only a small selection of older Medtronic pumps are compatible.  For those pumps which are not compatible, we suggest the advocacy option of calling the pump manufacturer and informing them of the need for availability of pumps for DIY closed looping systems.  Thus far, there has not been a receptive pump company to these requests.  Omnipod, Animas, T-Slim, and newer Medtronic pumps are still not compatible.

Currently, only the following Medtronic MiniMed models allow us to remotely set temporary basal rate commands, which is required to do OpenAPS:

    512/712 (all firmware)
    515/715 (all firmware)
    522/722 (all firmware)
    523/723 (with firmware 2.4A or lower)
    554/754 (European Veo, with firmware 2.6A or lower; OR Canadian Veo with firmware 2.7A or lower)

NOTE: For European/WorldWide users who have access to a `DANA*R/RS`, `Roche Accu-chek Combo` or `Roche Accu-chek Insight` insulin pump, you may be able to use AndroidAPS, which leverages OpenAPS's oref0 algorithm but allows you to interface using an Android phone and Bluetooth to communicate directly with the `DANA*R`/`DANA*RS`/`Roche Accu-chek Combo`/`Insight` pump. [See here for instructions and details related to AndroidAPS](http://wiki.AndroidAps.org).

## How to check pump firmware (check for absence of PC Connect)

The firmware version will briefly display after the initial count-up on a new battery insertion.  After the pump has been on for a while, you can check the firmware version by using the Esc button on the pump and scroll all the way to the bottom of the screen messages using the down arrow on pump. 

A double-check for pump compatibility is to look for the ABSENCE of PC connect in the pump menu.  Press the ACT button, scroll down to the "Utilities" menu.
* If there is a "Connect Devices" menu look for a "PC Connect" option. 
  * This is the case for the 523/723 and 554/754 models.
  * If "PC Connect" is present, then the pump will NOT work for looping. 
  * If "PC Connect" is absent, then the pump should be able to receive temp basal commands and be compatible.
 * If there is no "Connect Devices" menu, then the pump should be able to receive temp basal commands and be compatible.
   * This is the case for the 512/712, the 515/715 and 522/722 models. 
   * For 512/712 pumps, certain commands like Read Settings, BG Targets and certain Read Basal Profile are not available, and require creating special files for the missing info to successfully run the loop ([Instructions for 512/712 users, click here](http://openaps.readthedocs.io/en/latest/docs/Build%20Your%20Rig/x12-users.html)). 512/712 users are not going to be able to use an advanced feature - (e)SMB - but will be able to do basic looping.

Note that not _all_ possible sellers of pumps will accuratly describe the model number: if they are willing to sell a pump they may not have interest in setting it up for looping, and the distinctions about model numbers and firmware version may not be important to them. It will be for you though! Therefore, it's prudent to verify the model by seeing pctures and/or videos of the pump in action. 

If you have one of the above mentioned pumps, but it has buttons that do not work, use the instructions found on this [Imgur photo album](http://imgur.com/a/iOXAP) to repair your pump.  This repair is quite straight-forward and easy.

## Why do I need a certain pump firmware?

Due to changes in the firmware, the openaps tools are only able to function in-full on the above pump models. Security features were added after firmware v2.4 in the US that prevent making some remote adjustments via the decoded communications OpenAPS uses. 

If you are not based in the US, some later model pumps and firmware may be compatible as listed above. Check for PC Connect absence to determine compatibility.

## Can I downgrade my pump firmware?

One of the most frequently asked questions is "I have a 723 pump but it has version 2.5B software version.  Has anyone figured out a way to make newer model Medronic pumps compatible?  Like flash older version of software onto my 723 2.5B pump?"  The answer is "No.  The ability to downgrade software versions in the pumps does not exist.  It has been investigated and nobody has made any successful progress to that end."

## Tips for finding a compatible pump

If you need to acquire a compatible pump, check CraigsList, ask around local or pay-it-forward Facebook groups, or talk to friends in your local community to see if there are any old pumps lying around in their closets gathering dust. [SearchTempest](http://www.searchtempest.com) is a great tool for searching Craigslist nationally all at once. In addition to searching for listings, consider posting an offer to Craigslist or ask around local community groups.

If you're buying a pump online, we recommend you ask the seller to confirm the firmware version of the pump. (You may also want to consider asking for a video of the pump with working functionality before purchasing.)

<details>
    <summary> <b>Other purchasing tips (click here to expand)</b>:</summary>
<br>

* Use Paypal and purchase using the "Goods and Services" payment option. This costs nothing for the buyer, but the seller will lose 2.95% of the sale to Paypal fees. Paypal offers some protection for both buyer and seller in the event of fraud.

* Ask for photos of the pump. Check to make sure the serial number of the pump on the backside matches the serial number of the pump showing in the display menu. Ask for a short video of the pump, or at least a photo of the pump turned on, so that you can see the pump's firmware and model number. Cracks and some wear on these pumps is expected...these pumps are not usually free of any marks. Many people are successfully looping on pumps that have cracks and rub marks...but you may want to ask if you are concerned about any you see.

* Ask for shipping that includes a tracking number. USPS Priority Mail's smallest box is a great option. It's only $7.15 and includes tracking. Ask the seller to add a small bit of packing protection such as bubble wrap around the pump to keep it safe during shipping. Make sure you get a tracking number within a reasonable period of time after you have paid.

Red flags that may indicate a scam:

* Asking for payment through "friends and family" on Paypal, especially if you don't know the person or have any solid references for them. Paying in that way offers you no buyer protection. It's just like giving the seller cash, so you had better trust the seller.

* Offering an "almost new" pump is a big red flag. These pumps should be at least 5 years old by now. Do you really think a 5 year old pump should be unused and sitting in shrink wrap at this point? Seems highly suspicious.

* Not able to provide new pictures of the pump when requested. Sure they posted some pictures with the ad, but what if they just downloaded them from other people's ads? The seller should be able to furnish a couple "new" photos are your request. A good one to ask for is the battery and reservoir tops so you can see the condition of those.

</details>

## Word of warning: Pump repairs rendering pumps useless for looping

If you need to send your pump away to Medtronic for repair, be aware that during the repair process the firmware will get upgraded. This makes your pump not usable for looping. Ask the community if you run into a pump error - the community has tips for solving several common pump errors.

## Tips for longer battery life

If you are new to looping, one of the first things you will notice is that you will go through batteries _very_ quickly. Even known good alkaline batteries may only last a few days of 24/7 looping. Many OpenAPS users recommend [Energizer Ultimate Lithium](https://www.amazon.com/Energizer-Ultimate-Lithium-Batteries-Count/dp/B06ZYWKBRB/) batteries. These should last a week or more. Just ensure you use the correct settings if you are using NightScout - [see here for details about alert settings in Nightscout for the different battery types](https://openaps.readthedocs.io/en/latest/docs/While%20You%20Wait%20For%20Gear/nightscout-setup.html#battery-monitoring)
