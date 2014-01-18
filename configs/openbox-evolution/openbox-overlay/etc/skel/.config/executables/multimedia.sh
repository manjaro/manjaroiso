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
echo "${title}Install Full Multimedia Support${nrml}

Running this option will update your system with full multimedia support,
including flash, codecs, java web-applet and DVD-player capabilities.

Press ${grnb}<enter>${nrml} to proceed. You may still cancel the process when prompted."

read
pacman -Syy manjaro-system pacman --needed 2>/dev/null
pacman -S gst-libav gst-plugins-bad gst-plugins-base gst-plugins-good gst-plugins-ugly gstreamer0.10-bad-plugins gstreamer0.10-base-plugins gstreamer0.10-good-plugins gstreamer0.10-ugly-plugins flashplugin libdvdcss icedtea-web-java7
read -p $'\n'"Process Complete. Press ${grnb}<enter>${nrml} to continue"$'\n'
exit 0
