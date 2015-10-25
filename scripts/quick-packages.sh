#!/bin/bash

sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y git python python-dev python-setuptools python-software-properties python-numpy python-pip nodejs-legacy npm && \
sudo easy_install -ZU setuptools && \
sudo easy_install -ZU openaps && \
sudo openaps-install-udev-rules && \
sudo activate-global-python-argcomplete && \
sudo npm install -g oref0 && \
echo openaps installed
openaps --version


