
# Installing openaps

The recommended way to install openaps is to use python's package management system.
The [openaps] project is distributed on [pypi][openaps on pypi].
On Debian/Ubuntu and other apt based systems, the following apt-get dependencies are required:

    sudo apt-get install python python-dev python-pip python-software-properties python-numpy
    sudo pip install setuptools

You can also install openaps on Mac OS X if you install the dependencies with homebrew or similar.

If you don't have a Debian/Ubuntu based system yet, and don't know what homebrew is, don't despair.  You'll just want to skip over to [Phase 0 of the OpenAPS Walkthrough](../walkthrough/index) to get your Raspberry Pi set up first, and then come back to this guide before moving on to Phase 1.

[openaps]: https://github.com/openaps/openaps
[openaps on pypi]: https://pypi.python.org/pypi/openaps

#### From pypi

To [install from pypi](https://pypi.python.org/pypi/openaps):

    sudo easy_install -Z openaps

This installs `openaps` system wide.

##### Updating
To update `openaps`, append the `-U` option:

    sudo easy_install -ZU openaps


#### From source
Sometimes, it's useful to use a development version to help test or debug
features.  Here's how to install the project from source.

    git clone git://github.com/openaps/openaps.git
    cd openaps
    # checkout desired branch (dev)?
    git checkout dev
    sudo python setup.py develop

Do not use `openaps` commands in the the openaps repo.  Only use the
`openaps` directory for hacking on the core library, or for managing
upgrades through git.  Running `openaps` inside of the openaps
source directory will error in the best case, and mess up your
`openaps` install in the worst case.

Now it's time to create our first workspace!

