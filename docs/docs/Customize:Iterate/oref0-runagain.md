{\rtf1\ansi\ansicpg1252\cocoartf1348\cocoasubrtf170
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

\f0\fs24 \cf0 # Re-running the setup script\
\
In the future, you may want to run the setup script again (such as when you want to come back and turn on new, advanced features). To do so, you will be able to run `bash ~/myopenaps/oref0-runagain.sh` to start running the setup script again with those options. (You may first want to `cd ~/myopenaps && cat oref0-runagain.sh` to see what options you have saved in there.  To run it again with different options, you can copy and paste and modify that output, or you can `cd ~/myopenaps && nano oref0-runagain.sh` to change what's saved in the file to run the next time.  Make sure to change `myopenaps` to your openaps directory name if you chose something non-standard when you ran oref0-setup originally.)\
\
If you are running this and the file does not exist, that just means you have not run oref0-setup since updating oref0 to 0.4.0 or later. You will need to run oref0-setup per the above section (with or without Bluetooth); then in the future you can use oref0-runagain.sh.}