#!/usr/bin/env bash

source $LIB/colorecho.sh
green "Start handling tmux"

if [[ -f ~/.tmux.conf || -h ~/.tmux.conf ]]; then
	mv ~/.tmux.conf ~/.tmux.conf.old
fi

cp ./_tmux.conf ~/.tmux.conf
    
red "handling tmux finished"
