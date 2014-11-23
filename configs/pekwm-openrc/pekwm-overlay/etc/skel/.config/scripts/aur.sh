#!/bin/bash
#
# Simple bash script to install the necessary software packages to
# access the AUR.
#
# Written by Carl Duff (Adapted ManjaroPek Team)

# Information about this script for the user
echo "${title}Install full Arch User Repository (AUR) support${nrml}

The AUR is a community-maintained repository that may contain extra software
packages not otherwise available from the official Manjaro repositories.

Manjaro is not responsible for AUR packages. Our user guide and wiki provides
instructions on how to access the AUR once these packages are installed.

Press ${grnb}<enter>${nrml} to proceed. You may still cancel the process when prompted."

read
pacman -S autoconf automake binutils bison fakeroot flex gcc libtool m4 make patch yaourt
read -p $'\n'"Process Complete. Press ${grnb}<enter>${nrml} to continue"$'\n'
exit 0