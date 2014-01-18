#!/bin/bash
#
# Simple bash script to install the necessary software packages to
# enable full multimedia capabilities.
#
# Written by Carl Duff

source ./shared.sh

clear
root_check
ping_check

# Information about this script for the user
echo "${title}Manjaro Hardware Detection: Graphics Driver Detection and Installation${nrml}

Manjaro can automatically detect and install the most appropriate graphics
driver(s) for your system. There are two choices:

${blub}1. Open Source (non-proprietary) Drivers${nrml}
Includes drivers for Virtual Machines and Intel Chipsets, as well as drivers
written by the Linux Community.

${ylwb}2. Proprietary Drivers (Recommended)${nrml}
Comprises of drivers written by the hardware manufacturers such as NVidia for
their graphics cards. These provide the best performance.

You may run this program to switch between open source and proprietary drivers
at any time.

Press ${grnb}<enter>${nrml} to first identify the graphics driver(s) currently installed."

read

## Identify what has already been installed
clear
mhwd -li

## And now the options
echo "
${blub}1. Detect and Install Open Source (non-proprietary) Drivers

${ylwb}2. Detect and Install Proprietary Drivers (Recommended).

${nrml}Enter the number of your choice (${blub}1${nrml} or ${ylwb}2${nrml}), or just press ${grnb}<enter>${nrml} to cancel."

while true; do
    read option
    case "$option" in
        1)  driver=free; break ;;
        2)  driver=nonfree; break ;;
        "") exit 0 ;;
        *)  echo "Invalid option"; continue ;;
    esac
done

pacman -Syy manjaro-system pacman --needed 2>/dev/null
mhwd -a pci $driver 0300 -f
read -p $'\n'"Process Complete. Press ${grnb}<enter>${nrml} to continue"$'\n'
exit 0
