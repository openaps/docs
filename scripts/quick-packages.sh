#!/bin/bash
# Running under WSL (Windows Subsystem for Linux)?
if cat /proc/version | grep Microsoft; then
    WSL_running=true
else
    WSL_running=false
fi

# TODO: remove the `-o Acquire::ForceIPv4=true` once Debian's mirrors work reliably over IPv6
apt-get -o Acquire::ForceIPv4=true install -y sudo
sudo apt-get -o Acquire::ForceIPv4=true update && sudo apt-get -o Acquire::ForceIPv4=true -y upgrade
if [[ $WSL_running == true ]]; then
        #Run just nodejs
        echo "Running on WSL..."
        sudo apt-get -o Acquire::ForceIPv4=true install -y git python python-dev software-properties-common python-numpy python-pip nodejs npm watchdog strace tcpdump screen acpid vim locate jq lm-sensors bc && \
        sudo pip install -U openaps && \
        sudo pip install -U openaps-contrib && \
        sudo openaps-install-udev-rules && \
        sudo activate-global-python-argcomplete && \
        sudo npm install -g json oref0 && \
        echo openaps installed && \
        openaps --version
else
        #Run just node-legacy
        echo "Not running on WSL..."
        sudo apt-get -o Acquire::ForceIPv4=true install -y git python python-dev software-properties-common python-numpy python-pip node-legacy npm watchdog strace tcpdump screen acpid vim locate jq lm-sensors bc && \
        sudo pip install -U openaps && \
        sudo pip install -U openaps-contrib && \
        sudo openaps-install-udev-rules && \
        sudo activate-global-python-argcomplete && \
        sudo npm install -g json oref0 && \
        echo openaps installed && \
        openaps --version
fi
