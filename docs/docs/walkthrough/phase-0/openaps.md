# Setting Up OpenAPS and Dependencies

This section provides information on installing the base OpenAPS toolkit and its dependencies.

## Easy install of OpenAPS and dependencies

### Using the package manager

This is the recommended way to install:

`curl -s https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-packages.sh | bash -`

This uses [this script](https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-packages.sh) to install all the dependencies in one step.

If the install was successful, the last line will say something like:<br>

openaps 0.0.9  (although the version number may have been incremented)

If you do not see this or see error messages, try running the script multiple times.

### Installing from source

It's possible to use the package manager to install development branches.  If you are hacking on the code, you'll need a way to develop using versions you control.  Here's a quick way to do that:

`curl -s https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-src.sh | bash -`

If successful, the last line will say something like: <br>

openaps 0.0.10-dev  (although the version number may have been incremented)

## Manual install [optional]
### Install Python and Node.js Packages System-Wide [optional]

Run

`sudo apt-get install python python-dev python-setuptools python-software-properties python-numpy python-pip nodejs-legacy npm`

This installs a number of packages required by openaps.

<br>
### Install openaps [optional]

Run

`sudo easy_install -ZU setuptools`

`sudo easy_install -ZU openaps`

Running this command will also update openaps on your system if a newer version is available.

<br>
### Install udev-rules [optional]

Run

`sudo openaps-install-udev-rules`


<br>
### Enable Tab Completion [optional]

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
