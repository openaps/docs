#!/bin/bash

sudo apt-get install -y git python python-dev python-setuptools python-software-properties python-numpy python-pip nodejs-legacy npm watchdog && \
(mkdir src && cd src && \
git clone -b bewest/dev git@github.com:bewest/decoding-carelink.git && \
git clone git@github.com:bewest/dexcom_reader.git && \
git clone git@github.com:openaps/openaps.git && \
git clone git://github.com/openaps/oref0.git && \
(cd decoding-carelink && \
sudo python setup.py develop && \
) && \
(cd dexcom_reader && \
sudo python setup.py develop && \
) && \
(cd openaps && \
sudo python setup.py develop && \
) && \
) && \
test -d src/ && sudo chown -R $USER src/
test -d src/oref0 && (cd src/oref0
npm install && \
sudo npm install -g && \
sudo npm link && \
sudo npm link oref0 && \
) && \
sudo openaps-install-udev-rules && \
sudo activate-global-python-argcomplete && \
echo openaps installed
openaps --version


