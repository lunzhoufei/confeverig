#!/usr/bin/env bash


### All packages you want install place here
pkgs='cloc subversion axel xsel zsh vim ctags git gcc-c++ tree python tig curl rubygems'


### For some docker images(like dockerhub redis), with sudo command
### \removed, install sudo first
which sudo &> /dev/null
if [[ $? != 0 ]]; then
    yum update
    yum install sudo
fi

sudo yum install $pkgs


### install tmux
wget http://downloads.sourceforge.net/tmux/tmux-1.9a.tar.gz -O tmux.tar.gz && \
    tar -zxvf tmux.tar.gz   && \
    cd tmux-1.9a && ./configure && make && sudo make install && rm ../tmux-1.9a.tar.gz .
