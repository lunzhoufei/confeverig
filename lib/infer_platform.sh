#!/usr/bin/env bash


# OS specific support (must be 'true' or 'false').
cygwin=false;
darwin=false;
solaris=false;
freebsd=false;
case "$(uname)" in
    CYGWIN*)
        cygwin=true
        ;;
    Darwin*)
        darwin=true
        ;;
    SunOS*)
        solaris=true
        ;;
    FreeBSD*)
        freebsd=true
esac


# infer platform
function infer_platform() {
    local kernel
    local machine
    kernel="$(uname -s)"
    machine="$(uname -m)"
    case $kernel in
        Linux)
            case $machine in
                i686)
                    echo "LinuxX32"
                    ;;
                x86_64)
                    echo "LinuxX64"
                    ;;
                armv6l)
                    echo "LinuxARM32HF"
                    ;;                                  
                armv7l)                            
                    echo "LinuxARM32HF"
                    ;;                                     
                armv8l)                     
                    echo "LinuxARM32HF"
                    ;;                      
                aarch64)                    
                    echo "LinuxARM64"
                    ;;                                     
                *)                                           
                    echo "LinuxX64" 
                    ;;                      
            esac                                         
            ;;                                           
        Darwin)                                        
            case $machine in                             
                x86_64)                                      
                    echo "DarwinX64"
                    ;;                                     
                arm64)       
                    if [[ "$sdkman_rosetta2_compatible" == 'true' ]]; then
                        echo "DarwinX64"    
                    else                                   
                        echo "DarwinARM64"  
                    fi                      
                    ;;                                     
                *)                          
                    echo "DarwinX64"                       
                    ;;                                     
            esac                            
            ;;              
        *)                                             
            echo "$kernel"
    esac                                    
}                                                      


