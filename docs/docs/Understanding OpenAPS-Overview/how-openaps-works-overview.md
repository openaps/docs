# How A DIY Open Source Closed Loop “Artificial Pancreas” Works

How do you make decisions about your diabetes? You gather data, crunch the numbers, and take action. 

A DIY loop is no different. It gathers data from:
* [your pump](<../Gear Up/pump>)
* [your CGM](<../Gear Up/cgm>)
* any other place you log information, like [Nightscout](<../While You Wait For Gear/nightscout-setup>)

It then uses this information to do the math and decide how your basal rates might need to be adjusted (above or below your underlying basal rate) in order to keep or bring your BGs in your target range. 

## How does the closed loop gather data?

With OpenAPS, there is a “rig” that is a physical piece of hardware. It has “brains” on the computer chip to do the math; plus a radio stick to communicate with your pump; plus it can talk to your phone and to the cloud via wifi to gather additional information and report to the world about what it’s doing. 

The rig needs to:
* communicate with the pump and read history - what insulin has been delivered
* communicate with the CGM (either directly, or via the cloud) - to see what BGs are/have been doing

The rig runs a series of commands to collect this data, runs it through the algorithm, and does the decision-making math based on the settings (ISF, carb ratio, DIA, target, etc.) in your pump. 

## How does it control the pump based on its decisions?

When you build an OpenAPS rig, you follow the instructions in this documentation to:
* physically put the pieces of your rig together
* install the open source software on it
* configure it to talk to YOUR devices and use your preferences and safety settings

The open source software is designed to make it easy for the computer to do the work you used to do to calculate what needs to be done. During each "loop" - about every five minutes - the rig collects data from your pump and CGM. It prepares the data and runs the calculations. Then it sends any necessary adjustments to your pump. You can see what it's doing in the logs of the rig, or by viewing the information on your watch or on Nightscout.

You can learn more about how the system is designed for safety in the [OpenAPS Reference Design](https://OpenAPS.org/reference-design/) and read more about the calculations [in the 'How it Works' section](<../How it works/understand-determine-basal#understanding-the-determine-basal-logic>).