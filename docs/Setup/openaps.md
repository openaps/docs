# Setting Up openaps
This section provides information on installing the base openaps toolkit and its dependencies.

## Easy install of openaps and dependencies

### Using the package manager

This is the recommended way to install:

`curl -s https://github.com/openaps/docs/blob/setuptools-npm/scripts/quick-packages.sh | bash -`

This uses [this script](https://github.com/openaps/docs/blob/setuptools-npm/scripts/quick-packages.sh) to install all the dependencies in one step.

### Installing from source

It's possible to use the package manager to install development branches.  If you are hacking on the code, you'll need a way to develop using versions you control.  Here's a quick way to do that:

`curl -s https://github.com/openaps/docs/blob/setuptools-npm/scripts/quick-src.sh | bash -`

## Manual install
### Install Python and Node.js Packages System-Wide

Run

`sudo apt-get install python python-dev python-setuptools python-software-properties python-numpy python-pip nodejs-legacy npm`

This installs a number of packages required by openaps.

<br>
### Install openaps

Run

`sudo easy_install -ZU setuptools`
`sudo easy_install -ZU openaps`

Running this command will also update openaps on your system if a newer version is available.

<br>
### Install udev-rules

Run

`sudo openaps-install-udev-rules`


<br>
### Enable Tab Completion

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

