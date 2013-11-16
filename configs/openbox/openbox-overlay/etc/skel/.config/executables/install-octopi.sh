## Simple bash script to install Octopi, a graphical front-end for 
## pacman.
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
echo "$(tput sgr 0 1)$(tput setaf 2)$(tput bold)Install Octopi, the Graphical Software Manager"
echo
echo "$(tput sgr0)The preferred graphical application to manage software in $(tput setaf 2)Manjaro$(tput setaf 2)Box" 
echo "$(tput sgr0)is $(tput setaf 2)Octopi$(tput sgr0)."
echo  
echo "Octopi allows for easy software searches, installation, and removal at" 
echo "the click of a button, including from the Arch User Repository (AUR)." 
echo "It can also automatically provide notifications on your desktop when"
echo "new updates are available."
echo
echo "$(tput setaf 2)$(tput bold)1. Install Octopi and Octopi Notifier (recommended)"
echo "$(tput sgr0)Install the complete package for automatic notifications of updates."
echo
echo "$(tput setaf 3)$(tput bold)2. Install Octopi Only"
echo "$(tput sgr0)Install the software manager alone without desktop notifications."
echo
echo "Note that this process may be interrupted by an essential system upgrade. If"
echo "this happens, perform the upgrade and then run this process again."
echo
echo "Enter the number of your choice ($(tput setaf 2)$(tput bold)1$(tput sgr0) or $(tput setaf 3)$(tput bold)2$(tput sgr0)), or just press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to cancel."
read option
case "$option" in

  "1")
  pacman -Syy octopi-notifier
  echo
  echo "Process Complete. Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to continue"
  read pause
  echo
  ;;

  "2")
  pacman -Syy octopi
  echo
  echo "Process Complete. Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to continue"
  read pause
  echo
  ;;

esac

exit 0
