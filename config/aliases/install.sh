#!/usr/bin/env bash

source $LIB/colorecho.sh
green "Start handling aliases"

[[ ! -d ~/.confeverig ]] && mkdir -p ~/.confeverig/bak

for wtf in ./enabled/*
do
	filename=$(basename ${wtf})
	if [[ -f ~/.confeverig/${filename} ]]; then
		mv ~/.confeverig/${filename} ~/.confeverig/bak/${filename}.old
	fi	
    cp $wtf ~/.confeverig/
done
unset filename

if [[ $OS == 'darwin' ]];then
    . osx.sh
elif [[ $OS == 'Linux-Debian' ]];then
    . ubuntu.sh
fi

red "Handling aliases finished!"
