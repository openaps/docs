# Get your rig hardware

You have two main options for hardware:

* For most of 2017, the preferred rig was an Edison + Explorer Board. This is still a highly recommmended rig, if you can find an Intel Edison. [See below for details on Edison setups](http://openaps.readthedocs.io/en/latest/docs/Gear%20Up/edison.html#hardware-information-for-intel-edison-based-setups).
* The other option is a Raspberry Pi-based setup, with the new Explorer HAT (shipping begins end of April 2018). This documentation will be updated with more Pi details as they are decided.

## Hardware information for Pi-based setups with the Explorer HAT

After April 2018, there will be a Pi+HAT rig as an option for closing the loop with OpenAPS. The HAT can be pre-ordered or ordered from the same place that makes the Explorer Board ([click here to pre-order](https://enhanced-radio-devices.myshopify.com/products/900mhz-explorer-hat?variant=1950212653065)). We call it the "Explorer HAT", to differentiate from the Explorer "Board" that goes with the Edison (see below).

## Hardware information for Intel Edison-based setups

Note: The Edison/Explorer Board Block combination is the rig setup recommended by the community for size, range, and portability reasons. The high level parts list (see below for more details, and links):

* [Explorer Board Block](http://openaps.readthedocs.io/en/latest/docs/Gear%20Up/edison.html#explorer-block)
* [Edison](http://openaps.readthedocs.io/en/latest/docs/Gear%20Up/edison.html#edison)
* [Nuts and Bolts to attach the Edison to the Explorer Board Block](http://openaps.readthedocs.io/en/latest/docs/Gear%20Up/edison.html#nuts-and-bolts)
* [At least one Lithium battery](http://openaps.readthedocs.io/en/latest/docs/Gear%20Up/edison.html#lithium-ion-polymer-lipo-battery-or-other-battery-supply)
* [2 USB cables](http://openaps.readthedocs.io/en/latest/docs/Gear%20Up/edison.html#usb-cables)

### Explorer Board Block

The recommended board to use is the [Explorer Board Block](https://enhanced-radio-devices.myshopify.com/products/900mhz-explorer-block-pre-order), which was co-designed by this community. It also has the benefits of a built-in radio. It's only available from Hamshield/Enhanced Radio Devices.

### Edison 

There are 4 types of Edison's. All of them work, but Versions 3 and 4 require an extra antenna, so 1 and 2 are preferred (1-EDI2.LPON, 2-EDI2.SPON, 3-EDI2.LPOF, and 4-EDI2.SPOF).  If the seller does not specify the Edison model/version, you can see from the picture whether or not it has a white ceramic antenna in the corner.  If it does not, then it will require an external antenna, but that version is fairly rare.

* Option 1 - Buy it from places like Ebay, Craiglist, or your nearest store  - and follow the instructions to flash it.  

  * You may need to hunt for an Edison as supplies of them are dwindling - if you get it as part of a "kit" (i.e. breakoutboard + Edison), keep in mind _you'll still need to get the Explorer Board Block from Hamshield_.

  * **Note:** If you are doing Option 1 (an Edison from wherever you can find it) - you are getting an UNFLASHED Edison. Not a big deal - flashing it with jubilinux is just a few more steps (~15 minutes) - but remember you'll need to start with the flashing instructions. Follow the steps for flashing on (a) [all-computers page](http://openaps.readthedocs.io/en/latest/docs/Resources/Edison-Flashing/all-computers-flash.html) (with the most comprehensive [troubleshooting section](http://openaps.readthedocs.io/en/latest/docs/Resources/Edison-Flashing/all-computers-flash.html#troubleshooting)); b) the [Mac-specific flashing page](http://openaps.readthedocs.io/en/latest/docs/Resources/Edison-Flashing/mac-flash.html); or c) the [Windows-specific flashing page](http://openaps.readthedocs.io/en/latest/docs/Resources/Edison-Flashing/PC-flash.html)), but stop before installing wifi and other steps and instead jump over to the "[Install OpenAPS](http://openaps.readthedocs.io/en/latest/docs/Build%20Your%20Rig/OpenAPS-install.html)" page from there. 

* Option 2 - (previously [buy an Edison that is already flashed with jublinux when supplies were available](https://enhanced-radio-devices.myshopify.com/products/intel-edison-w-jubilinux). If you get a pre-flashed Edison, you can start [installing and setup OpenAPS](http://openaps.readthedocs.io/en/latest/docs/Build%20Your%20Rig/OpenAPS-install.html). (You would not need to "flash" the Edison). 

### Lithium-ion polymer (LiPo) battery or other battery supply

The Explorer Boards have battery charger circuitry on board, making it easy to use a LiPo battery. 

* The example setup uses a [2000mah LiPo battery](http://www.robotshop.com/en/37v-2000mah-5c-lipo-battery.html); also [Lithium Ion Battery - 3.7v 2000mAh](https://www.adafruit.com/products/2011) or [Adafruit Battery Packs Lithium Ion Battery 3.7v 2000mAh](https://www.amazon.com/Battery-Packs-Lithium-3-7v-2000mAh/dp/B0137ITW46) are similar options, although many people prefer a higher capacity battery to get a full day from the rig (such as [Adafruit Lithium Ion Polymer Battery - 3.7v 2500mAh (PRODUCT ID: 328) and the Adafruit Lithium Ion Cylindrical Battery - 3.7v 2200mAh (PRODUCT ID: 1781)](https://www.adafruit.com/category/574)). This battery uses a 2mm 2 pin JST connector to match the Explorer boards' power plugs. 
* For people in the UK, you may find you have to shop around to find the correct battery, as shipping restrictions appears to have reduced the supply somewhat. [Pimoroni](https://shop.pimoroni.com/products/lipo-battery-pack) appear to stock the same Adafruit 2000mAh battery as mentioned above. Another source looks to be [Cool Components](https://www.coolcomponents.co.uk/en/lithium-polymer-battery-2000mah.html), but you may find shipping costs expensive. CAUTION: [RS Online](https://uk.rs-online.com/mobile/p/lithium-rechargeable-battery-packs/1251266/) sell a similar battery, but unfortunately it comes with the wrong JST connector (it comes with a 2.5mm JST XHP-2, and you need a 2mm JST PH). It is possible, however, to buy the [right connectors](https://www.technobotsonline.com/jst-ph-2mm-2-way-housing-excludes-female-pins.html) and fit them yourself (numerous 'how to' videos on YouTube).
* For people in Australia you can find 2000mAh, 2200mAh and 2500mAh batteries from [Little bird electronics](https://www.littlebirdelectronics.com.au/batteries/), prices are very competitive and shipping is quick. These are the same Adafruit batteries that can be obtained from the US above.

**Note**: It's best to buy from a reputable supplier, because if the internal two cells are mismatched the Explorer board cannot charge them seperately and they are prone to catching fire. Make sure that it *includes a protection circuit* to protect over-discharge. **NEVER** connect the battery to an Explorer board the wrong way round. There is no manufacturing standard so never assume correct polarity. The connector JP1 on the Explorer Block has two terminals. The left side is positive, the right side is negative. The side with the JP1 label is the positive side. Typically a battery's red wire is the positive wire.  Ideally you want a battery that has a 10k ohm thermistor for temperature protection by the Edison too.

You can also use any charger with a USB plug, including a wall power charger. The Explorer boards have pass through charging, so this is also how you will charge the LiPo battery.

#### Battery safety

You should monitor the rig periodically - **especially the LiPo battery**, checking for swelling or damage. Immediately discontinue use of any battery that shows sign of swelling or damage.

### Radio stick (only if not using Explorer board)

We recommend an Explorer Board with a built-in radio ([see above](http://openaps.readthedocs.io/en/latest/docs/Gear%20Up/edison.html#explorer-block)), because if you get an Explorer Board, you don't need an additional radio stick or CC-Debugger. 

If you don't use an Explorer board, you can use a number of radio sticks: a [TI-USB-Sticks](http://www.ti.com/tool/cc1111emk868-915), running [subg_rfspy](https://github.com/ps2/subg_rfspy); [Wireless Things ERF](https://www.wirelessthings.net/erf-0-1-pin-spaced-radio-module); [Wireless Things Slice of Radio](https://www.wirelessthings.net/slice-of-radio-wireless-rf-transciever-for-the-raspberry-pi) a Slice of Radio; or a Rileylink. For details about setup with these other stick and board options, [the best instructions will be found in the mmeowlink wiki](https://github.com/oskarpearson/mmeowlink/wiki) for setting up your board and stick. Note you may also need a CC debugger for these, and also note that it will be more work as the documentation is designed for the Edison/Explorer Board setup as the easiest path forward. 

### USB Cables

You will need two micro USB cables - with a micro connector on one end and a standard (Type A) connector on the other. Most cables will work fine, but some prefer to select lengths. You may already have one for charging a Dexcom receiver, or an Android phone, lying around at home. If you don't, here's an example of one that will work: [Monoprice Premium USB to Micro USB Charge, Sync Cable - 3ft](http://www.monoprice.com/Product?c_id=103&cp_id=10303&cs_id=1030307&p_id=9763&seq=1&format=2).

Warning: bad cables cause a lot of headaches during the Edison flashing process, so it may be worth verifying before you start if you have good cables that can transfer data.

### Optional: Micro USB to Micro USB OTG Cable for offline looping

You may want to connect your Dexcom receiver (G4 or non-touchscreen G5) to your Explorer Block for offline looping.  For this you will need to use a micro USB to micro USB OTG cable (or an OTG adapter). Here is an example of a cable that will work: [BestGameSetups Micro USB to Micro USB OTG (On-The-Go) 12" (30cm) Data Cable](https://www.amazon.com/dp/B00TQOEST0/ref=cm_sw_r_cp_api_Niqfzb3B4RJJW).

### Nuts and Bolts

You will likely want to screw your Edison onto the Explorer Block to stabilize the rig. There are two methods to do this.  The simplest is to order a kit like the [Sparkfun Intel Edison Hardware Pack](https://www.sparkfun.com/products/13187), which provides standoffs, screws, and nuts specifically designed for the Edison. Alternatively, you can use (2) M2 screws and (2) M2 nuts and (4)  M3 nuts (M3 or a bit larger to used as spacers).  In this configuration, the screws should be just long enough to fit through the spacer nuts and screw into the M2 nuts on the other side. (Note: Sparkfun is no longer selling these screw kits. There were some available in April 2018 at [Mouser](https://www.mouser.com/productdetail/sparkfun/com-13187?qs=WyAARYrbSnZmROJb2S4FFw%3D%3D).

### Cases

You can use a variety of cases, either soft or hard. Make sure to check the case design to make sure it will support your preferred rig setup and battery size/type. Also, be careful with inserting your rig into some 3D-printed cases so you do not harm the board and/or the battery.

### Soft Cases 
* [TallyGear soft case](http://www.tallygear.com/index.php?route=product/category&path=120) - these are the soft cases Dana uses ([see this example](https://twitter.com/danamlewis/status/792782116140388353)). The OpenAPS-sized case can be made any any pattern/fabric she uses elsewhere on the site.
* [JD Burrows SD card case](https://www.officeworks.com.au/shop/officeworks/p/j-burrows-sd-and-usb-case-blue-jbsdcasbu) - this is a hard / soft case which fits the rig with a 2500mAh battery perfectly, can also fit a spare AAA pump battery (Australia)

### Hard cases 

**Warning: be careful if you select a hard case. Some may be designed for a certain size/shape battery; and attempting to jam a rig in may harm the board and/or the battery.**

Also: a hard case may make you less likely to look at your rig directly. You should monitor the rig periodically - **especially the battery**, checking for swelling or damage. Immediately discontinue use of any battery that shows sign of swelling or damage.

Generic hard cases:

* [RadioShack Project Enclosure (3x2x1 inch)](https://www.radioshack.com/products/radioshack-project-enclosure-3x2x1?utm_medium=cpc&utm_source=googlepla&variant=20332262405&gclid=Cj0KEQiA-MPCBRCZ0q23tPGm6_8BEiQAgw_bAkpDZCXfIgbEw8bq76VHtV5mLwR2kHKfJrsGsF3uqqgaAtxP8P8HAQ) 
* [Small clear plastic case perfect for larger Sparkfun 2000 mAh battery: #8483](http://www.ebay.com/itm/272062812611)
* [Small Plastic Clear Case for 2500 mAh battery](http://www.ebay.com/itm/272062812611) - Since a Tic-Tac box is too small for the 2500 mAh battery.

Cases for Edison plus battery:

* [Ken Stack's 3D design for a case with the battery next to the board](https://github.com/Perceptus/explorer_board_case) 
* [Rob Kresha's design with the battery compartment stacked on-top of the board compartment](http://www.thingiverse.com/thing:2020161)
* [Gustavo's 3D design](https://github.com/Perceptus/explorer_board_case_2)
* [Sulka Haro's 3D design](https://www.tinkercad.com/things/4a6VffpcuNt)
* [tazitoo's 3D design: CAD](https://www.tinkercad.com/things/aRYGnHXt7Ta-explorer-case/editv2) ([or STL for 3D printing](http://www.thingiverse.com/thing:2106917))
* [danimaniac's Protective Cases & Accessories](https://github.com/danimaniac/OpenAPS-Explorer-Board-Edison-vented-case)
* [Luis's ventilated acrylic simple design](https://drive.google.com/drive/folders/0BxeFg9yJZ_FZdWJEcG5KMXdUMjg?usp=sharing)
* [Robert Silvers and Eric Burt's case for Explorer and 2500 mAh battery](http://www.thingiverse.com/thing:2282398)
* [Robert Silvers' case for Explorer and 2000 or 2500 mAh battery](http://www.thingiverse.com/thing:2291125)

Cases for Edison plus G4 receiver:

* [jimrandomh's 3D printed design for Edison and a G4 receiver together](http://conceptspacecartography.com/my-openaps-g4-case/)

### Other non-case protection options

* [Heat Shrink Tubing](https://www.amazon.com/gp/product/B009IILEVY)  
