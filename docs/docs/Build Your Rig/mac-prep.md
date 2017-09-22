# Mac users: Use Terminal to log into your rig

## Plug into your rig 

Plug both cables into the rig and your Mac. 

![Explorer Board rig with two cables and red light on](../Images/Edison/ExplorerBoard_two_charging_cables.png) 

Once you plug in the cables, you should see your Edison board in your Finder as a connected “device” (similar to what you would see if you plug in a USB thumb drive).  If you don’t… 1) Try unplugging and replugging the existing cables; 2) try different cables.  If your USB port is bad and not recognizing the device, you may need to [reset your SMC first](https://support.apple.com/en-au/HT201295) (it’s not hard to do, takes 2 minutes.)

![Edison in Finder](../Images/Edison/Edison_in_Finder_folder.png) 

## Open Terminal

Go to your Applications folder and find the Terminal App in the Utilities folder.  Double click to open it.

![Terminal example](../Images/Edison/Terminal_example.png)

Terminal is how we communicate with the Edison.  Basically, the Edison is a computer that lacks a keyboard and display.  By using a cable connected to the rig, we can login to the Edison and use Terminal as a way of interacting with the Edison. 

When you first launch Terminal, you will probably see something rather plain like below.  The important thing to know is that the Terminal helps show you WHERE you are in your computer or Edison.  So, in the screenshot below, it’s telling me I am in my “iMac4K” user account.  If you are ever a little confused where you are…you can look to the left of the $ prompt and get an idea.

![Terminal](../Images/Edison/Inside_terminal.png)

## Log into your rig

First, copy and paste: `sudo screen /dev/tty.usbserial-* 115200`, then hit enter.

You’ll most likely be asked for your **computer password**.  Enter it, but don't expect to see the characters logging as you type.  Terminal app doesn't show keystrokes for password entries.  A blank screen will likely come up, then press enter to wake things up to show an Edison login prompt.  Use login: “root” and the password will likely be "edison".  No quotes on either. If you purchased a preflashed board from Hamshield...a slip of paper is included that will confirm the password to use. Unflashed edisons do not have a password initially. 

If you have a problem getting to the Edison login prompt, and possibly get a warning like "can't find a PTY", close that terminal window.  Then unplug the usb cables from your computer (not from the Edison...leave those ones as is) and swap the USB ports they were plugged in.  Open a new terminal window, use the `sudo screen /dev/tty.usbserial-* 115200` command again.  Usually just changing the USB ports for the cables will fix that "can't find a PTY" error.

(**Note**: In the future, you will log into your rig by typing `ssh root@edison.local`, when you do not have the rig plugged into your computer. Also note that if you change your hostname, it will be `ssh root@whatyounamedit.local`)

You should now see the command prompt change to be root.

Head back to the other docs to continue the setup process.
