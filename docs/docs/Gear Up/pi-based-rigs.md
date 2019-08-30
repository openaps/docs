# Pi-based setups with the Explorer HAT

## Parts you'll need 

Summary of what you need for a Pi/HAT rig:
* [Explorer HAT](<#hat>)
* [Pi0WH (recommended) or Pi 3](<#pi>)
* [Battery](<#battery>)
* [SD Card](<#sd-card>)

### HAT: 
As of April 2018, there is be a Pi+HAT rig as an option for closing the loop with OpenAPS. The HAT can be ordered from the same place that makes the Explorer Board ([click here](https://enhanced-radio-devices.myshopify.com/products/900mhz-explorer-hat?variant=1950212653065)). We call it the "Explorer HAT", to differentiate from the Explorer "Board" that goes with the Edison (see below).

![Explorer Hat](../Images/explorerhat.png)

### PI 
You also need a Raspberry Pi. Many users are opting for the "Raspberry Pi Zero WH" - with headers - so you don't have to solder, and can simply add the HAT onto the Pi. See this [PiZeroWH from Adafruit](https://www.adafruit.com/product/3708), or [from other sellers around the world](https://www.raspberrypi.org/products/#buy-now-modal)

As an alternative, you can also use the HAT with a Raspberry Pi 3. 

### Battery
Lipo batteries are typically used to power the rig on the go because they charge quickly and come in a variety of compact sizes.  When choosing a battery, you have a trade-off between a larger battery with longer duration or a smaller battery with shorter duration that is easier to carry around.  A 2000 mah battery is roughly the size of the Raspberry Pi0, and can last around 4 hours.  You'll want a "1S" type, which uses a single cell and outputs at 3.7 VDC.  It needs a JST connector to plug into the Raspberry Pi.  See this [battery from HobbyKing](https://hobbyking.com/en_us/turnigy-2000mah-1s-1c-lipoly-w-2-pin-jst-ph-connector.html?___store=en_us).

If you will need to run longer than that while unplugged from wall power, consider a portable charger.  These are in widespread use for cell phones and commonly available in a large number of sizes.  Here is an example [portable charger from Amazon](https://www.amazon.com/Anker-PowerCore-Ultra-Compact-High-speed-Technology/dp/B0194WDVHI/ref=sr_1_6?ie=UTF8&qid=1532089932&sr=8-6&keywords=backup+battery&dpID=31B5rBNP%252B8L&preST=_SY300_QL70_&dpSrc=srch).  Using a USB to micro-USB adapter you can power the rig from the portable charger by plugging the charger into the Power port, which is the micro-USB port nearest the corner of the Pi0.

**Note**: You will probably want to underclock your Raspberry Pi to get a longer battery life. [See this for details](<../Customize-Iterate/usability-considerations#improving-the-battery-life-of-your-raspberry-pi>).

### SD card
An 8 GB SD card should provide plenty of space for the linux operating system, OpenAPS code and storage for log files.  The ability to use larger and removable storage is one of the advantages of the Raspberry Pi.  You can get a [MicroSD card and adapter from Adafruit](https://www.adafruit.com/product/2692) when you order your Pi and Hat.  Or you can get an equivalent [8 GB SD card from Amazon](https://www.amazon.com/Kingston-microSDHC-Class-Memory-SDC4/dp/B00200K1TS/ref=sr_1_8?s=wireless&ie=UTF8&qid=1532090813&sr=1-8&keywords=8gb+micro+sd) or other sellers.

### Note about Pi+HAT cases
Because we are still optimizing the software to be as power-efficient as possible, we have not narrowed down on the best recommended battery.  You may want to use a soft case for ease of access to the components, flexible arrangement and the ability to use a variety of battery sizes.  If you are using the 2000 mah battery above, you can use this [3d printed hard case](https://www.thingiverse.com/thing:3010231) to protect the rig and battery in a relatively compact package.  The [design is built in OnShape](https://cad.onshape.com/documents/74459dfcb527ad12c33660aa/w/2be92a72bb7f1c83eb091de2/e/b4fa9c3be204ffa3dea128a1), which has a free access level subscription for public domain documents.  You can make a copy and tweak the design to your liking.

#### Putting together and using your Pi/HAT rig

If you chose a "Pi Zero WH" (with headers), you will place the HAT on the Pi.

##### Buttons and Menu System

The Explorer Board Pi HAT includes a 128x64 OLED display with two general purpose buttons to navigate an included menu system.

##### Button Navigation

The Pi HAT has two general purpose buttons labeled "Up" and "Down". A single press of the "Up" button will move the menu selection cursor up a single menu item and a single press of the "Down" button will move the menu selection cursor down a single menu item.

A double press of the "Down" button will enter in currently selected menu item as indicated by the ">" next to a menu item.

A double press of the "Up" button will take you back to the previous screen.

##### LEDs

The Pi HAT offers 4 LEDs labeled with D1-D4. D1 is the charging LED and works as described above. D2 is the battery low indicator. It turns orange when the LiPo battery voltage goes below 3.6 V or when the rig is plugged and the battery switch is on OFF. D3 and D4 are connected to the CC1110 radio processor and are controlled by the subg_rfspy radio firmware while resetting the radio. That happens repeatedly during wait-for-silence.

##### Menu Items

<details>
 <summary><b>The current tree of available menu items (click to expand):</b></summary>
<br>

* OpenAPS
  * Status Graph
  * Set Temp Target
    * Cancel temp Target
    * Eating Soon: 60m@80
    * Speaking: 45m@110
    * Walking: 45m@120
    * Running: 60m@140
  * Status Text
  * Enacted Reason
  * Show pump-loop.log
  * Unicorn Logo
* Wifi
  * Current Wifi Network
  * Current Hostname
  * Current IP Address
  * Show network.log
* System
  * Voltage
  * Display Tests
    * Checkerboard 1
    * Checkerboard 2
    * All On
    * Boxes 1
    * Boxes 2
  * lsusb
  * Reboot
  * Cancel Reboot

</details>
<br>

A series of images of the menu items can be [viewed here](https://imgur.com/a/9qLf93B).

##### Charging

The rig can be charged via microUSB. Like an Edison rig, you can use a single cell (1s) lipo battery or similar; or use wall power.

**Note:** the charging LED on the board is not working currently (unless you remove the Q3 transistor). Currently, it’s basically just a “plugged into the wall” indicator. The only side effect of removing Q3 is on the binary charging signal to the Pi (which doesn’t work anyway, and we’ve not tried to use). The voltage monitoring should work fine either way, but while the rig is charging will report 4.2V (“fully charged”) any time the battery is more than about 50% charged. So to be sure if it’s charged you should unplug the rig.

**2nd Note:** make sure the battery plug is switched to ON while the rig is plugged. Otherwise the battery won't charge.


*** 


## Building and using your Pi/HAT rig

If you chose a "Pi Zero WH" (with headers), you will place the HAT on the Pi.

### Buttons and Menu System

The Explorer Board Pi HAT includes a 128x64 OLED display with two general purpose buttons to navigate an included menu system.

### Button Navigation

The Pi HAT has two general purpose buttons labeled "Up" and "Down". A single press of the "Up" button will move the menu selection cursor up a single menu item and a single press of the "Down" button will move the menu selection cursor down a single menu item.

A double press of the "Down" button will enter in currently selected menu item as indicated by the ">" next to a menu item.

A double press of the "Up" button will take you back to the previous screen.

#### Menu Items

<details>
 <summary><b>The current tree of available menu items (click to expand):</b></summary>
<br>

* OpenAPS
  * Status Graph
  * Set Temp Target
    * Cancel temp Target
    * Eating Soon: 60m@80
    * Speaking: 45m@110
    * Walking: 45m@120
    * Running: 60m@140
  * Status Text
  * Enacted Reason
  * Show pump-loop.log
  * Unicorn Logo
* Wifi
  * Current Wifi Network
  * Current Hostname
  * Current IP Address
  * Show network.log
* System
  * Voltage
  * Display Tests
    * Checkerboard 1
    * Checkerboard 2
    * All On
    * Boxes 1
    * Boxes 2
  * lsusb
  * Reboot
  * Cancel Reboot

</details>
<br>

A series of images of the menu items can be [viewed here](https://imgur.com/a/9qLf93B).

### Charging and power

The rig can be charged via microUSB. Like an Edison rig, you can use a single cell (1s) lipo battery or similar; or use wall power.

**Note:** the charging LED on the board is not working currently (unless you remove the Q3 transistor). Currently, it’s basically just a “plugged into the wall” indicator. The only side effect of removing Q3 is on the binary charging signal to the Pi (which doesn’t work anyway, and we’ve not tried to use). The voltage monitoring should work fine either way, but while the rig is charging will report 4.2V (“fully charged”) any time the battery is more than about 50% charged. So to be sure if it’s charged you should unplug the rig.

**2nd Note:** make sure the battery plug is switched to ON while the rig is plugged. Otherwise the battery won't charge.

### LEDs

The Pi HAT offers 4 LEDs labeled with D1-D4. D1 is the charging LED and works as described above. D2 is the battery low indicator. It turns orange when the LiPo battery voltage goes below 3.6 V or when the rig is plugged and the battery switch is on OFF. D3 and D4 are connected to the CC1110 radio processor and are controlled by the subg_rfspy radio firmware while resetting the radio. That happens repeatedly during wait-for-silence.


## Pi-based setups with RFM69HCW (experimental)

The Pi + RFM69HCW is still experimental!

If you are a maker person or a bit into soldering electronics at least, you may also build your rig with a piece of hardware, that is a lot cheaper than the Explorer HAT, although it does **not** have the screen. You also won't have LEDs indicating status, no battery charging and there will not be (m)any 3d printable case models. If it's your only option because you're on a budget and can't afford to spend 150 bucks on a rig, please think about this step twice. This one will cost you only 30, but a lot of extra time.

<details>
    <summary> <b>
Click here to expand and see pictures of a rig with a Pi0WH and RFM69HCW:</b>:</summary>
<br>

![Picture of RPI0WH with FM69HCW connected via breadboard](../Images/build-your-rig/RPi_breadboard_connected_to_RFM69HCW.jpg)

![Picture of RPI0WH with FM69HCW view from the top ](../Images/build-your-rig/RPi_soldered_RFM69HCW_top_view.jpg)

![Picture of RPI0WH with FM69HCW view of soldered connections](../Images/build-your-rig/RPi_soldered_RFM69HCW.jpg)

![Picture of RPI0WH with FM69HCW and case](../Images/build-your-rig/RPi_open_case_with_battery_view_on_RFM69HCW.jpg)

Here's a rough-and-ready budget version of a rig put together: contents of a 2000mAh powerbank, a plastic housing, a micro USB cable and some more soldering and hot glue. BE AWARE that this case will most likely overheat the Pi after a while. You need to at least drill some venting holes into the lid. 

![Picture of the RPI0WH with case](../Images/build-your-rig/RPi_open_case_with_Pi_on_top.jpg)
![Picture of the RPI0WH with case open and a view of the battery](../Images/build-your-rig/RPi_open_case_with_battery_view_on_RFM69HCW.jpg)
![Picture of the RPI0WH with case next to the pump](../Images/build-your-rig/Rig_case_with_pump.jpg)

</details>

### Summary of what you need: 
* Raspberry Pi Zero 
* RFM69HCW 
* [microSD Card]((<../Gear Up/pi-based-rigs#sd-card))
* Bread board
* Jumper wires
* Soldering iron
* Power source via Micro USB

### The Raspberry Pi Zero

For this setup, you want a Raspberry Pi Zero WH. (The "H" means it has Header pins). (Also, a regular Raspberry Pi 3 model B works fine.)

### RFM69HCW
You can buy this board e.g. [here](https://www.adafruit.com/product/3070), but you can really buy it wherever you want. These boards are, like the RPi Zero, very common. Just make sure you get the right frequency. 868/915 MHz is correct. All others are wrong. 

### Breadboard
Any breadboard will do, no special requirements.

### Soldering
You need to solder the pin stripe into the RFM69HCW. Insert the pin stripe from the bottom of the board, with the short endings reaching through the holes. Fixate a bit, so you can rest the soldering iron tip on the pins and the board. 

Solder the included pin stripe diligently into the 9 holes named 
VIN GND EN G0 SCK MISO MOSI CS RST

Cut an antenna at your preferred length corresponding to your frequency. This can be a simple piece of isolated, unshielded wire. (I simply took one of the jumper wires for my first try.)
Calculate your length here: https://m0ukd.com/calculators/quarter-wave-ground-plane-antenna-calculator/ and just use the value from A (first green box). This should be the length of your antenna, from the soldering point on the board to the tip.

Solder it to the board. It's the hole near the "o" from Radio. Make sure to not connect the soldering to the ground plates left and right from the hole. This antenna is really only connected to the one hole.

This is your connection scheme for the RPi to RFM69HCW. Stick the RFM69HCW on a bread board, and connect:

Board | Connect | Connect | Connect | Connect | Connect | Connect | Connect | Connect
------|------|------|------|------|------|------|------|------
RPi	| 3.3V	| GND	| MOSI | MISO | SCLK	| | CEO_N	|| 
RPi PIN	| 17	| 25	| 19	| 21	| 23	| 16	| 24	| 18
RFM69HCW	| VIN or 3.3V	| GND	| MOSI	| MISO	| SCK or CLK	| G0 or DIO0	| CS or NSS	| RST or RESET

![Picture of RPI0WH with FM69HCW connection diagram](../Images/build-your-rig/rpii2RFM69HCW.JPG)


[Here is a copy of a a sophisticated schematic](https://easyeda.com/editor#id=4128da76dc1644c9a1cf6fd53ec1885f|003da073fac94f058c872b643d1d9e22). (Press "miniloop v1.0" to see the diagram).

After that, you're ready to install OpenAPS. 

***




