#!/bin/bash
#
# Simple bash script to change between stable, testing and unstable repos
#
# Written by Carl Duff

source ./shared.sh

clear
root_check
ping_check

# Information about this script for the user
echo "${title}Change Manjaro Repos${nrml}

Manjaro uses three types of repositories:

${grnb}1. Stable (recommended)${nrml}
This is the default repository used by Manjaro systems to provide updates and
downloads to general users. About two weeks behind Arch.

${ylwb}2. Testing${nrml}
This is used to store patched software packages from the unstable repositories,
and other new software releases deemed at least sufficiently stable. About a
week behind Arch, software needs further checks / patching.

${redb}3. Unstable${nrml}
A day or two behind the Arch repositories, this is also used to store software
packages that have known or suspected issues.

Enter the number of your choice (${grnb}1${nrml}, ${ylwb}2${nrml} or ${redb}3${nrml}), or just press ${grnb}<enter>${nrml} to cancel.
The fastest mirrors will be automatically chosen. Your system will NOT be
automatically updated, however. Enter 'sudo pacman -Syu' to do so after this
process has completed."

while true; do
    read option
    case "$option" in
        1)  repo="stable"; break ;;
        2)  repo="testing"; break ;;
        3)  repo="unstable"; break ;;
        "") exit 0 ;;
        *)  echo "Invalid option"; continue ;;
    esac
done

pacman-mirrors -g -b "$repo" && pacman -Syy manjaro-system pacman --needed 2>/dev/null
read -p $'\n'"Process Complete. Press ${grnb}<enter>${nrml} to continue"$'\n'
exit 0
