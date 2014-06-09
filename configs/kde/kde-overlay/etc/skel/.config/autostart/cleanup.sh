#!/bin/sh
## Prevent Manjaro-Welcome from Autostarting on first boot-up

if [ ! -d /bootmnt/manjaro ] && [ ! -e ~/.config/.mcleanup ]; then
    rm -v ~/.config/autostart/manjaro-welcome.desktop
fi
touch ~/.config/.mcleanup
