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
echo "Change Manjaro Repos"
echo
echo "Manjaro uses three types of repository:"
echo  
echo "1. Stable (recommended)"
echo "This is the default repository used by Manjaro systems to provide updates and" 
echo "downloads to general users. About two weeks behind Arch."
echo  
echo "2. Testing"
echo "This is used to store patched software packages from the unstable"
echo "repositories, and other new software releases deemed at least sufficiently" 
echo "stable. About a week behind Arch, software needs further checks / patching."
echo 
echo "3. Unstable"
echo "A day or two behind the Arch repositories, this is also used to store" 
echo "software packages that have known or suspected issues."
echo
echo "Enter the number of your choice (1, 2 or 3), or just press <enter> to cancel."
echo "Your system will NOT be automatically updated. Enter 'pacman -Syu' to do this."
read option
case "$option" in

  "1")
  pacman-mirrors -g -b stable && pacman -Syy
  echo
  echo "Process Complete. Press <enter> to continue"
  read pause
  echo
  ;;

  "2")
  pacman-mirrors -g -b testing && pacman -Syy
  echo
  echo "Process Complete. Press <enter> to continue"
  read pause
  echo
  ;;

  "3")
  pacman-mirrors -g -b unstable && pacman -Syy
  echo
  echo "Process Complete. Press <enter> to continue"
  read pause
  echo
  ;;
esac

exit 0
