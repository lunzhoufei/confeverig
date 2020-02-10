#!/usr/bin/env bash


source $LIB/colorecho.sh
green "Start handling dropbox"

# all commands below are from guidance of dropbox homepage.
# references:https://www.dropbox.com/install?os=lnx
# while true
# do
# 	read -p "DO YOU WANT TO INSTALL Dropbox? [Yes]or[No]?" RESP
# 	case $RESP in
# 	Y|y|yes|Yes|YES)
# 		(cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -) &&
# 		echo 'Dropbox download COMPLETED!'
# 		yellow 'run ~/.dropbox-dist/dropboxd'
# 		break
# 		;;
# 	N|n|no|No|NO)
# 		break
# 		;;
# 	*)
# 		echo ' INPUT ERROR! PLEASE INPUT AGAIN!'
# 		continue
# 		;;
# 	esac
# done

red "Handling dropbox finished!"
