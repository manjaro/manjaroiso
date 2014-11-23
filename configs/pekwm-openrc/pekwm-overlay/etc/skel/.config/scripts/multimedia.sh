#!/bin/bash
#
# Simple bash script to install the necessary software packages to
# enable full multimedia capabilities.
#
# Written by Carl Duff (Adapted ManjaroPek Team)

# Information about this script for the user
echo "${title}Install Full Multimedia Support${nrml}

Running this option will update your system with full multimedia support,
including flash, codecs, java web-applet and DVD-player capabilities.

Press ${grnb}<enter>${nrml} to proceed. You may still cancel the process when prompted."

read
pacman -S flashplugin icedtea-web
read -p $'\n'"Process Complete. Press ${grnb}<enter>${nrml} to continue"$'\n'
exit 0
