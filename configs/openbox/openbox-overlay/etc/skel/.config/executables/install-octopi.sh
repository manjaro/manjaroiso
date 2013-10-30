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
echo "Install Octopi, the Graphical Software Manager"
echo
echo "The preferred graphical application to manage software in ManjaroBang" 
echo "is Octopi."
echo  
echo "Octopi allows for easy software searches, installation, and removal at" 
echo "the click of a button, including from the Arch User Repository (AUR)." 
echo "It will also automatically provide notifications on your desktop when"
echo "new updates are available."
echo
echo "Note that this process may be interrupted by an essential system upgrade. If"
echo "this happens, perform the upgrade and then run this process again."
echo
echo "Press <enter> to proceed. You may still cancel the process when prompted."
read pause


  pacman -Syy octopi-notifier
  echo
  echo "Process Complete. Press <enter> to continue. Reboot to activate Octopi"
  read pause

exit 0
