#!/bin/bash

# fastestservers.sh - edited version of allservers.sh, originally written by Handy. 
# Following wiki page is basis of this script: 
# http://wiki.manjaro.org/index.php/Allservers.sh_Script:-_Rankmirrors,_Synchronise_Pacman_Database
#____________________________________________________
# 

err() {
    ALL_OFF="\e[1;0m"
    BOLD="\e[1;1m"
    RED="${BOLD}\e[1;31m"
	local mesg=$1; shift
	printf "${RED}==>${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}

msg() {
    ALL_OFF="\e[1;0m"
    BOLD="\e[1;1m"
    GREEN="${BOLD}\e[1;32m"
	local mesg=$1; shift
	printf "${GREEN}==>${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}


if  [[ `whoami` != "root" ]]; 
then
  err "You must run this script with the 'sudo' command."
  exit
fi


# The menu:

clear # Clear the screen.

echo
echo -e "\033[1m                      fastestservers.sh \033[0m"
echo
echo -e "\e[1;32m    Enter option number OR hit <return> to exit. "
echo
echo  "     1 - Update mirrorlist with fastest servers"
echo
echo  "     2 - Update mirrorlist with fastest servers and then upgrade system"
echo 
echo -e "\033[1m  Enter Your Choice: \033[0m"
read option

case "$option" in
# Note variable is quoted.

  "1")
  echo
  msg "Downloading latest mirrorlist"
  wget http://git.manjaro.org/packages-sources/basis/blobs/raw/master/pacman-mirrorlist/mirrorlist -O /etc/pacman.d/allservers >& /dev/null
  msg "Editing allservers file"
  sed -ie s'/# Server/Server/'g /etc/pacman.d/allservers
  msg "Running rankmirrors"
  rankmirrors -n 3 /etc/pacman.d/allservers > /etc/pacman.d/mirrorlist
  msg "Updating your pacman databases"
  echo
  pacman -Syy
  ;;
# Note double semicolon to terminate each option.

  "2")
  echo
  msg "Downloading latest mirrorlist"
  wget http://git.manjaro.org/packages-sources/basis/blobs/raw/master/pacman-mirrorlist/mirrorlist -O /etc/pacman.d/allservers >& /dev/null
  msg "Editing allservers file"
  sed -ie s'/# Server/Server/'g /etc/pacman.d/allservers
  msg "Running rankmirrors"
  rankmirrors -n 3 /etc/pacman.d/allservers > /etc/pacman.d/mirrorlist
  msg "Updating your pacman databases"
  echo
  pacman -Syy
  echo
  msg "Upgrading System:"
  echo
  pacman -Syu
  echo
  msg "System update complete."
  echo
  ;;
# Note double semicolon to terminate each option.

esac

exit 0