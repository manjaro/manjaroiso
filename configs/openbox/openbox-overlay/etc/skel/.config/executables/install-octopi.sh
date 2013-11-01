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
echo "It will also automatically provide notifications on your desktop when"
echo "new updates are available."
echo
echo "Note that this process may be interrupted by an essential system upgrade. If"
echo "this happens, perform the upgrade and then run this process again."
echo
echo "Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to proceed. You may still cancel the process when prompted."
read pause


  pacman -Syy octopi-notifier
  echo
  echo "Process Complete. Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to continue"
  read pause

exit 0
