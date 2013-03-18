#!/bin/bash

# allservers.sh - inspired by Manjaro's Carl & Phil, initially hung together 
# by handy, the script's display prettied up & progress information added by Phil, 
# the menu & wiki page added by handy.
# Latest revision now calls everything from a menu.
# Following wiki page is about this script: 
# http://wiki.manjaro.org/index.php/Allservers.sh_Script:-_Rankmirrors,_Synchronise_Pacman_Database
# Following wiki page will introduce CacheClean & related information:
# http://wiki.manjaro.org/index.php/Maintaining_/var/cache/pacman/pkg_for_System_Safety
#____________________________________________________
# 
# allservers.sh is now completely menu driven. The Menu describes
# what it does for you, if you need more detail see the two
# wiki page links listed above.
#####################################################

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
  err "Must use 'sudo su' before you run this script."
  exit
fi


# The menu:

clear # Clear the screen.

echo
echo -e "\033[1m                      allservers.sh \033[0m"
echo
echo -e "\e[1;32m    Enter your Option's number OR hit Return to exit. "
echo
echo
echo  "    [1] Rank Mirrors, Update Mirrorlist & run pacman -Syy "
echo
echo  "    [2] Option 1. plus Upgrade the System - pacman -Syu "
echo  "        & then run CacheClean - cacheclean -v 2 "
echo
echo  "    [3] Option 1. plus Upgrade the System & AUR - yaourt -Syu --aur "
echo  "        & then run CacheClean - cacheclean -v 2 "
echo
echo  "    [4] Upgrade the System only - pacman -Syu "
echo  "        & then run CacheClean - cacheclean -v 2 "
echo
echo  "    [5] Upgrade the System & AUR only - yaourt - Syu --aur "
echo  "        & then run CacheClean - cacheclean -v 2 "
echo
echo  "    CacheClean can be obtained via the AUR - yaourt -S cacheclean "
echo  "    CacheClean is set to remove all installation packages in your "
echo  "    /var/cache/pacman/pkg directory EXCEPT the two most recent "
echo  "    versions. See the Manjaro wiki for details. "
echo -e "    http://wiki.manjaro.org/index.php/Maintaining_/var/cache/pacman/pkg_for_System_Safety \033[0m"
echo 
echo -e "\033[1m  Enter Your Choice: \033[0m"
echo    

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
  msg "CacheClean will now remove all but the 2 most "
  msg "recent versions of the installation packages in "
  msg "/var/cache/pacman/pkg directory:"
  echo
  cacheclean -v 2
  echo
  msg "CacheClean has done its job. "
  echo
  ;;
# Note double semicolon to terminate each option.

  "3")
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
  msg "Upgrading System & AUR:"
  echo
  yaourt -Syu --aur
  echo
  msg "System including AUR packages are up to date."
  echo
  msg "CacheClean will now remove all but the 2 most "
  msg "recent versions of the installation packages in "
  msg "/var/cache/pacman/pkg directory:"
  echo
  cacheclean -v 2
  echo
  msg "CacheClean has done its job. "
  echo
  ;;
# Note double semicolon to terminate each option.

  "4")
  echo
  msg "Upgrading System:"
  echo
  pacman -Syu
  echo
  msg "System update complete."
  echo
  msg "CacheClean will now remove all but the 2 most "
  msg "recent versions of the installation packages in "
  msg "/var/cache/pacman/pkg directory:"
  echo
  cacheclean -v 2
  echo
  msg "CacheClean has done its job. "
  echo
  ;;
# Note double semicolon to terminate each option.

  "5")
  echo
  msg "Upgrading System & AUR: "
  echo
  yaourt -Syu --aur
  echo
  msg "System including AUR packages are up to date. "
  echo
  msg "CacheClean will now remove all but the 2 most "
  msg "recent versions of the installation packages in "
  msg "/var/cache/pacman/pkg directory:"
  echo
  cacheclean -v 2
  echo
  msg "CacheClean has done its job. "
  echo
  ;;
# Note double semicolon to terminate each option.

esac


exit 0