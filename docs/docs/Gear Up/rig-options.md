# Your rig hardware options

You have two main options for hardware:

1. The most recommended rig has been an Edison + Explorer Board. Unfortunately Intel stopped making the Edison boards as of 2018. If you can find an Intel Edison (eBay, local stores, etc - this is still very possible), this is still a highly recommmended rig. It is the smallest rig (and easily portable), with better battery life because it is power efficient. [Go here for the list of hardware and setup instructions for Edison setups](http://openaps.readthedocs.io/en/latest/docs/Gear%20Up/edison-explorer-board.html).
  
2. The other option is a Raspberry Pi-based setup, with the new Explorer HAT. This rig setup makes it easier to see information when offline because it has an onboard screen for displaying readouts. [Go here for hardware required and setup instructions for Pi/HAT setups](http://openaps.readthedocs.io/en/latest/docs/Gear%20Up/pi-based-rigs.html). There is also an experimental alternative to an Explorer HAT, RFM69HCW, which can serve as the radio on a Pi-based rig, but will not have the screen, and requires you to solder.

## What happens if you have multiple rigs?

If you have multiple OpenAPS rigs, they’re built to be polite to each other. Even if you had two or more rigs in same room, they won’t trip each other up. They “wait for silence” before issuing any commands to the pump. By having multiple rigs throughout a house, you can move from room-to-room without carrying rigs because the rigs will pass-off comms as you moves in and out of the rig’s range. Stationary rigs will not need LiPo batteries and can be plugged directly into a wall charger from the Explorer board.

Just like multiple Edison rigs play well together, an Edison and a Pi rig can also work fine side by side. As always, best practice is to make sure they're in the same feature set - don't have one type of rig using SMB's if the other hardware has an old code version that isn't aware of SMB's. 
