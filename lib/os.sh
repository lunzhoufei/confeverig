#!/usr/bin/env bash


###  Detect environment. 
function detect_os() {
    UNAME=`uname -a`

    echo $UNAME | grep -E "Darwin|darwin" &> /dev/null
    if [[ $? == 0 ]]; then 
        RET='darwin'
    fi

    echo $UNAME | grep -E "Ubuntu|Debian|ubuntu|debian" &> /dev/null
    if [[ $? == 0 ]]; then 
        RET='Linux-Debian'
    fi

    echo $UNAME | grep -E "Fedora|CentOS|fedora|centos" &> /dev/null
    if [[ $? == 0 ]]; then 
        RET='Linux-Redhat'
    fi
    
    LSB_F=`lsb_release -a `
    echo $LSB_F | grep -i -E "opensuse" &> /dev/null
    if [[ $? == 0 ]]; then 
        RET='opensuse'
    fi
    unset UNAME
    unset LSB_F
        
}

detect_os
OS=$RET
unset RET

# echo $OS
