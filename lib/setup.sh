#!/usr/bin/env bash

source $LIB/os.sh

function setup() {
    if [[ $OS == 'darwin' ]];then
        brew install $1
    elif [[ $OS == 'Linux-Debian' ]];then
        sudo apt-get install $1
    elif [[ $OS == 'Linux-Redhat' ]];then
        sudo yum install $1
    fi
}

