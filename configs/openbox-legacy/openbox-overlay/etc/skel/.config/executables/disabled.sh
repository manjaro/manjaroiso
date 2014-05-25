#!/bin/bash
#
# Simple bash script used in place of the real ones to prevent them being
# used via the installation media.
#
# Written by Carl Duff

source ./shared.sh

clear

echo "This function is not available until the system has been installed!
Press ${grnb}<enter>${nrml} to close this window."

read
exit 0
