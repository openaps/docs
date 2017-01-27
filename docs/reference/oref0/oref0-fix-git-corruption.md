# `oref0-fix-git-corruption`

## Help
Sometimes openaps instances get corrupted and only produce error
messages.

Looking at recent usage in git's ref-log allows us to guess at the last known
commit.  This script attempts to remove all the broken objects after the last
known commit.

This should allow recovering a corrupted openaps instance.