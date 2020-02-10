#!/usr/bin/env bash

source $LIB/colorecho.sh
green "Start handling git"


source $LIB/setup.sh

which git &> /dev/null
if [[ $? != 0 ]];then
    setup git
fi

bash ./git.sh

red "Handling git finished!"
