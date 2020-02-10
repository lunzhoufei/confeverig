#!/usr/bin/env bash

# pip_pkgs=" docopt pygments "
pip_pkgs=" simplehttpd "

which pip &> /dev/null
if [[ $? != 0 ]]; then
    sudo easy_install pip
fi
sudo pip install $pip_pkgs


### python related project here:

# sudo pip install docopt pygments
# git clone https://github.com/chrisallenlane/cheat.git ~/cheat
# cd ~/cheat && python setup.py install
