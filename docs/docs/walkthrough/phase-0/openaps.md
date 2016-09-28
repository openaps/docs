# Setting Up openaps and Dependencies

This section provides information on installing the base openaps toolkit and its dependencies.

## Easy install of openaps and dependencies

### Using the package manager

This is the recommended way to install:

`curl -s https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-packages.sh | bash -`

This uses [this script](https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-packages.sh) to install all the dependencies in one step.

If the install was successful, the last line will say something like:<br>

openaps 0.0.15  (although the version number may have been incremented)

If you do not see this or see error messages, try running the script multiple times.

### Installing from source

It's possible to use the package manager to install development branches.  If you are hacking on the code, you'll need a way to develop using versions you control.  Here's a quick way to do that:

`curl -s https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-src.sh | bash -`

If successful, the last line will say something like: <br>

openaps 0.0.15-dev  (although the version number may have been incremented)

