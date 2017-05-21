#!/bin/bash
set -e
echo TODO: make this script install openaps

### Adding notes from http://openaps.readthedocs.io/en/latest/docs/walkthrough/phase-0/edison-explorer-board-Mac.html#wifi-for-edison and beyond to make it easier for the full script/to see what most of the steps were from manually doing this all

# reboot needed?
# should we have them set hostname and change password? prompt them for that? or do that later?

# `ssh root@edisonhost.local` or new hostname

# Run ping google.com to make sure your rig is online.

# dpkg -P nodejs nodejs-dev
# apt-get update && apt-get -y dist-upgrade && apt-get -y autoremove
# apt-get install -y sudo strace tcpdump screen acpid vim python-pip locate
# adduser edison sudo
# adduser edison dialout
# dpkg-reconfigure tzdata # Set local time-zone

### Was this already done in previous script?
#    Enter vi /etc/logrotate.conf then press “i” for INSERT mode, and make the following changes:
 #   set the log rotation to daily from weekly
  #  remove the # from the “#compress” line
   # Press ESC and then type “:wq” to save and quit


# curl -s https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-packages.sh | bash -
# mkdir -p ~/src; cd ~/src && git clone git://github.com/openaps/oref0.git || (cd oref0 && git checkout master && git pull)
# cd && ~/src/oref0/bin/oref0-setup.sh
