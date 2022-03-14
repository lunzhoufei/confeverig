#!/bin/bash
#
#   Copyright 2017 Marco Vermeulen
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#



# install:- channel: stable; version: 5.14.0; api: https://api.confeverig.io/2


# Global variables
CONFEVERIG_SERVICE="https://api.confeverig.io/2"
CONFEVERIG_VERSION="5.14.0"
CONFEVERIG_PLATFORM=$(uname)

if [ -z "$CONFEVERIG_DIR" ]; then
    CONFEVERIG_DIR="$HOME/.confeverig"
    CONFEVERIG_DIR_RAW='$HOME/.confeverig'
else
    CONFEVERIG_DIR_RAW="$CONFEVERIG_DIR"
fi

# Local variables
confeverig_tmp_folder="${CONFEVERIG_DIR}/tmp"
confeverig_zip_file="${confeverig_tmp_folder}/confeverig-${CONFEVERIG_VERSION}.zip"
confeverig_zip_base_folder="${confeverig_tmp_folder}/confeverig-${CONFEVERIG_VERSION}"
confeverig_ext_folder="${CONFEVERIG_DIR}/ext"
confeverig_etc_folder="${CONFEVERIG_DIR}/etc"
confeverig_var_folder="${CONFEVERIG_DIR}/var"
confeverig_archives_folder="${CONFEVERIG_DIR}/archives"
confeverig_candidates_folder="${CONFEVERIG_DIR}/candidates"
confeverig_config_file="${confeverig_etc_folder}/config"
confeverig_bash_profile="${HOME}/.bash_profile"
confeverig_profile="${HOME}/.profile"
confeverig_bashrc="${HOME}/.bashrc"
confeverig_zshrc="${ZDOTDIR:-${HOME}}/.zshrc"

confeverig_init_snippet=$( cat << EOF
#THIS MUST BE AT THE END OF THE FILE FOR CONFEVERIG TO WORK!!!
export CONFEVERIG_DIR="$CONFEVERIG_DIR_RAW"
[[ -s "${CONFEVERIG_DIR_RAW}/bin/confeverig-init.sh" ]] && source "${CONFEVERIG_DIR_RAW}/bin/confeverig-init.sh"
EOF
)

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

echo ''
echo '                                -+syyyyyyys:'
echo '                            `/yho:`       -yd.'
echo '                         `/yh/`             +m.'
echo '                       .oho.                 hy                          .`'
echo '                     .sh/`                   :N`                `-/o`  `+dyyo:.'
echo '                   .yh:`                     `M-          `-/osysoym  :hs` `-+sys:      hhyssssssssy+'
echo '                 .sh:`                       `N:          ms/-``  yy.yh-      -hy.    `.N-````````+N.'
echo '               `od/`                         `N-       -/oM-      ddd+`     `sd:     hNNm        -N:'
echo '              :do`                           .M.       dMMM-     `ms.      /d+`     `NMMs       `do'
echo '            .yy-                             :N`    ```mMMM.      -      -hy.       /MMM:       yh'
echo '          `+d+`           `:/oo/`       `-/osyh/ossssssdNMM`           .sh:         yMMN`      /m.'
echo '         -dh-           :ymNMMMMy  `-/shmNm-`:N/-.``   `.sN            /N-         `NMMy      .m/'
echo '       `oNs`          -hysosmMMMMydmNmds+-.:ohm           :             sd`        :MMM/      yy'
echo '      .hN+           /d:    -MMMmhs/-.`   .MMMh   .ss+-                 `yy`       sMMN`     :N.'
echo '     :mN/           `N/     `o/-`         :MMMo   +MMMN-         .`      `ds       mMMh      do'
echo '    /NN/            `N+....--:/+oooosooo+:sMMM:   hMMMM:        `my       .m+     -MMM+     :N.'
echo '   /NMo              -+ooooo+/:-....`...:+hNMN.  `NMMMd`        .MM/       -m:    oMMN.     hs'
echo '  -NMd`                                    :mm   -MMMm- .s/     -MMm.       /m-   mMMd     -N.'
echo ' `mMM/                                      .-   /MMh. -dMo     -MMMy        od. .MMMs..---yh'
echo ' +MMM.                                           sNo`.sNMM+     :MMMM/        sh`+MMMNmNm+++-'
echo ' mMMM-                                           /--ohmMMM+     :MMMMm.       `hyymmmdddo'
echo ' MMMMh.                  ````                  `-+yy/`yMMM/     :MMMMMy       -sm:.``..-:-.`'
echo ' dMMMMmo-.``````..-:/osyhddddho.           `+shdh+.   hMMM:     :MmMMMM/   ./yy/` `:sys+/+sh/'
echo ' .dMMMMMMmdddddmmNMMMNNNNNMMMMMs           sNdo-      dMMM-  `-/yd/MMMMm-:sy+.   :hs-      /N`'
echo '  `/ymNNNNNNNmmdys+/::----/dMMm:          +m-         mMMM+ohmo/.` sMMMMdo-    .om:       `sh'
echo '     `.-----+/.`       `.-+hh/`         `od.          NMMNmds/     `mmy:`     +mMy      `:yy.'
echo '           /moyso+//+ossso:.           .yy`          `dy+:`         ..       :MMMN+---/oys:'
echo '         /+m:  `.-:::-`               /d+                                    +MMMMMMMNh:`'
echo '        +MN/                        -yh.                                     `+hddhy+.'
echo '       /MM+                       .sh:'
echo '      :NMo                      -sh/'
echo '     -NMs                    `/yy:'
echo '    .NMy                  `:sh+.'
echo '   `mMm`               ./yds-'
echo '  `dMMMmyo:-.````.-:oymNy:`'
echo '  +NMMMMMMMMMMMMMMMMms:`'
echo '    -+shmNMMMNmdy+:`'
echo ''
echo ''
echo '                                                                 Now attempting installation...'
echo ''
echo ''

# Sanity checks

echo "Looking for a previous installation of CONFEVERIG..."
if [ -d "$CONFEVERIG_DIR" ]; then
	echo "CONFEVERIG found."
	echo ""
	echo "======================================================================================================"
	echo " You already have CONFEVERIG installed."
	echo " CONFEVERIG was found at:"
	echo ""
	echo "    ${CONFEVERIG_DIR}"
	echo ""
	echo " Please consider running the following if you need to upgrade."
	echo ""
	echo "    $ sdk selfupdate force"
	echo ""
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for unzip..."
if ! command -v unzip > /dev/null; then
	echo "Not found."
	echo "======================================================================================================"
	echo " Please install unzip on your system using your favourite package manager."
	echo ""
	echo " Restart after installing unzip."
	echo "======================================================================================================"
	echo ""
	exit 1
fi

echo "Looking for zip..."
if ! command -v zip > /dev/null; then
	echo "Not found."
	echo "======================================================================================================"
	echo " Please install zip on your system using your favourite package manager."
	echo ""
	echo " Restart after installing zip."
	echo "======================================================================================================"
	echo ""
	exit 1
fi

echo "Looking for curl..."
if ! command -v curl > /dev/null; then
	echo "Not found."
	echo ""
	echo "======================================================================================================"
	echo " Please install curl on your system using your favourite package manager."
	echo ""
	echo " Restart after installing curl."
	echo "======================================================================================================"
	echo ""
	exit 1
fi

if [[ "$solaris" == true ]]; then
	echo "Looking for gsed..."
	if [ -z $(which gsed) ]; then
		echo "Not found."
		echo ""
		echo "======================================================================================================"
		echo " Please install gsed on your solaris system."
		echo ""
		echo " CONFEVERIG uses gsed extensively."
		echo ""
		echo " Restart after installing gsed."
		echo "======================================================================================================"
		echo ""
		exit 1
	fi
else
	echo "Looking for sed..."
	if [ -z $(command -v sed) ]; then
		echo "Not found."
		echo ""
		echo "======================================================================================================"
		echo " Please install sed on your system using your favourite package manager."
		echo ""
		echo " Restart after installing sed."
		echo "======================================================================================================"
		echo ""
		exit 1
	fi
fi

echo "Installing CONFEVERIG scripts..."


# Create directory structure

echo "Create distribution directories..."
mkdir -p "$confeverig_tmp_folder"
mkdir -p "$confeverig_ext_folder"
mkdir -p "$confeverig_etc_folder"
mkdir -p "$confeverig_var_folder"
mkdir -p "$confeverig_archives_folder"
mkdir -p "$confeverig_candidates_folder"

echo "Getting available candidates..."
CONFEVERIG_CANDIDATES_CSV=$(curl -s "${CONFEVERIG_SERVICE}/candidates/all")
echo "$CONFEVERIG_CANDIDATES_CSV" > "${CONFEVERIG_DIR}/var/candidates"

echo "Prime the config file..."
touch "$confeverig_config_file"
echo "confeverig_auto_answer=false" >> "$confeverig_config_file"
if [ -z "$ZSH_VERSION" -a -z "$BASH_VERSION" ]; then
    echo "confeverig_auto_complete=false" >> "$confeverig_config_file"
else
    echo "confeverig_auto_complete=true" >> "$confeverig_config_file"
fi
echo "confeverig_auto_env=false" >> "$confeverig_config_file"
echo "confeverig_auto_update=true" >> "$confeverig_config_file"
echo "confeverig_beta_channel=false" >> "$confeverig_config_file"
echo "confeverig_checksum_enable=true" >> "$confeverig_config_file"
echo "confeverig_colour_enable=true" >> "$confeverig_config_file"
echo "confeverig_curl_connect_timeout=7" >> "$confeverig_config_file"
echo "confeverig_curl_max_time=10" >> "$confeverig_config_file"
echo "confeverig_debug_mode=false" >> "$confeverig_config_file"
echo "confeverig_insecure_ssl=false" >> "$confeverig_config_file"
echo "confeverig_rosetta2_compatible=false" >> "$confeverig_config_file"
echo "confeverig_selfupdate_feature=true" >> "$confeverig_config_file"

echo "Download script archive..."
curl --location --progress-bar "${CONFEVERIG_SERVICE}/broker/download/confeverig/install/${CONFEVERIG_VERSION}/${CONFEVERIG_PLATFORM}" > "$confeverig_zip_file"

ARCHIVE_OK=$(unzip -qt "$confeverig_zip_file" | grep 'No errors detected in compressed data')
if [[ -z "$ARCHIVE_OK" ]]; then
	echo "Downloaded zip archive corrupt. Are you connected to the internet?"
	echo ""
	echo "If problems persist, please ask for help on our Slack:"
	echo "* easy sign up: https://slack.confeverig.io/"
	echo "* report on channel: https://confeverig.slack.com/app_redirect?channel=user-issues"
	rm -rf "$CONFEVERIG_DIR"
	exit 1
fi

echo "Extract script archive..."
if [[ "$cygwin" == 'true' ]]; then
	echo "Cygwin detected - normalizing paths for unzip..."
	confeverig_tmp_folder=$(cygpath -w "$confeverig_tmp_folder")
	confeverig_zip_file=$(cygpath -w "$confeverig_zip_file")
	confeverig_zip_base_folder=$(cygpath -w "$confeverig_zip_base_folder")
fi
unzip -qo "$confeverig_zip_file" -d "$confeverig_tmp_folder"

echo "Install scripts..."
mv "${confeverig_zip_base_folder}/"* "$CONFEVERIG_DIR"
rm -rf "$confeverig_zip_base_folder"

echo "Set version to $CONFEVERIG_VERSION ..."
echo "$CONFEVERIG_VERSION" > "${CONFEVERIG_DIR}/var/version"


if [[ $darwin == true ]]; then
  touch "$confeverig_bash_profile"
  echo "Attempt update of login bash profile on OSX..."
  if [[ -z $(grep 'confeverig-init.sh' "$confeverig_bash_profile") ]]; then
    echo -e "\n$confeverig_init_snippet" >> "$confeverig_bash_profile"
    echo "Added confeverig init snippet to $confeverig_bash_profile"
  fi
else
  echo "Attempt update of interactive bash profile on regular UNIX..."
  touch "${confeverig_bashrc}"
  if [[ -z $(grep 'confeverig-init.sh' "$confeverig_bashrc") ]]; then
      echo -e "\n$confeverig_init_snippet" >> "$confeverig_bashrc"
      echo "Added confeverig init snippet to $confeverig_bashrc"
  fi
fi

echo "Attempt update of zsh profile..."
touch "$confeverig_zshrc"
if [[ -z $(grep 'confeverig-init.sh' "$confeverig_zshrc") ]]; then
    echo -e "\n$confeverig_init_snippet" >> "$confeverig_zshrc"
    echo "Updated existing ${confeverig_zshrc}"
fi



echo -e "\n\n\nAll done!\n\n"

echo "You are subscribed to the STABLE channel."

echo ""
echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo "    source \"${CONFEVERIG_DIR}/bin/confeverig-init.sh\""
echo ""
echo "Then issue the following command:"
echo ""
echo "    sdk help"
echo ""
echo "Enjoy!!!"
