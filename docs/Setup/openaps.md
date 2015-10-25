# Setting Up openaps
This section provides information on installing the base openaps toolkit and its dependencies.

## Install Python and Node.js Packages System-Wide

Run

`sudo apt-get install python python-dev python-setuptools python-software-properties python-numpy python-pip nodejs-legacy npm`

This installs a number of packages required by openaps.

<br>
## Install openaps

Run

`sudo easy_install -ZU setuptools openaps`

Running this command will also update openaps on your system if a newer version is available.

<br>
## Install udev-rules

Run

`sudo openaps-install-udev-rules`


<br>
## Enable Tab Completion

Run

`sudo activate-global-python-argcomplete`

<br>
## Set up Git

Run

`sudo apt-get install git`

In order to set your git account's default identity, you will need to run the following two commands:

`git config --global user.email "you@example.com"`

`git config --global user.name "Your Name"`

replace `you@example.com` and `Your Name` with your own information, but keep the quotes.

