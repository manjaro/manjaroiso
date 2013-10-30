## Simple bash script to install the necessary software packages to
## access the AUR.
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
echo "Install full Arch User Repository (AUR) support"
echo
echo "The AUR is a community-maintained repository that may contain extra software" 
echo "packages not otherwise available from the official Manjaro repositories."
echo  
echo "Manjaro is not responsible for AUR packages. Our user guide and wiki" 
echo "provides instructions on how to access the AUR once these packages are" 
echo "installed."
echo
echo "Note that this process may be interrupted by an essential system upgrade. If"
echo "this happens, perform the upgrade and then run this process again."
echo
echo "Press <enter> to proceed. You may still cancel the process when prompted."
read pause


  pacman -Syy autoconf automake binutils bison fakeroot flex gcc libtool m4 make patch yaourt
  echo
  echo "Process Complete. Press <enter> to continue"
  read pause

exit 0
