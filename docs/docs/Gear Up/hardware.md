# Hardware overview

This section describes the hardware components required for a 'typical' OpenAPS implementation. There are numerous variations and substitutions that can be made but the following items are recommended for getting started. 

_The basic setup requires:_
* a compatible insulin pump
* a Dexcom G4 or G5 CGM, or a Medtronic CGM
* a small computer (Intel Edison, for example)
* a radio stick (not necessary for an Intel Edison plugged into an Explorer Board, which has radio comms built-in)
* a battery 

If you come across something that doesn't seem to work, is no longer available, or if you have a notable alternative, feel free to edit this documentation with your suggestions.

To start, here is a high-level guide for understanding if your pump is compatible for OpenAPS. To be compatible, we must be able to send remote temporary basal rate commands to it.

!["Can I do OpenAPS with this pump?"](../Images/Can_I_close_the_loop_with_this_pump_July_13_2017.jpg)

As you can see from the flowchart above, most of the commercial pumps currently available are not compatible with OpenAPS; only a small selection of older Medtronic pumps are compatible.  For those pumps which are not compatible, we suggest the advocacy option of calling the pump manufacturer and informing them of the need for availability of pumps for DIY closed looping systems.  Thus far, there has been not been a receptive pump company to these requests.  OmniPod, Animas, t:slim, and newer Medtronic pumps are still not compatible.  

If you're interested in working on decoding communication for one of these non-compatible pumps (OmniPod, Animas, etc.), [click here](http://bit.ly/1nTtccH) to join the collaboration group focusing on alternative pump communication.

#### Notes about deprecated hardware setups

If you have looked at the docs before, you may remember seeing Carelink sticks and/or Raspberry Pis as a more prominent recommendation. The community has generally moved away from Carelink sticks (because of poor range and other errors) as part of reliable rig use. The community has also moved toward using Edison-based rig setups due to the smaller size and lower cost of these setups overall compared to the Pi rigs. The [Pi instructions still work and still exist](https://github.com/openaps/docs/blob/master/docs/docs/walkthrough/phase-0/hardware/raspberry-pi.md); however as of March 12, 2017, they are no longer the top recommended setup option. The community recommends following the documentation for buildling a rig based on the Edison and Explorer Board (which has a built-in radio stick to further reduce size, increase portability, and increase reliable looping range). 
