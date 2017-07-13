#!/bin/bash

# TODO: remove the `-o Acquire::ForceIPv4=true` once Debian's mirrors work reliably over IPv6
apt-get -o Acquire::ForceIPv4=true install -y sudo
sudo apt-get -o Acquire::ForceIPv4=true update && sudo apt-get -o Acquire::ForceIPv4=true -y upgrade
# install nodejs 6.x instead of the old 0.10 that debian defaults to
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get -o Acquire::ForceIPv4=true install -y git python python-dev python-software-properties python-numpy python-pip nodejs npm watchdog strace tcpdump screen acpid vim locate jq lm-sensors && \
sudo pip install -U openaps && \
sudo pip install -U openaps-contrib && \
sudo openaps-install-udev-rules && \
sudo activate-global-python-argcomplete && \
sudo npm install -g json oref0 && \
echo openaps installed && \
openaps --version


