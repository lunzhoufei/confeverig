#!/usr/bin/env bash

source $LIB/colorecho.sh
green "Start handling python"


### Install pip
bash pip.sh

sudo pip install virtualenv


red "handling python finished"
