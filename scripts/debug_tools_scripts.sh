#!/usr/bin/env bash

alias pidlog="f_pidlog"
alias pidcall="strace -p "

f_pidlog()
{
    if [[ "$1" != "" ]];then
        lsof -p $1 |grep -i -E "log|ini|cfg|cnf|conf|config"
    fi
}


