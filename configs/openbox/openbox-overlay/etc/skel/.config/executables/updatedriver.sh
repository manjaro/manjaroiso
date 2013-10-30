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
  echo "You must run this script with root privilages (sudo or gksu commands)."
  echo "press <enter> to close the terminal."
  read pause
  exit
fi

## Check 2: Ensure that there is an active internet connection

if ! [ "`ping -c 1 google.com`" ]; 
then
  echo 
  echo "Connection test failed. You must run this script with an active internet"
  echo "connection. Press <enter> to close this terminal."
  read pause
  exit
fi

# Information about this script for the user

clear

echo
echo "Manjaro Hardware Detection: Graphics Driver Detection and Installation"
echo
echo "Manjaro can automatically detect and install the most appropriate"
echo "graphics driver(s) for your system. There are two choices:"
echo  
echo "1. Open Source (non-proprietary) Drivers"
echo "Includes drivers for Virtual Machines and Intel Chipsets, as well as"
echo "drivers written by the Linux Community."
echo  
echo "2. Proprietary Drivers (Recommended)"
echo "Comprises of drivers written by the hardware manufacturers such as"
echo "NVidia for their graphics cards. These provide the best performance."
echo 
echo "You may run this program to switch between open source and proprietary"
echo "drivers at any time."
echo
echo "Press <enter> to first identify the graphics driver(s) currently installed."
read pause
clear

## Identify what has already been installed

	mhwd -li

## And now the options

echo
echo
echo "1. Detect and Install open Source (non-proprietary) Drivers"
echo  
echo "2. Detect and install Proprietary Drivers."
echo
echo "Enter the number of your choice (1 or 2), or just press <enter> to cancel."
read option
case "$option" in

  "1")
  pacman -Syy
  mhwd -a pci free 0300 -f
  echo
  echo "Process Complete. Press <enter> to continue. Now reboot your system."
  read pause
  echo
  ;;

  "2")
  pacman -Syy
  mhwd -a pci nonfree 0300 -f
  echo
  echo "Process Complete. Press <enter> to continue. Now reboot your system."
  read pause
  echo
  ;;


esac

exit 0
