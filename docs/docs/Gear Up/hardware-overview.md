# Hardware overview

This section describes the hardware components required for a 'typical' OpenAPS implementation. There are numerous variations and substitutions that can be made but the following items are recommended for getting started. 

The basic setup requires:

* a compatible insulin pump
* a CGM
* a small computer (Intel Edison, or Raspberry Pi for example) and a radio board/stick (e.g. Explorer Board for Edison or Explorer HAT for Pi)
* a battery 

If you come across something that doesn't seem to work, is no longer available, or if you have a notable alternative, feel free to edit this documentation with your suggestions.

**Note about deprecated hardware setups:** Carelink can be used with up to oref0 0.6.2. However, it will not be used with oref0 0.7.0 moving forward. Carelink has poor range and will likely frustrate you. Please see the rig parts page for current hardware recommendations.

TI sticks (via USB) are not supported in oref0 0.7.0, but they can be wired to the SPI or UART pins on the Raspberry Pi. Please see the rig parts page for documentation on how to do this.
