#!/bin/bash

sudo apt-get install -y git python python-dev python-software-properties python-numpy python-pip nodejs-legacy npm watchdog && \
( curl -s https://bootstrap.pypa.io/ez_setup.py | sudo python ) && \
sudo npm install -g json && \
sudo easy_install -ZU setuptools && \
mkdir src
cd src && \
(
    git clone -b dev git://github.com/bewest/decoding-carelink.git
    (cd decoding-carelink && \
    sudo python setup.py develop
    )
    git clone git://github.com/bewest/dexcom_reader.git
    (cd dexcom_reader && \
    sudo python setup.py develop
    )
    git clone -b dev git://github.com/openaps/openaps.git
    (cd openaps && \
    sudo python setup.py develop
    )
    git clone -b dev git://github.com/openaps/openaps-contrib.git
    (cd openaps-contrib && \
    sudo python setup.py develop
    )
    git clone -b dev git://github.com/openaps/oref0.git
)
test -d src/oref0 && \
cd src/oref0 && \
npm install && \
sudo npm install -g && \
sudo npm link && \
sudo npm link oref0

sudo openaps-install-udev-rules && \
sudo activate-global-python-argcomplete && \
openaps --version
