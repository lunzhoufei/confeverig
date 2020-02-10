#!/usr/bin/env bash

source $LIB/colorecho.sh
green "Start handling vim"

### Install Vundle vim plugins mgr

mkdir -p ~/.vim/bundle

if [[ ! -d ~/.vim/bundle/vundle ]]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
fi

# Copy plugins snipmate.vim with personal configuration.
# SEE:https://github.com/scrooloose/snipmate-snippets
cp -rf bundle/snipmate.vim ~/.vim/bundle/



### vimrc stuff
if [[ -f ~/.vimrc || -h ~/.vimrc ]]; then
	mv ~/.vimrc ~/.vimrc.old
fi

cp _vimrc ~/.vimrc
# source ~/.vimrc

red "handling vim finished"


