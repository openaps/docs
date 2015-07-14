# Setting up openaps

1.: Install Git

Type in 

`sudo apt-get install git`

and press enter

2.: Installing Python packages, system wide

Type in 

`sudo apt-get install python python-dev python-setuptools python-software-properties python-numpy`

and press enter

3.: Install PyPi and OpenAPS

`sudo apt-get install python python-dev python-setuptools python-software-properties python-numpy && sudo easy_install -ZU openaps`

and press enter

4.: Install udev-rules

Type in 

`sudo openaps-install-udev-rules`

and press enter

5.: Enable tab completion for efficiency.

Type in

`sudo activate-global-python-argcomplete`

and press enter

6.: In the future, in order to update OpenAPS, type in

`sudo easy_install -ZU openaps`

and press enter
