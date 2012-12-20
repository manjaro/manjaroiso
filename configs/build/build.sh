#!/bin/bash

# do UID checking here so someone can at least get usage instructions
if [ "$EUID" != "0" ]; then
    echo "error: This script must be run as root."
    exit 1
fi

xfce="Y"
cinnamon="Y"
kde="Y"
net="Y"

if [ "$xfce" == "Y" ] ; then
   echo ">> build xfce image"
   if [ -e Packages-Lng ] ; then
      rm Packages-Lng
      rm -R work*/*lng*
      rm work*/iso/manjaro/*/lng-image.sqfs
   fi
   ln -sfv ../xfce/options.conf options.conf
   ln -sfv ../xfce/isomounts isomounts
   ln -sfv ../xfce/Packages-Xfce Packages-Xfce
   buildiso
   echo ">> done build xfce image"
   rm Packages-Xfce
   rm -R work*/*xfce*
   rm -R work*/*isomounts*
   rm work*/iso/manjaro/*/xfce-image.sqfs
   ln -sfv ../shared/Packages-Lng Packages-Lng
fi
if [ "$cinnamon" == "Y" ] ; then
   echo ">> build cinnamon image"
   ln -sfv ../cinnamon/options.conf options.conf
   ln -sfv ../cinnamon/isomounts isomounts
   ln -sfv ../cinnamon/Packages-Cinnamon Packages-Cinnamon
   buildiso
   echo ">> done build cinnamon image"
   rm Packages-Cinnamon
   rm -R work*/*cinnamon*
   rm -R work*/*isomounts*
   rm work*/iso/manjaro/*/cinnamon-image.sqfs
fi
if [ "$kde" == "Y" ] ; then
   echo ">> build kde image"
   rm -R work*/*lng*
   rm work*/iso/manjaro/*/lng-image.sqfs
   ln -sfv ../kde/options.conf options.conf
   ln -sfv ../kde/isomounts isomounts
   ln -sfv ../kde/Packages-Kde Packages-Kde
   buildiso
   echo ">> done build kde image"
   rm Packages-Kde
   rm -R work*/*kde*
   rm -R work*/*isomounts*
   rm work*/iso/manjaro/*/kde-image.sqfs
fi
if [ "$net" == "Y" ] ; then
   echo ">> build net image"
   if [ -e Packages-Lng ] ; then
      rm Packages-Lng
      rm -R work*/*lng*
      rm work*/iso/manjaro/*/lng-image.sqfs
   fi
   #rm -R work*/pkgs-free-overlay
   #rm -R work*/pkgs-nonfree-overlay
   #rm work*/iso/manjaro/*/pkgs-free-overlay.sqfs
   #rm work*/iso/manjaro/*/pkgs-nonfree-overlay.sqfs
   ln -sfv ../net/options.conf options.conf
   ln -sfv ../net/isomounts isomounts
   buildiso
   echo ">> done build net image"
   rm -R work*/*isomounts*
   #rm -R work*/*pkgs*
   ln -sfv ../shared/Packages-Lng Packages-Lng
fi
