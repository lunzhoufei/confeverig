#!/usr/bin/env bash


###  Detect environment. 
source $LIB/os.sh
source $LIB/colorecho.sh
green "Start handling pkgs"


### Install packages.
echo `pwd`
if [[ $OS == 'darwin' ]];then
    bash homebrew.sh
elif [[ $OS == 'Linux-Debian' ]];then
    bash apt.sh
elif [[ $OS == 'Linux-Redhat' ]];then
    bash yum.sh
elif [[ $OS == 'opensuse' ]];then
    bash zypper.sh
fi


red "handling pkgs finished"
