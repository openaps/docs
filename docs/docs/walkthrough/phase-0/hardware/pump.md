# Information about compatible insulin pumps

!["Can I do OpenAPS with this pump?"](Can_I_close_the_loop_with_this_pump_May_20_2016.jpg "Can I do OpenAPS with this pump?")

Currently, only the following Medtronic MiniMed models allow us to remotely set temporary basal rate commands, which is required to do OpenAPS:

    512/712
    515/715
    522/722
    523/723 (with firmware 2.4A or lower)
    554/754 (European Veo, with firmware 2.6A or lower; OR Canadian Veo with firmware 2.7A or lower)

## How to check pump firmware

To check firmware, hit Esc on the home screen and scroll all the way to the bottom. You can also go into the Utilities menu and look for a PC Connect option. If that is present, the pump will not work for looping. If it’s absent, it should be able to receive temp basal commands.)

If you have one of the above mentioned pumps, but it has buttons that do not work, use the instructions found on this [Imgur photo album](http://imgur.com/a/iOXAP) to repair your pump.

## Why do I need a certain pump firmware

Due to changes in the firmware, the openaps tools are only able to function in
full on the above pump models. Security features were added after the firmware
version 2.4 in the US that prevent making some remote adjustments via the CareLink USB
stick. Each pump series is slightly different, and openaps functionality is
still being ironed out for some of them. For 512/712 pumps, certain commands
like Read Settings, BG Targets and certain Read Basal Profile are not available,
and requires creating a static json for needed info missing to successfully run
the loop ([see example here](http://bit.ly/1itCsRl)).

If you are not based in the US, some later model pumps and firmware may be compatible. Check for PC Connect presence to determine compatibility.

## Tips for finding a compatible pump

If you need to acquire an appropriate pump check CraigsList or other sites like
Medwow or talk to friends in your local community to see if there are any old
pumps lying around in their closets gathering dust. [MedWow](http://www.medwow.com) is an eBay-like source for used pumps. [SearchTempest](http://www.searchtempest.com) is a great tool for searching Craigslist nationally all at once. In addition to searching for listings, consider posting an offer to Craigslist or ask around local community groups.

Note: If you're buying a pump online, we recommend you ask the seller to confirm the
firmware version of the pump. (You may also want to consider asking for a video
of the pump with working functionality before purchasing.)

## Battery usage

Repeated wireless communication with the pump drains the battery quite quickly.
With a loop running every five minutes, a standard alkaline AAA—recommended by
Medtronic—lasts somewhere between four to six days before the pump goes to a
"Low Battery" state and stops allowing wireless transmission. Lithium batteries
last significantly longer but do not give much warning when they are about to
die, but alerts can be created in Nightscout to provide warning about the status of the
battery. For further information on batteries, see
[this study](https://gist.github.com/channemann/0a81661b78703fcb8da6) on AAA
battery use in a looping pump.
