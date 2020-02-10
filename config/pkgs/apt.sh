#!/usr/bin/env bash


### All packages you want to install place here
pkgs='
cloc subversion axel xsel zsh tmux vim ctags git g++ tree python tig curl
valgrind cgdb python-setuptools
'

### For some docker images(like dockerhub redis), no sudo utility provided
### \install sudo first.
which sudo &> /dev/null
if [[ $? != 0 ]]; then
    apt-get update
    apt-get install sudo
fi


sudo apt-get install $pkgs


### Backup and replace sources.list with 163's mirror
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp sources.list.bionic /etc/apt/sources.list
sudo apt-get update


