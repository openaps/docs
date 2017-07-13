#!/bin/bash

apt-get install -y sudo
sudo apt-get update && sudo apt-get -y upgrade
# install nodejs 6.x instead of the old 0.10 that debian defaults to
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y git python python-dev python-software-properties python-numpy python-pip nodejs watchdog strace tcpdump screen acpid vim locate jq lm-sensors mosh && \
sudo pip install -U openaps && \
sudo pip install -U openaps-contrib && \
sudo openaps-install-udev-rules && \
sudo activate-global-python-argcomplete && \
sudo npm install -g json oref0 2>&1 | cat && \
echo openaps installed && \
openaps --version


