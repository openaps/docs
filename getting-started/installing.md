
# Installing openaps
## Dependencies

On ubuntu, and apt based systems:

    sudo apt-get install python python-setuptools

## From pypi:

    sudo easy_install -Z openaps

## From git/source

### Getting the source code:

    # mkdir -p ~/src/ && cd ~/src/
    # get the source code
    git clone https://github.com/openaps/openaps.git
    cd openaps
    sudo python setup.py install

### Upgrade an existing install from source

Getting the source code:

    # mkdir -p ~/src/ && cd ~/src/openaps
    # get the source code
    git pull origin
    # install
    sudo python setup.py develop

