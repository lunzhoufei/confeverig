#!/usr/bin/env bash

alias ll="ls -lt -1"
alias la="ls -A" # list all but not . and ..
alias lt="ls -lt --time-syte=full-iso " # t: sort by time
alias lss="ls -1" # one item per line
alias lsgrep="f_lsgrep"
alias lsdir="ls -FA |grep '/$'"
alias lsfile="ls -lA |grep '^-'"

alias findname="f_findname"


f_lsgrep()
{
    if [[ "$1" != "" ]];then
        ls -l --time-style=full-iso |grep -i "$1"
    fi
}

f_findname()
{
    if [[ "$1" != "" ]];then
        find ./ -name "$1"
        # F_FOUND="`find ./ -name "$1"`"
        # # # F_FOUND=`find ./ -name "$1"`
        # # echo $F_FOUND
        # # echo ">>>>>>>>>>>>>"
        # for i in $F_FOUND
        # do
        #     # echo "===================="
        #     ls -lt --time-style=full-iso $i |grep "$1"
        # done
        # unset F_FOUND
    fi
}
