#!/bin/bash
#
# Simple bash script to install the necessary software packages to
# enable firewal. Ufw service is then enabled and
# started.
#
# Written by Carl Duff (Adapted ManjaroPek Team) 

# Information about this script for the user
echo "${title}Install and Enable Full Firewall${nrml}

This will install all the necessary software to enable firewall.

Press ${grnb}<enter>${nrml} to proceed. You may still cancel the process when prompted."

read
pacman -S gufw ufw && systemctl enable ufw -f && systemctl start ufw && ufw enable && ufw status
read -p $'\n'"Process Complete. Press ${grnb}<enter>${nrml} to continue"$'\n'
exit 0
