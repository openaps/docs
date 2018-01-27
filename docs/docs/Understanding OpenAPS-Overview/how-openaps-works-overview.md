# How A DIY Open Source Closed Loop “Artificial Pancreas” Works

How do you make decisions about your diabetes? You gather data, crunch the numbers, and take action. 

A DIY loop is no different. It gathers data from:
* [your pump](https://openaps.readthedocs.io/en/latest/docs/Gear%20Up/pump.html)
* [your CGM](https://openaps.readthedocs.io/en/latest/docs/Gear%20Up/CGM.html)
* any other place you log data, like [Nightscout](https://openaps.readthedocs.io/en/latest/docs/While%20You%20Wait%20For%20Gear/nightscout-setup.html)

It then uses this information to do the math and decide how your basal rates might need to be adjusted (above or below your underlying basal rate), to adjust and eventually keep or bring your BGs into your target range. 

## How does your closed loop gather data?

With OpenAPS, there is a “rig” that is a physical piece of hardware. It has “brains” on the computer chip to do the math; plus a radio stick to communicate with your pump; plus it can talk to your phone and to the cloud via wifi to gather additional information, plus report to the world about what it’s doing. 

The rig needs to:
* communicate with the pump and read history - what insulin has been delivered
* communicate with the CGM (either directly, or via the cloud) - to see what BGs are/have been doing

The rig runs a series of commands to collect this data, runs it through the algorithm and does the decision-making math based on the settings (ISF, carb ratio, DIA, target, etc.) in your pump. 

## But how does it do everything it needs to do to gather data and make decisions and tell the pump what to do?

When you build an OpenAPS rig, you run through the setup described in this documentation, and:
* physically put your rig together
* [load the open source software on it](https://openaps.readthedocs.io/en/latest/docs/Build%20Your%20Rig/OpenAPS-install.html)
* configure it to talk to YOUR devices and have your information and safety settings on it (based on your preferences)

The open source software is designed to make it easy for the computer to do the work you used to do to calculate what needs to be done. It runs a series of reports to collect data from all the devices and places. Then it prepares the data and runs the calculations. Then it attempts to communicate and send any necessary adjustments to your pump. Then it reads the data back, and does it over and over again. 

In order to simplify the process for the human, we've designed a series of "aliases", which is a group of reports. That way, when you need to do a particular thing (gather fresh data), you can run one command instead of several or dozens. Similarly, when you want the system to run automatically, there is a scheduling program called "cron" that you will use to run multiple aliases automatically to do all of these tasks.  

Because this project is DIY, there is a chance that at some point one of the steps might fail/not work. To fix this, you will beging to "drill down" to a particular alias and find the report that is failing. Usually, these things self-resolve or running a command  manually will fix it. **If you're just starting with OpenAPS, you don't need to worry about that yet - just know there is a logical framework in the project for gathering data and getting it to where it needs to be for the computer to use it. The documentation will have a troubleshooting section later on that will help if and when you need to drill down.**
