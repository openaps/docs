# How to update your OpenAPS rig in the future

You've probably heard about all kinds of cool new features that you want to try. If they're part of the master branch already, you just need to go enable them (usually by re-running the setup script). 

However, if it's a brand-new feature that's being tested or is recently added to master, you'll probably need to take a few extra steps.

## To get on a refreshed "master" branch with the new stuff

1. `sudo npm install -g oref0`
2. `bash ~/myopenaps/oref0-runagain.sh`

## To get on "dev" branch to test the new stuff

1. `cd ~/src/oref0 && git checkout dev && git pull`
2. `npm run global-install`
3. `bash ~/myopenaps/oref0-runagain.sh`
