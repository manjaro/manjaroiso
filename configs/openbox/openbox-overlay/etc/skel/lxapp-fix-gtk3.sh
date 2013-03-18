#!/bin/bash

# script to copy gtk-3.0 to ~/.config/
# by Mr Green & darktux
# gtk3switch version 0.2

# paths
user_home=/home/${USER}
theme_name=$@ # all arguments....
theme_dir=${user_home}/.themes
system_theme_dir=/usr/share/themes

if [ $# -eq 0 ]; then
		echo
		echo "Gtk3 themes"
		echo "==========="
		find ${system_theme_dir} ${theme_dir} -type d -name 'gtk-3.0' | awk -F'/' '{print $5}'
		echo 
		echo "To use one of above themes:"
		echo "~/lxapp-fix-gtk3.sh <theme_name>"
    exit
fi

# Check if theme exists then copy it if it does
flag=0
for x in $system_theme_dir $theme_dir; do
	if [ -d ${x}/"${theme_name}"/gtk-3.0 ]; then
  	cp -a ${x}/"${theme_name}"/gtk-3.0 ${user_home}/.config
  	echo "Gtk3 theme ${theme_name} installed"
  	flag=1
	fi
done

# Theme not found
if [ "$flag" -eq 0 ]; then
  echo "Theme: ${theme_name} not found"
else
# Option to tweak theme with lxappearance (after theme instalation) 
  read -p "Tweak theme with Lxappearance ? (Y/n) " yn 
  case $yn in
    [Nn]* ) exit ;;
    * )   lxappearance ;;
  esac

fi
 
exit 0