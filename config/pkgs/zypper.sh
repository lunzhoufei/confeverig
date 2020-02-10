#!/usr/bin/env bash


### All packages you want install place here
pkgs='cloc tmux subversion axel xsel zsh vim ctags git gcc-c++ tree python tig curl rubygems'


### For some docker images(like dockerhub redis), with sudo command
### \removed, install sudo first
sudo zypper install $pkgs


### install tmux
