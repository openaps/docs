# How A DIY Open Source Closed Loop “Artificial Pancreas” Works

How do you make decisions about your diabetes? You gather data, crunch the numbers, and take action. 

A DIY loop is no different. It gathers data from:
* your pump
* your CGM
* any other place you log data in, like Nightscout


It then uses this information to do the math and decide how your basal rates might need to be adjusted (above or below your underlying basal rate), to adjust and eventually keep or bring your BGs into your target range. 

## How does your closed loop gather data?

With OpenAPS, there is a “rig” that is a physical piece of hardware. It has “brains” on the computer chip to do the math; plus a radio stick to communicate with your pump; plus it can talk to your phone and to the cloud via wifi to gather additional information, plus report to the world about what it’s doing. 
