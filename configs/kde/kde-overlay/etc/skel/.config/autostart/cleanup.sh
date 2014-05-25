#!/bin/sh
## Prevent Manjaro-Welcome from Autostarting

if [ ! -d /bootmnt/manjaro ]; then
    rm ~/.config/autostart/manjaro-welcome.desktop
fi
