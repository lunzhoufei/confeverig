#!/usr/bin/env bash

# source $LIB/colorecho.sh

echo "Start handling java ===================================================>"


# Global variables


# Local variables
sdkman_java_version="8.0.302-open"
sdkman_gradle_version="6.8"
sdkman_maven_version="3.8.4"


function install_sdkman() {
    if [[ -z $(grep 'sdkman-init.sh' "$HOME/.zshrc") ]]; then
        echo "Start install sdkman!  ref: https://sdkman.io/install"
        curl -s "https://get.sdkman.io" | bash
    fi

    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    echo "$(sdk version)"
}


install_sdkman

sdk install java ${sdkman_java_version}
sdk install gradle ${sdkman_gradle_version}
sdk install maven ${sdkman_maven_version}

echo "JAVA_HOME=$JAVA_HOME"
echo "CLASSPATH=$CLASSPATH"


echo "===============================================> Handling java finished!"
