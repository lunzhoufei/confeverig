#!/usr/bin/env bash

source $LIB/colorecho.sh
green "Start handling python"


### Install pip
bash pip.sh

sudo pip install virtualenv



# infer platform
function install_pip() {
    local kernel
    local machine
    kernel="$(uname -s)"
    machine="$(uname -m)"
    case $kernel in
        Linux)
            echo $UNAME | grep -E "Ubuntu|Debian|ubuntu|debian" &> /dev/null
            if [[ $? == 0 ]]; then 
                sudo apt-get install python3-pip
            fi
            echo "linux version not support"
            ;;                                           
        Darwin)                                        
            brew install python3-pip
            ;;              
        *)                                             
            echo "$kernel"
    esac                                    
}                                                      

function install_venv() {
    pip3 install virtualenv
}                                                      


install_pip
install_venv


red "handling python finished"
