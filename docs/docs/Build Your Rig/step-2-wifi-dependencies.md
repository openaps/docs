# Step 2: Wifi and Dependencies

Steps 2-3 are covered in the page links below, dependent on which type of rig you are using.  

* If you are using an _**Intel Edison**_, start with the [Intel Edison instructions](edison-install.md).

* If you are using a _**Raspberry Pi**_, start with the [Raspberry Pi instructions](pi-install.md).





Below are the manual instructions for reference only - it is strongly recommended that you use the easy setup scripts instead.


## Initial Edison Setup

Log in as root/edison via serial console.

Type/edit the following:

    myedisonhostname=<thehostname-you-want>     #Do not type the <>

And then paste the following to rename your Edison accordingly:

    echo $myedisonhostname > /etc/hostname
    sed -r -i"" "s/localhost( jubilinux)?$/localhost $myedisonhostname/" /etc/hosts

Run these commands to set secure passwords. Make sure you save them somewhere - you will need them! It will ask you to enter your new password for each user 2 times. Type the password in the same both times.  To use SSH (which you will need to do shortly) this password needs to be at least 8 characters long.  Do not use a dictionary word or other easy-to-guess word/phrase as the basis for your passwords.  Do not reuse passwords you've already used elsewhere.

    passwd root
    passwd edison

## Set up Wifi:

`vi /etc/network/interfaces`

A screen similar to the one below will appear.  Type “i” to enter INSERT mode for editing on the file.

![Wifi edit screen](../Images/Edison/Wifi_edit_screen.png)

Type 'i' to get into INSERT mode. In INSERT mode 
* Uncomment 'auto wlan0' (remove the `#` at the beginning of the line)
* Edit the next two lines to read:
```
auto wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```
Comment out (add # at the start of the line) or delete the wpa-ssid and wpa-psk lines.

After editing, your file should look like:

```
# interfaces(5) file used by ifup(8) and ifdown(8)
auto lo
iface lo inet loopback

auto usb0
iface usb0 inet static
    address 192.168.2.15
    netmask 255.255.255.0

auto wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```

Press Esc and then type ':wq' and press Enter to write (save) the file and quit.

`vi /etc/wpa_supplicant/wpa_supplicant.conf`

Type 'i' to get into INSERT mode and add the following to the end, once for each network you want to add.  Be sure to include the quotes around the network name and password.

```
network={
    ssid="my network"
    psk="my wifi password"
}
```

If you want to add open networks to your list, then add:

```
network={
        key_mgmt=NONE
        priority=-999
}
```

If you have a hidden wifi network add the line `scan_ssid=1`.

Some wifi networks require you to accept a terms and conditions prior to allowing access.  For example, Starbucks coffee shops and many hotels.  These networks are termed "captive" networks and connecting your rig to them is currently not an option.

Other wifi networks may require you to enter a login name and password at an initial screen before allowing access (such as many school district wifi networks).  Some users have success in using the following wpa network settings for those types of networks:

```
network={
   scan_ssid=1
   ssid="network name"
   password="wifi password"
   identity="wifi username"
   key_mgmt=WPA-EAP
   pairwise=CCMP TKIP
   group=CCMP TKIP WEP104 WEP40
   eap=TTLS PEAP TLS
   priority=1
}
```

Press Esc and then type ':wq' and press Enter to write the file and quit

`reboot` to apply the wifi changes and (hopefully) get online

After rebooting, log back in and type `iwgetid -r` to make sure you successfully connected to wifi. It should print out your network name.

Run `ifconfig wlan0` to determine the IP address of the wireless interface, in case you need it to SSH below.

Leave the serial window open in case you can't get in via SSH and need to fix your wifi config.
 
If you need more details on setting up wpa_supplicant.conf, see one of these guides:

* [http://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-wifi-network/](http://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-wifi-network/)
* [http://www.geeked.info/raspberry-pi-add-multiple-wifi-access-points/](http://www.geeked.info/raspberry-pi-add-multiple-wifi-access-points/)
* [http://raspberrypi.stackexchange.com/questions/11631/how-to-setup-multiple-wifi-networks](http://raspberrypi.stackexchange.com/questions/11631/how-to-setup-multiple-wifi-networks)
* [http://www.cs.upc.edu/lclsi/Manuales/wireless/files/wpa_supplicant.conf](http://www.cs.upc.edu/lclsi/Manuales/wireless/files/wpa_supplicant.conf)


## Install packages, ssh keys, and other settings

From a new terminal or PuTTY window, `ssh root@myedisonhostname.local`. If you can't connect via `youredisonhostname.local` (for example, on a Windows PC without iTunes), you can instead connect directly to the IP address you found with `ifconfig` above.

Log in as root (with the password you just set above), and run:

    dpkg -P nodejs nodejs-dev
    apt-get update && apt-get -y dist-upgrade && apt-get -y autoremove
    apt-get install -y sudo strace tcpdump screen acpid vim python-pip locate
    
And:

    adduser edison sudo
    adduser edison dialout
    dpkg-reconfigure tzdata    # Set local time-zone
       Use arrow button to choose zone then arrow to the right to make cursor highlight <OK> then hit ENTER

Edit (with `nano` or `vi`) /etc/logrotate.conf and change the log rotation to `daily` from `weekly` and enable log compression by removing the hash on the #compress line, to reduce the probability of running out of disk space

If you're *not* using the Explorer board and want to run everything as `edison` instead of `root`, log out and log back in as edison (with the password you just set above).  (If you're using an Explorer board you'll need to stay logged in as root and run everything that follows as root for libmraa to work right.)

If you have an ssh key and want to be able to log into your Edison without a password, copy your ssh key to the Edison ([directions you can adapt are here](http://openaps.readthedocs.io/en/latest/docs/Resources/Deprecated-Pi/Pi-setup.html#mac-and-linux)).  For Windows/Putty users, you can use these instructions: [https://www.howtoforge.com/ssh_key_based_logins_putty](https://www.howtoforge.com/ssh_key_based_logins_putty).

If you're *not* using the Explorer board, are running as the `edison` users, and want to be able to run sudo without typing a password, run:
```
    $ su -
    $ visudo
```    
and add to the end of the file:
``` 
 edison ALL=(ALL) NOPASSWD: ALL   
```    
