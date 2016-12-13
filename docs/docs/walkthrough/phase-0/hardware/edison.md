# Hardware information for Intel Edison-based setups

## Power supply 

Literally any charger with a USB plug will work just great. The edison will use 0.2 amp and it will adjust voltage. The explorer board has its own battery charger circuitry. The battery will charge at 1 amp.

## Cables 

The charger cable will connect to the charger and to the edison explorer board micro USB connector labeled P7, UART. This is a usb cable.
The flash cable will be used at the beginning of setup to connect from the PC to the explorer board. That is standard usb to micro usb.
The data cable will connect to the G5 receiver and to the edison explorer board micro USB connector labeled P6, OTG. This is a usb OTG cable. Here are a few examples of what can be used. The first example is a micro usb converter to OTG so that a standard micro to micro USB cable can be used. https://www.amazon.com/gp/product/B015GZOHKW/ref=oh_aui_detailpage_o02_s00?ie=UTF8&psc=1
These next examples will not need the above exampled usb to OTG converter. https://www.amazon.com/gp/product/B00TQOEST0/ref=oh_aui_detailpage_o01_s01?ie=UTF8&psc=1 or https://www.amazon.com/gp/product/B01M4L4DZC/ref=oh_aui_detailpage_o01_s00?ie=UTF8&psc=1 or https://www.amazon.com/gp/product/B018M8YEX0/ref=ox_sc_sfl_title_1?ie=UTF8&psc=1&smid=ATVPDKIKX0DER

## Edison 

[Intel Edison Compute Module](http://www.intel.com/content/www/us/en/do-it-yourself/edison.html) - Get it from [Amazon](http://www.amazon.com/gp/product/B00PTVSVI8?dpID=51yqQB46DIL&dpSrc=sims&preST=_SL500_SR135%2C135_&refRID=6AE996400627CC0KPY52&ref_=pd_rhf_se_s_cp_2), Adafruit, Sparkfun or your nearest provider.

## Lipo Battery 

Use a LiPo battery because the explorer has battery charger circuitry on board for these batteries. The example setup uses a [2000mah LIPO battery](http://www.robotshop.com/en/37v-2000mah-5c-lipo-battery.html). This battery lasts in the region of 20 hours. The connector on this battery is a 2mm 2 pin JST to match the explorer board power plug. It's best to buy from a reputable supplier, since they are prone to catching fire. 

## Explorer Board or another base board 

You can use just about any base board, including the Intel base board or the Sparkfun base board, both of which are commonly sold with the Edison as a kit. Or, purchase the [Explorer Board](https://enhanced-radio-devices.myshopify.com/products/900mhz-explorer-block-pre-order), which was co-designed by this community. It will begin shipping in November 2016 and is going to be the main board supported by the docs moving forward. It also has the benefits of a built-in radio stick.

## Nuts and Bolts 

(2) M2 screws
(6) M2 nuts, four will be used as spacers
The reason we need these is because there is a delicate 70 pin connector. Explorer and compute boards will be plugged together. The nuts and bolts will stabilize and harden the connection.

## Radio stick

You can use a number of radio sticks. Again, we recommend the Explorer Board with a built-in TI stick. Otherwise, you can use a [TI-USB-Sticks](http://www.ti.com/tool/cc1111emk868-915), running [subg_rfspy](https://github.com/ps2/subg_rfspy); [Wireless Things ERF](https://www.wirelessthings.net/erf-0-1-pin-spaced-radio-module); [Wireless Things Slice of Radio](https://www.wirelessthings.net/slice-of-radio-wireless-rf-transciever-for-the-raspberry-pi) a Slice of Radio; or a Rileylink. For details about setup with these other stick and board options, [the best instructions will be found in the mmeowlink wiki](https://github.com/oskarpearson/mmeowlink/wiki) for setting up your board and stick. Note you may also need a CC debugger for these. Then, come back to Phase 1 of the docs once you complete that.


Once you've gotten your equipment, you'll want to head to the "[Setting Up Your Intel Edison](https://github.com/openaps/docs/blob/dev/docs/docs/walkthrough/phase-0/setup-edison.md)" page.
