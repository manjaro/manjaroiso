#!/bin/bash
#
# Simple bash script to install the Manjaro Settings Manager 
#
# Written by Carl Duff

source ./shared.sh

clear
root_check
ping_check

# Information about this script for the user
echo "${title}Install the Manjaro Settings Manager${nrml}

The ${grn}Manjaro Settings Manager${nrml} is a user-friendly application to very easily
change your user account, keyboard layout, and preferred language. It will also
automatically notify you of any updates available for installed language packs.

Press ${grnb}<enter>${nrml} to proceed. You may still cancel the process when prompted."

read
pacman -Syy manjaro-system pacman --needed 2>/dev/null
pacman -S manjaro-settings-manager
read -p $'\n'"Process Complete. Press ${grnb}<enter>${nrml} to continue"$'\n'
exit 0
