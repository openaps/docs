# Re-running the setup script

In the future, you may want to run the setup script again (such as when you want to come back and turn on new, advanced features). To do so, you will be able to run `bash ~/myopenaps/oref0-runagain.sh` to start running the setup script again with those options you have selected for your current setup. (You may first want to `cd ~/myopenaps && cat oref0-runagain.sh` to see what options you have saved in there.  To run it again with different options, you can copy and paste and modify that output, or you can `cd ~/myopenaps && nano oref0-runagain.sh` to change what's saved in the file to run the next time.  Make sure to change `myopenaps` to your openaps directory name if you chose something non-standard when you ran oref0-setup originally.)

Don't have a runagain or want to start fresh? `cd && ~/src/oref0/bin/oref0-setup.sh`
