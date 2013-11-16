## Simple bash script to change between stable, testing and unstable repos
##
## Written by Carl Duff
##

clear
echo "Checking root privilages and internet connection...."
echo

## Check 1: Ensure that the script is being run with root privilages

if  [[ `whoami` != "root" ]]; 
then
  echo "This script must be run with root privilages (i.e. the 'sudo' command)."
  echo "press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to close the terminal."
  read pause
  exit
fi

## Check 2: Ensure that there is an active internet connection

if ! [ "`ping -c 1 google.com`" ]; 
then
  echo 
  echo "$(tput setaf 1)$(tput bold)Connection test failed$(tput sgr0). You must run this script with an active internet"
  echo "connection. Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to close this terminal."
  read pause
  exit
fi

# Information about this script for the user

clear

echo
echo "$(tput sgr 0 1)$(tput setaf 2)$(tput bold)Change Manjaro Repos"
echo
echo "$(tput sgr0)Manjaro uses three types of repository:"
echo  
echo "$(tput setaf 2)$(tput bold)1. Stable (recommended)"
echo "$(tput sgr0)This is the default repository used by Manjaro systems to provide updates and" 
echo "downloads to general users. About two weeks behind Arch."
echo  
echo "$(tput setaf 3)$(tput bold)2. Testing"
echo "$(tput sgr0)This is used to store patched software packages from the unstable"
echo "repositories, and other new software releases deemed at least sufficiently" 
echo "stable. About a week behind Arch, software needs further checks / patching."
echo 
echo "$(tput setaf 1)$(tput bold)3. Unstable"
echo "$(tput sgr0)A day or two behind the Arch repositories, this is also used to store" 
echo "software packages that have known or suspected issues."
echo
echo "Enter the number of your choice ($(tput setaf 2)$(tput bold)1$(tput sgr0), $(tput setaf 3)$(tput bold)2 $(tput sgr0)or $(tput setaf 1)$(tput bold)3$(tput sgr0)), or just press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to cancel."
echo "The fastest mirrors will be automatically chosen. Your system will NOT be"
echo "automatically updated, however. Enter 'sudo pacman -Syu' to do so after"
echo "this process has completed."
read option
case "$option" in

  "1")
  pacman-mirrors -g -b stable && pacman -Syy
  echo
  echo "Process Complete. Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to continue"
  read pause
  echo
  ;;

  "2")
  pacman-mirrors -g -b testing && pacman -Syy
  echo
  echo "Process Complete. Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to continue"
  read pause
  echo
  ;;

  "3")
  pacman-mirrors -g -b unstable && pacman -Syy
  echo
  echo "Process Complete. Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to continue"
  read pause
  echo
  ;;
esac

exit 0
