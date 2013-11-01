## Simple bash script to install the necessary software packages to
## enable printing capabilities. CUPs service is then enabled and
## started.
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
echo "$(tput sgr 0 1)$(tput setaf 2)$(tput bold)Install and Enable Full Printing Capabilities"
echo
echo "$(tput sgr0)This will install all the necessary software to enable printing"
echo "capabilities. You will then be able to connect and set-up your printer" 
echo "straight away."
echo 
echo "Note that this process may be interrupted by an essential system upgrade. If"
echo "this happens, perform the upgrade and then run this process again."
echo 
echo "Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to proceed. You may still cancel the process when prompted."
read pause

  pacman -Syy manjaro-printer && systemctl enable cups.service -f && systemctl start cups.service
  echo
  echo "Process Complete. Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to continue"
  read pause
  echo


exit 0
