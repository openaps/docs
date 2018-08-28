# Troubleshooting communications issues between the pump and the rig

## Basics of communications

If your looping is to be successful, you will need good communications between the pump and rig.  They communicate with each other using radio frequency (rf).  If you have an North American (Pump Model REF contains NA) or Canadian/Australian pump (CA), the rf band used is 916 MHz.  If you have a European (WW) pump, the rf band is 868 MHz.  As part of the setup script, you will be telling the rig which type of pump you have (NA or WW) so that it can properly use the right rf band to communicate with the pump.  When the rig wants to talk with the pump, it will start by "tuning the rf"... basically it will try several frequencies around the 916 or 868 MHz frequency and choose the exact frequency that has the strongest response.  The tuning process for the pump is called "mmtune".

For example, here's the results of a pump tune in oref0 0.7.0:
```
mmtune: 2018/08/19 21:05:58 connected to CC111x radio on /dev/spidev5.1
2018/08/19 21:05:58 setting frequency to 916.700
2018/08/19 21:05:58 model 723 pump
2018/08/19 21:05:58 frequency set to 916.300
2018/08/19 21:05:59 frequency set to 916.350
2018/08/19 21:06:01 frequency set to 916.400
2018/08/19 21:06:03 frequency set to 916.450
2018/08/19 21:06:04 frequency set to 916.500
2018/08/19 21:06:06 frequency set to 916.550
2018/08/19 21:06:07 frequency set to 916.600
2018/08/19 21:06:09 frequency set to 916.650
2018/08/19 21:06:10 frequency set to 916.700
2018/08/19 21:06:11 frequency set to 916.750
2018/08/19 21:06:12 frequency set to 916.800
2018/08/19 21:06:12 frequency set to 916.850
2018/08/19 21:06:14 frequency set to 916.900
2018/08/19 21:06:15 disconnecting CC111x radio on /dev/spidev5.1
{
  "scanDetails": [
    [
      "916.300",
      0,
      -128
    ],
    [
      "916.350",
      0,
      -128
    ],
    [
      "916.400",
      0,
      -128
    ],
    [
      "916.450",
      0,
      -128
    ],
    [
      "916.500",
      0,
      -128
    ],
    [
      "916.550",
      0,
      -128
    ],
    [
      "916.600",
      0,
      -128
    ],
    [
      "916.650",
      0,
      -128
    ],
    [
      "916.700",
      5,
      -86
    ],
    [
      "916.750",
      5,
      -86
    ],
    [
      "916.800",
      5,
      -86
    ],
    [
      "916.850",
      0,
      -128
    ],
    [
      "916.900",
      0,
      -128
    ]
  ],
  "setFreq": 916.75,
  "usedDefault": false
}
"916.750", 3, -70
```
  
The rig scanned frequencies between 916.300 and 916.900 mHz, and set the frequency for pump communications to 916.75 because that exact frequency had the strongest communications.  How can you see the strength by looking at these tuning results?  The lower the last number is on the tune, the better the strength.  **Results of `0, -128` indicate NO pump communications in oref0 0.7.0 or later and `0,-99` indicate NO pump communications oref0 prior to 0.7.0.  This is an undesirable result.**  Pump tune results in the 80s or lower are usually strong enough for stable looping.  If tune results are in the 90s, the rig will likely experience periodic missed pump-rig communications and looping will be intermittent.  In this example, 916.7, 916.75, and 916.8 had equally strong responses at `5, -86`; therefore, mmtune selected the mid-point frequency.

### How can you see the results of your pump tuning?

You can see the results of rf tunes (mmtune) several different ways:

1. Login to your rig and use `grep mmtune /var/log/openaps/pump-loop.log` to search your pump-loop.log for mmtune results.  Sample result:
   ```
   mmtune: "916.750", 3, -78 waiting for 36 second silence before continuing
   mmtune: "916.650", 2, -91 waiting for 62 second silence before continuing
   mmtune: "916.700", 3, -92 -- "916.750", 2, -93 waiting for 66 second silence before continuing
   mmtune: "916.750", 3, -86 waiting for 52 second silence before continuing
   mmtune: "916.800", 3, -82 -- "916.850", 0, -128 waiting for 90 second silence before continuing
   mmtune: "916.700", 2, -66 -- "916.750", 3, -66 waiting for 12 second silence before continuing
   mmtune: "916.700", 3, -69 -- "916.750", 2, -69 waiting for 18 second silence before continuing
   mmtune: "916.700", 3, -90 -- "916.750", 3, -91 waiting for 62 second silence before continuing
   mmtune: "916.750", 3, -81 waiting for 42 second silence before continuing
   mmtune: "916.750", 3, -85 waiting for 50 second silence before continuing
   mmtune: "916.750", 3, -79 waiting for 38 second silence before continuing
   mmtune: "916.800", 2, -84 -- "916.850", 0, -128 waiting for 90 second silence before continuing
   ```
2. If you setup Papertrail, search for mmtune.  For example, as shown:
   ![Papertrail mmtune results](../Images/papertrail-mmtune-sample.png) 
3. If you want to manually preform an mmtune and show the selected frequency of the entire scan in oref0 prior to 0.7.0, login to your rig and execute the command below.
   ```
   cd ~/myopenaps && sudo service cron stop && killall -g openaps ; killall -g oref0-pump-loop; openaps mmtune && sudo service cron start
   ```  
   If you are running oref0 0.7.0 or later, execute this command.
   ```
   cd ~/myopenaps && sudo service cron stop && killall -g openaps ; killall -g oref0-pump-loop; oref0-mmtune && sudo service cron start
   ```
   Here is an example of the results of that command on a rig called edison3:  
   ```
   root@edison3:~# cd ~/myopenaps && sudo service cron stop && killall -g openaps ; killall -g oref0-pump-loop; oref0-mmtune && sudo service cron start
   openaps: no process found
   oref0-pump-loop: no process found
   mmtune: "916.636", 5, -92
   root@edison3:~/myopenaps#
   ```
4. If you want to manually perform an mmtune with the full frequency scan displayed in oref0 prior to 0.7.0, execute the command below.
   ```
   cd ~/myopenaps && sudo service cron stop && killall -g openaps ; killall -g oref0-pump-loop; openaps-use pump mmtune && sudo service cron start
   ```
   If you are running oref0 0.7.0 or later, execute this command.
   ```
   cd ~/myopenaps && sudo service cron stop && killall -g openaps ; killall -g oref0-pump-loop; OREF0_DEBUG=1 oref0-mmtune && sudo service cron start
   ```
   You'll see results similar to the full scan details as shown at the beginning of this section.

### What causes poor tuning results?

There are several situations which may cause poor pump communications:

1. Most commonly, poor communications are simply a matter of **distance**.  The farther away your pump and rig are from each other, the weaker the communications are going to be.  Bringing the rig closer to the pump may resolve the problem and improve communications. How close you need to be may depend on the following variables below, as well.
2. Check for a **low pump battery**.  As pump battery gets lower in voltage, communications may fail more often.  Typically pump communications are fairly stable to around 1.3v of pump battery, but that may vary by pump and location.  Try changing the battery and see if that helps pump communications.
3. **Body blocking** between pump and rig is another common reason for poor pump communications.  The human body is an incredibly effective rf blocker (water, skin, fat...not easy for rf to penetrate).  So, if you are prone to sleeping with your pump completely covered by your body, you may end up with more frequent pump communication failures.  Or, if you have your rig on one hip and your pump on the other...even that may decrease the strength of your pump communications.
4. **Noisy RF environments** can cause problems with rig-pump communications.  If you have lots of equipment nearby all trying to use the same frequency, communications can be laggy and interrupted.  What home devices commonly operate on the 900mHz frequency?  Some older cordless phone systems, baby monitors, and older home wireless speakers are common sources.  Try switching channels on the devices (if available as an option) and using a different frequency, such as 2.4 GHz or 5 GHz.  Try temporarily unplugging those devices and seeing if you get improved pump communications.  If you are outside of the home, the troubleshooting and mitigation of noisy rf areas may be more problematic.
5. **Extreme environmental changes** can cause the rig-pump communications to be slightly shifted in frequency.  For example, going from a heated house to the outside winter snow may cause a change in the strongest tuning frequency.  When the rig attempts a fresh mmtune, it will set a new frequency and communications shouldn't be impacted for long, if at all.
6. **Explorer board not sitting properly on the Edison** The Explorer board could have become loose and lost connection to the Edison board. Disconnect power from the rig and verify the explorer board is securely connected to the Edison. Turn the power on and try again.
7. **Equipment failure** can be another cause.  If there is damage to the explorer board's antenna, you may notice poor or no pump communications.  Additionally, some pumps may have poor rf strength...after all these are older pumps and in many cases we don't know the history.  To troubleshoot if the issues are equipment related, try the pump with a new explorer board.  Or if you have a backup pump, try setting up OpenAPS with that pump.  See if the problem persists.

### How often does the rig tune?

The rig does not attempt to tune on every single pump communication.  The tuning is done on a random interval, and more frequently if pump communications are failing.  So, don't expect to see an mmtune result every minute or even every 5 minutes.  If you rig is looping regularly without failures, you can expect that mmtunes will be done less frequently because they are not needed.
