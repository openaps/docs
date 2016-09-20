#!/bin/bash

sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y git python python-dev python-software-properties python-numpy python-pip nodejs-legacy npm watchdog && \
# ( curl -s https://bootstrap.pypa.io/ez_setup.py | sudo python ) && \
# sudo easy_install -ZU setuptools && \
# sudo easy_install -ZU openaps && \
# sudo easy_install -ZU openaps-contrib && \
sudo pip install -U openaps && \
sudo pip install -U openaps-contrib && \
sudo openaps-install-udev-rules && \
sudo activate-global-python-argcomplete && \
sudo npm install -g json oref0 && \
echo openaps installed && \
openaps --version


