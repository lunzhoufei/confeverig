#!/usr/bin/env bash


###  Detect environment. 
source $LIB/os.sh
source $LIB/colorecho.sh
green "Start handling Language"

echo 'export LC_ALL="en_US.UTF-8"' >> ~/.zshrc

### Install packages.
echo `pwd`
if [[ $OS == 'darwin' ]];then
    echo "do nothing" &> /dev/null
elif [[ $OS == 'Linux-Debian' ]];then
    bash debian.sh
elif [[ $OS == 'Linux-Redhat' ]];then
    echo "do nothing" &> /dev/null
fi

red "handling Language finished"
