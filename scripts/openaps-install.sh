#!/bin/bash
set -e

read -p "Enter your Edison's new hostname (this will be your rig's "name" in the future, so make sure to write it down): " -r
myedisonhostname=$REPLY
echo $myedisonhostname > /etc/hostname
sed -r -i"" "s/localhost( jubilinux)?$/localhost $myedisonhostname/" /etc/hosts

# if passwords are old, force them to be changed at next login
passwd -S edison | grep 20[01][0-6] && passwd -e root
# automatically expire edison account if its password is not changed in 3 days
passwd -S edison | grep 20[01][0-6] && passwd -e edison -i 3

# set timezone
dpkg-reconfigure tzdata

#dpkg -P nodejs nodejs-dev
apt-get update && apt-get -y dist-upgrade && apt-get -y autoremove
apt-get install -y sudo strace tcpdump screen acpid vim python-pip locate
adduser edison sudo
adduser edison dialout

sed -i "s/daily/hourly/g" /etc/logrotate.conf
sed -i "s/#compress/compress/g" /etc/logrotate.conf

curl -s https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-packages.sh | bash -
mkdir -p ~/src; cd ~/src && git clone git://github.com/openaps/oref0.git || (cd oref0 && git checkout master && git pull)
cd && ~/src/oref0/bin/oref0-setup.sh

