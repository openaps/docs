# How A DIY Open Source Closed Loop “Artificial Pancreas” Works

How do you make decisions about your diabetes? You gather data, crunch the numbers, and take action. 

A DIY loop is no different. It gathers data from:
* [your pump](https://openaps.readthedocs.io/en/latest/docs/Gear%20Up/pump.html)
* [your CGM](https://openaps.readthedocs.io/en/latest/docs/Gear%20Up/CGM.html)
* any other place you log information, like [Nightscout](https://openaps.readthedocs.io/en/latest/docs/While%20You%20Wait%20For%20Gear/nightscout-setup.html)

It then uses this information to do the math and decide how your basal rates might need to be adjusted (above or below your underlying basal rate), to adjust and eventually keep or bring your BGs into your target range. 

## How does your closed loop gather data?

With OpenAPS, there is a “rig” that is a physical piece of hardware. It has “brains” on the computer chip to do the math; plus a radio stick to communicate with your pump; plus it can talk to your phone and to the cloud via wifi to gather additional information, plus report to the world about what it’s doing. 

The rig needs to:
* communicate with the pump and read history - what insulin has been delivered
* communicate with the CGM (either directly, or via the cloud) - to see what BGs are/have been doing

The rig runs a series of commands to collect this data, runs it through the algorithm and does the decision-making math based on the settings (ISF, carb ratio, DIA, target, etc.) in your pump. 

## But how does it do everything it needs to do to gather data and make decisions and tell the pump what to do?

When you build an OpenAPS rig, you run through the setup described in this documentation, and:
* physically put the pieces of your rig together
* [load the open source software on it](https://openaps.readthedocs.io/en/latest/docs/Build%20Your%20Rig/OpenAPS-install.html)
* configure it to talk to YOUR devices and have your information and safety settings on it (based on your preferences)

The open source software is designed to make it easy for the computer to do the work you used to do to calculate what needs to be done. It runs a series of reports to collect data from all the devices and places. Then it prepares the data and runs the calculations. Then it attempts to communicate and send any necessary adjustments to your pump. Then it reads the data back, and does it over and over again. You can see what it's doing in the logs of the rig, or by viewing the information on your watch or on Nightscout.
