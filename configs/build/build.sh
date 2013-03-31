#!/bin/bash

# do UID checking here so someone can at least get usage instructions
if [ "$EUID" != "0" ]; then
    echo "error: This script must be run as root."
    exit 1
fi

xfce="Y"
mate="N"
e17="N"
cinnamon="N"
kde="N"
net="N"

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
   ln -sfv ../xfce/pacman-i686.conf pacman-i686.conf
   ln -sfv ../xfce/pacman-x86_64.conf pacman-x86_64.conf
   buildiso
   echo ">> done build xfce image"
   rm Packages-Xfce
   rm -R work*/*xfce*
   rm -R work*/*isomounts*
   rm work*/iso/manjaro/*/xfce-image.sqfs
   ln -sfv ../shared/Packages-Lng Packages-Lng
fi
if [ "$mate" == "Y" ] ; then
   echo ">> build mate image"
   if [ -e Packages-Lng ] ; then
      rm Packages-Lng
      rm -R work*/*lng*
      rm work*/iso/manjaro/*/lng-image.sqfs
   fi
   ln -sfv ../mate/options.conf options.conf
   ln -sfv ../mate/isomounts isomounts
   ln -sfv ../mate/Packages-Mate Packages-Mate
   ln -sfv ../mate/pacman-i686.conf pacman-i686.conf
   ln -sfv ../mate/pacman-x86_64.conf pacman-x86_64.conf
   buildiso
   echo ">> done build mate image"
   rm Packages-Mate
   rm -R work*/*mate*
   rm -R work*/*isomounts*
   rm work*/iso/manjaro/*/mate-image.sqfs
   ln -sfv ../shared/Packages-Lng Packages-Lng
fi
if [ "$e17" == "Y" ] ; then
   echo ">> build e17 image"
   if [ -e Packages-Lng ] ; then
      rm Packages-Lng
      rm -R work*/*lng*
      rm work*/iso/manjaro/*/lng-image.sqfs
   fi
   ln -sfv ../e17/options.conf options.conf
   ln -sfv ../e17/isomounts isomounts
   ln -sfv ../e17/Packages-E17 Packages-E17
   ln -sfv ../e17/pacman-i686.conf pacman-i686.conf
   ln -sfv ../e17/pacman-x86_64.conf pacman-x86_64.conf
   buildiso
   echo ">> done build e17 image"
   rm Packages-E17
   rm -R work*/*e17*
   rm -R work*/*isomounts*
   rm work*/iso/manjaro/*/e17-image.sqfs
   ln -sfv ../shared/Packages-Lng Packages-Lng
fi
if [ "$cinnamon" == "Y" ] ; then
   echo ">> build cinnamon image"
   if [ -e Packages-Lng ] ; then
      rm Packages-Lng
      rm -R work*/*lng*
      rm work*/iso/manjaro/*/lng-image.sqfs
   fi
   ln -sfv ../cinnamon/options.conf options.conf
   ln -sfv ../cinnamon/isomounts isomounts
   ln -sfv ../cinnamon/Packages-Cinnamon Packages-Cinnamon
   ln -sfv ../cinnamon/pacman-i686.conf pacman-i686.conf
   ln -sfv ../cinnamon/pacman-x86_64.conf pacman-x86_64.conf
   buildiso
   echo ">> done build cinnamon image"
   rm Packages-Cinnamon
   rm -R work*/*cinnamon*
   rm -R work*/*isomounts*
   rm work*/iso/manjaro/*/cinnamon-image.sqfs
fi
if [ "$kde" == "Y" ] ; then
   echo ">> build kde image"
   if [ -e Packages-Lng ] ; then
      rm Packages-Lng
      rm -R work*/*lng*
      rm work*/iso/manjaro/*/lng-image.sqfs
   fi
   ln -sfv ../kde/options.conf options.conf
   ln -sfv ../kde/isomounts isomounts
   ln -sfv ../kde/Packages-Kde Packages-Kde
   ln -sfv ../kde/pacman-i686.conf pacman-i686.conf
   ln -sfv ../kde/pacman-x86_64.conf pacman-x86_64.conf
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
   ln -sfv ../net/Packages-Net Packages-Net
   ln -sfv ../net/pacman-i686.conf pacman-i686.conf
   ln -sfv ../net/pacman-x86_64.conf pacman-x86_64.conf
   ln -sfv ../net/options.conf options.conf
   ln -sfv ../net/isomounts isomounts
   buildiso
   echo ">> done build net image"
   rm -R work*/*isomounts*
   #rm -R work*/*pkgs*
   ln -sfv ../shared/Packages-Lng Packages-Lng
fi
