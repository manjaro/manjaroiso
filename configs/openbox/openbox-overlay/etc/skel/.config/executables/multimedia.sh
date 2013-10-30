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
echo "Install Full Multimedia Support"
echo
echo "Running this option will update your system with full multimedia support,"
echo "including flash, codecs, and DVD-player capabilties." 
echo  
echo "Note that this process may be interrupted by an essential system upgrade. If"
echo "this happens, perform the upgrade and then run this process again."
echo 
echo "Press <enter> to proceed. You may still cancel the process when prompted."
read pause

  pacman -Syy gst-libav gst-plugins-bad gst-plugins-base gst-plugins-good gst-plugins-ugly gstreamer0.10-bad-plugins gstreamer0.10-base-plugins gstreamer0.10-good-plugins gstreamer0.10-ugly-plugins flashplugin libdvdcss
  echo
  echo "Process Complete. Press <enter> to continue."
  read pause

esac

exit 0
