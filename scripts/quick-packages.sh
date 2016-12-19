#!/bin/bash

sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y git python python-dev python-software-properties python-numpy python-pip nodejs-legacy npm watchdog && \
sudo pip install -U openaps && \
sudo pip install -U openaps-contrib && \
sudo openaps-install-udev-rules && \
sudo activate-global-python-argcomplete && \
sudo npm install -g json oref0 && \
echo openaps installed && \
openaps --version


