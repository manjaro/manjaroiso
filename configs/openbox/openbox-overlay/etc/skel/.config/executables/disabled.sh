## Simple bash script used in place of the real ones to prevent them being
## used via the installation media.
##
## Written by Carl Duff
##

clear

echo
echo "This function is not available until the system has been installed!"
echo
echo "Press $(tput setaf 2)$(tput bold)<enter> $(tput sgr0)to close this window."
read pause

exit 0
