# Mac users: Use Terminal to log into your rig

Plug both cables into the rig and your Mac. 

![Explorer Board rig with two cables and red light on](./Images/Edison/ExplorerBoard_two_charging_cables.png) 

Once you plug in the cables, you should see your Edison board in your Finder as a connected “device” (similar to what you would see if you plug in a USB thumb drive).  If you don’t…try different cables.  If your USB port is bad and not recognizing the device, you may need to [reset your SMC first](https://support.apple.com/en-au/HT201295) (it’s not hard to do, takes 2 minutes.)

![Edison in Finder](./Images/Edison/Edison_in_Finder_folder.png) 

Go to your Applications folder and find the Terminal App in the Utilities folder.  Double click to open it.

![Terminal example](./Images/Edison/Terminal_example.png)

Terminal is how we communicate with the Edison.  Basically, the Edison is a computer that lacks a keyboard and display.  By using a cable connected to the rig, we can login to the Edison and use Terminal as a way of interacting with the Edison. 

When you first launch Terminal, you will probably see something rather plain like below.  The important thing to know is that the Terminal helps show you WHERE you are in your computer or Edison.  So, in the screenshot below, it’s telling me I am in my “iMac4K” user account.  If you are ever a little confused where you are…you can look to the left of the $ prompt and get an idea.

![A look inside terminal](./Images/Edison/Inside_terminal.png)
