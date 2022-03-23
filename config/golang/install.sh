#!/usr/bin/env bash

echo "Start handling golang =================================================>"

echo "ref: https://go.dev/doc/install"
echo "     https://go.dev/dl/"


# Global variables
# platform_kernel=$(uname | tr '[:upper:]' '[:lower:]')
CONFEVERIG_DIR_TMP="$HOME/.confeverig/tmp"


# Local variables
go_version="1.17.8"
go_install_location="/usr/local/go"

golang_config_snippet=$( cat << EOF
#################### golang related  #####################
export GO111MODULE=on
export GOROOT=$go_install_location
export GOPATH=\$HOME/gopath
export GOBIN=\$HOME/gopath/bin
export PATH=\$PATH:\$GOPATH/bin:\$GOBIN:\$GOROOT/bin
export GOSUMDB="off"
export GOPROXY=https://goproxy.io,direct
# export GOPROXY=https://goproxy.cn
EOF
)

# infer platform
function determine_file_name() {
    local kernel
    local machine
    kernel="$(uname -s)"
    machine="$(uname -m)"
    case $kernel in
        Linux)
            case $machine in
                i686)
                    echo "go${go_version}.linux-386.tar.gz"
                    ;;
                x86_64)
                    echo "go${go_version}.linux-amd64.tar.gz"
                    ;;
                armv6l)
                    echo "go${go_version}.linux-armv61.tar.gz"
                    ;;                                  
                armv7l)                            
                    # no match
                    echo "go${go_version}.linux-arm64.tar.gz"
                    ;;                                     
                armv8l)                     
                    # no match
                    echo "go${go_version}.linux-arm64.tar.gz"
                    ;;                      
                aarch64)                    
                    echo "go${go_version}.linux-arm64.tar.gz"
                    ;;                                     
                *)                                           
                    echo "go${go_version}.linux-arm64.tar.gz"
                    ;;                      
            esac                                         
            ;;                                           
        Darwin)                                        
            case $machine in                             
                x86_64)                                      
                    echo "go${go_version}.darwin-amd64.pkg"
                    ;;                                     
                arm64)       
                    if [[ "$sdkman_rosetta2_compatible" == 'true' ]]; then
                        echo "go${go_version}.darwin-amd64.pkg"
                    else                                   
                        echo "go${go_version}.darwin-arm64.pkg"
                    fi                      
                    ;;                                     
                *)                          
                    echo "go${go_version}.darwin-amd64.pkg"
                    ;;                                     
            esac                            
            ;;              
        *)                                             
            echo ""
    esac                                    
}                                                      

go_file_name="$(determine_file_name)"
go_dl_url="https://go.dev/dl/${go_file_name}"
go_pkg_file="${CONFEVERIG_DIR_TMP}/$go_file_name"


echo "Download file ${go_file_name} to ${go_pkg_file} ..."
if [ ! -f "$go_pkg_file" ]; then
    mkdir -p "$CONFEVERIG_DIR_TMP" >> /dev/null
    curl --location --progress-bar "$go_dl_url" > "$go_pkg_file"
fi


kernel="$(uname -s)"
machine="$(uname -m)"
case $kernel in
    Linux)
        sudo rm -rf $go_install_location && sudo tar -C /usr/local -xzf $go_pkg_file
        ;;                                           
    Darwin)                                        
        sudo installer -pkg $go_pkg_file -target /usr/local
        ;;              
    *)                                             
        echo "un support kernall = $kernel"
esac                                    
unset kernel
unset machine


touch "$HOME/.bashrc"
touch "$HOME/.zshrc"
echo "Attempt update of login bash profile on OSX..."
if [[ -z $(grep "$go_install_location/bin" "$PATH") ]]; then
    echo -e "\n$golang_config_snippet" >> "$HOME/.bashrc"
    echo -e "\n$golang_config_snippet" >> "$HOME/.zshrc"
fi

[[ -s "$HOME/.zshrc" ]] && source "$HOME/.zshrc"
echo "$(go version)"

echo "=============================================> Handling golang finished!"

