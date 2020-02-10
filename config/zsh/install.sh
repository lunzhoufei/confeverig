#!/usr/bin/env bash

# export LIB="../../lib"
source $LIB/setup.sh
source $LIB/colorecho.sh
green "Start handling zsh"


# check if installed zsh 
which zsh &> /dev/null
if [[ $? != 0 ]];then
    setup zsh
fi

if [[ -f ~/.zshrc || -h ~/.zshrc ]]; then
    mv ~/.zshrc ~/.zshrc.old
fi
cp _zshrc ~/.zshrc


###  Install oh-my-zsh
ls -a ~ | grep ".oh-my-zsh" &> /dev/null || {
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
}

[[ ! -d ~/.confeverig ]] && mkdir -p ~/.confeverig/bak
cp zshrc.from.ohmyzsh ~/.zshrc.from.ohmyzsh
echo 'export PATH=$PATH' >> ~/.zshrc

###  Change default shell to zsh
# chsh -s `which zsh` 

red "handling zsh finished"
