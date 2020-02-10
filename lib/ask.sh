#!/usr/bin/env bash

LOG="ask.log"

function ask() {
    while true
    do
        read -p "$1" RESP
        case $RESP in
        Y|y|yes|Yes|YES)
            echo "$2" >> $LOG
            break
            ;;
        N|n|no|No|NO)
            break
            ;;
        *)
            continue
            ;;
        esac
    done
}

function specify() {
    read -p "$1" RESP
    RET=$RESP
}
