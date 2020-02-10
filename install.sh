#!/usr/bin/env bash

###############################################################################
#                                                                             #
#        confeverig 1.00 (c) by Fei Lunzhou 2013                              #
#        https://github.com/Universefei/confeverig                            #
#                                                                             #
#        Created: 2013/09/21                                                  #
#        Last Updated: 2013/10/23                                             #
#                                                                             #
#        confeverig is released under the GPL license.                        #
#        See LICENSE file for details.                                        #
#                                                                             #
###############################################################################


### set global variable
export CONFEVERIG=`pwd`
export LIB="${CONFEVERIG}/lib"
export CONF="${CONFEVERIG}/config"
export SCRIPT="${CONFEVERIG}/scripts"


### load library
for conf_file in ${LIB}/*
do
	echo "sourcing libs"
    source $conf_file
done
unset conf_file


### install prerequest packages
cd $CONF/pkgs/ && bash $CONF/pkgs/install.sh
cd $CONF/zsh/ && bash $CONF/zsh/install.sh


### install and config environments concurrentlly
source $CONFEVERIG/confeverig.cfg
for task in $tasks
do
    if [[ $task != 'pkgs' && $task != 'zsh' ]]; then
         cd $CONF/$task/ &&  $CONF/$task/install.sh
    fi
done
unset task
cd $CONFEVERIG
# wait # wait for all tasks completed

### Load scripts
cp -rf $CONFEVERIG/scripts $HOME/


### Icon
green "                      __                         _               "
green "                     / _|                       (_)              "
green "   ___  ___   _ __  | |_  ___ __   __ ___  _ __  _   __ _        "
green "  / __|/ _ \ | '_ \ |  _|/ _ \| \ / // _ \| '__|| | / _  |       "
green " | (__| (_) || | | || | |  __/ \ V /|  __/| |   | || (_| |       "
green "  \___|\___/ |_| |_||_|  \___|  \_/  \___||_|   |_| \__, |       "
green "                                                     __/ |       "
green "                                                    |___/        "


### Refresh configuration
sudo chsh -s `which zsh`
/usr/bin/env zsh
source ~/.zshrc

