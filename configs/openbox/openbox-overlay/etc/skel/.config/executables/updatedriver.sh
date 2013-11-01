## Simple bash script to install the necessary software packages to
## enable full multimedia capabilities.
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
echo "$(tput sgr 0 1)$(tput setaf 2)$(tput bold)Manjaro Hardware Detection: Graphics Driver Detection and Installation"
echo
echo "$(tput sgr0)Manjaro can automatically detect and install the most appropriate"
echo "graphics driver(s) for your system. There are two choices:"
echo  
echo "$(tput setaf 4)$(tput bold)1. Open Source (non-proprietary) Drivers"
echo "$(tput sgr0)Includes drivers for Virtual Machines and Intel Chipsets, as well as"
echo "drivers written by the Linux Community."
echo  
echo "$(tput setaf 3)$(tput bold)2. Proprietary Drivers (Recommended)"
echo "$(tput sgr0)Comprises of drivers written by the hardware manufacturers such as"
echo "NVidia for their graphics cards. These provide the best performance."
echo 
echo "You may run this program to switch between open source and proprietary"
echo "drivers at any time."
echo
echo "Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to first identify the graphics driver(s) currently installed."
read pause
clear

## Identify what has already been installed

	mhwd -li

## And now the options

echo
echo
echo "$(tput setaf 4)$(tput bold)1. Detect and Install Open Source (non-proprietary) Drivers"
echo  
echo "$(tput setaf 3)$(tput bold)2. Detect and Install Proprietary Drivers (Recommended)."
echo
echo "$(tput sgr0)Enter the number of your choice ($(tput setaf 4)$(tput bold)1$(tput sgr0) or $(tput setaf 3)$(tput bold)2$(tput sgr0)), or just press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to cancel."
read option
case "$option" in

  "1")
  pacman -Syy
  mhwd -a pci free 0300 -f
  echo
  echo "Process Complete. Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to continue. Now reboot your system."
  read pause
  echo
  ;;

  "2")
  pacman -Syy
  mhwd -a pci nonfree 0300 -f
  echo
  echo "Process Complete. Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to continue. Now reboot your system."
  read pause
  echo
  ;;


esac

exit 0
