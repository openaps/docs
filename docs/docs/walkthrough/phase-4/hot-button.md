# Hot Button

## Purpose
[Hot Button app](https://play.google.com/store/apps/details?id=crosien.HotButton) can be used to monitor and control OpenAPS using SSH commands. It is especialy useful for offline setups. Internet connection is not required, it is enough to have the rig connected to it using bluetooth tethering.

## App Setup
In the app you can specify number of buttons. To setup the button you need to long click. At first setup the Server Settings and set them as default. For every other button you can load them.

## Basic commands
To the Command part of the button setup you can write any command which you would run in the ssh session. For example to show the automatic sensitivity ratio, you can set:
```cat /root/myopenaps/settings/autosens.json ```

After pressing of the button the command is executed and the results are displayed in the black text area bellow the buttons. 

## Temporary targets
It is possible to use Hot Button application for setup of temporary targets.  This [script](https://github.com/lukas-ondriga/openaps-share/blob/master/start-temp-target.sh) generates the custom temporary target starting at the time of its execution. You need to edit the path to the openaps folder inside it.

To setup activity mode run:
```./set_temp_target.sh "Activity Mode" 80```
To setup eating soon mode run:
```./set_temp_target.sh "Eating Soon" 130```

The script is currently work in progress. The first parameter is probably not needed, it is there to have the same output as Nightscout produces. It is not possible to set top and bottom target, but this could be easily added in the future. 
To be able to use the script, the most straigtforward solution is to disable the download of temporary targets from Nightscout. To do that edit your openaps.ini and remove ```openaps ns-temptargets``` from ns-loop. 

## SSH Login Speedup
To speed up the command execution you can add to the ```/etc/ssh/sshd_config``` the following line:
```UseDNS no```



