#!/bin/bash
#
# Simple bash script to install Octopi, a graphical front-end for 
# pacman.
#
# Written by Carl Duff

source ./shared.sh

clear
root_check
ping_check

# Information about this script for the user
echo "${title}Install Octopi, the Graphical Software Manager${nrml}

The preferred graphical application to manage software in ${grn}Manjaro${grn}Box
${nrml}is ${grn}Octopi${nrml}.

Octopi allows for easy software searches, installation, and removal at the
click of a button, including from the Arch User Repository (AUR).  It can also
automatically provide notifications on your desktop when new updates are
available.

${grnb}1. Install Octopi and Octopi Notifier (recommended)${nrml}
Install the complete package for automatic notifications of updates.

${ylwb}2. Install Octopi Only${nrml}
Install the software manager alone without desktop notifications.

Enter the number of your choice (${grnb}1${nrml} or ${ylwb}2${nrml}), or just press ${grnb}<enter>${nrml} to cancel."

while true; do
    read option
    case "$option" in
        1)  pkg=octopi-notifier; break ;;
        2)  pkg=octopi; break ;;
        "") exit 0 ;;
        *)  echo "Invalid option"; continue ;;
    esac
done

pacman -Syy manjaro-system pacman --needed 2>/dev/null
pacman -S $pkg
read -p $'\n'"Process Complete. Press ${grnb}<enter>${nrml} to continue"$'\n'
exit 0
