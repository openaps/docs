# Hardware information for Intel Edison-based setups

## Edison 

[Intel Edison Compute Module](http://www.intel.com/content/www/us/en/do-it-yourself/edison.html) - Get it from [Amazon](http://www.amazon.com/gp/product/B00PTVSVI8?dpID=51yqQB46DIL&dpSrc=sims&preST=_SL500_SR135%2C135_&refRID=6AE996400627CC0KPY52&ref_=pd_rhf_se_s_cp_2), Adafruit, Sparkfun or your nearest provider.

## Lipo Battery 

The example setup uses a [2000mah LIPO battery](http://www.robotshop.com/en/37v-2000mah-5c-lipo-battery.html). This battery lasts in the region of 20 hours. It's best to buy from a reputable supplier, since they are prone to catching fire. Make sure that it *includes a protection circuit* to protect over-discharge. **NEVER** connect the battery to the Edison base board the wrong way round. Ideally you want a battery that has a 10k ohm thermistor for temperature protection by the Edison too.

## Explorer Board or another base board 

You can use just about any base board, including the Intel base board or the Sparkfun base board, both of which are commonly sold with the Edison as a kit. Or, purchase the [Explorer Board](https://enhanced-radio-devices.myshopify.com/products/900mhz-explorer-block-pre-order), which was co-designed by this community. It will begin shipping in November 2016 and is going to be the main board supported by the docs moving forward. It also has the benefits of a built-in radio stick.

## Radio stick

You can use a number of radio sticks. Again, we recommend the Explorer Board with a built-in TI stick. Otherwise, you can use a [TI-USB-Sticks](http://www.ti.com/tool/cc1111emk868-915), running [subg_rfspy](https://github.com/ps2/subg_rfspy); [Wireless Things ERF](https://www.wirelessthings.net/erf-0-1-pin-spaced-radio-module); [Wireless Things Slice of Radio](https://www.wirelessthings.net/slice-of-radio-wireless-rf-transciever-for-the-raspberry-pi) a Slice of Radio; or a Rileylink. For details about setup with these other stick and board options, [the best instructions will be found in the mmeowlink wiki](https://github.com/oskarpearson/mmeowlink/wiki) for setting up your board and stick. Note you may also need a CC debugger for these. Then, come back to Phase 1 of the docs once you complete that.


Once you've gotten your equipment, you'll want to head to the "[Setting Up Your Intel Edison](https://github.com/openaps/docs/blob/dev/docs/docs/walkthrough/phase-0/setup-edison.md)" page.
