#!/usr/bin/env bash

pkgs="express mongoose"

source ~/.nvm/nvm.sh
nvm use `cat version` && npm install -g $pkgs

