#!/usr/bin/env bash

# LIB="../../lib"
source $LIB/os.sh
source $LIB/colorecho.sh
green "Start handling nodejs"


### install and config nvm
if [[ $OS == 'darwin' ]];then
    brew install nvm && 
    cp `brew --prefix nvm`/nvm-exec ~/.nvm

    echo -e '
###  nodejs configuration
export NVM_DIR=~/.nvm
source `brew --prefix nvm`/nvm.sh
   ' >> ~/.zshrc
elif [[ $OS == 'Linux-Debian' ]];then
    sudo apt-get install build-essential libssl-dev curl git-core
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | zsh
    echo -e '
###  nodejs configuration
export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm 
' >> ~/.zshrc
elif [[ $OS == 'Linux-Redhat' ]];then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | zsh
    echo -e '
###  nodejs configuration
export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm 
' >> ~/.zshrc
fi


### set npm source
cp _npmrc ~/.npmrc


### install node.js
source ~/.nvm/nvm.sh
nvm install `cat version`


### install common npm pacakges
# bash npm.sh & # will take a long time, so execute background

red "handling nodejs finished"
