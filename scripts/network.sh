#!/usr/bin/env bash

alias whouseport="f_whouseport"


f_whouseport()
{
    if [[ "$1" != "" ]];then 
        lsof -i :$1
    fi
}


