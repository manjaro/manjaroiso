#!/bin/bash

systemctl stop ofono
systemctl stop connman
systemctl disable ofono
systemctl disable connman
pacman --noconfirm -Rcsn connman econnman ofono
pacman --noconfirm -U \
  /opt/manjaro-enlightenment/gcr-3.10.1-3-"$(uname -m)".pkg.tar.xz \
  /opt/manjaro-enlightenment/openresolv-3.5.6-1-any.pkg.tar.xz \
  /opt/manjaro-enlightenment/netctl-1.6-1-any.pkg.tar.xz \
  /opt/manjaro-enlightenment/network-manager-applet-0.9.8.8-1-"$(uname -m)".pkg.tar.xz \
  /opt/manjaro-enlightenment/networkmanager-0.9.8.8-3-"$(uname -m)".pkg.tar.xz \
  /opt/manjaro-enlightenment/gnome-keyring-3.10.1-2-"$(uname -m)".pkg.tar.xz
systemctl enable NetworkManager
systemctl start NetworkManager
echo "/etc/xdg/autostart/nm-applet.desktop" >> /etc/skel/.e/e/applications/startup/.order
rm /etc/skel/Desktop/nm-swap.desktop
