#!/usr/bin/env bash

###  Detect environment. 
source $LIB/os.sh
source $LIB/colorecho.sh
green "Start handling docker"

### Install packages.

if [[ $OS == 'darwin' ]];then
    . osx.sh
elif [[ $OS == 'Linux-Debian' ]];then
    . ubuntu.sh
fi


red "Handling docker finished!"
