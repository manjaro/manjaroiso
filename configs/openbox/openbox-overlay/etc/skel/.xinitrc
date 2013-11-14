
#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#
# Written by Phil Muller and Carl Duff


## Ensure that the D-Bus Communication System is running properly to fix
## File management, authentication, and other essential system processes

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi


## Ensure that GTK themes are applied uniformly in the Desktop Environment

export GTK2_RC_FILES="$HOME/.gtkrc-2.0" 


## Where the default Home folders have not already been created, generate them

if [ -x /usr/bin/xdg-user-dirs-update ]; then
   /usr/bin/xdg-user-dirs-update
fi

## Ensure that obmenu-generator (a pipe menu) is set to the user.
## Does this for each session (i.e. ease of use for addtional
## accounts where created.

sed 's/_user_/'$(whoami)'/' ~/.config/obmenu-generator/schema.pl -i
sed 's/_user_/'$(whoami)'/' ~/.config/obmenu-generator/config.pl -i


## Enable SLiM to enable selection of multiple desktop environments, or
## set a single session. Only one or the other must be unhashed! In either
## instance, /etc/slim.conf must also be amended accordingly.

## Enable multiple desktop environments
#exec $1

## Set a single desktop environment
exec openbox-session
#exec xfce4-session
#exec gnome-session
#exec startkde
#exec cinnamon-session
#exec razor-session
#exec lxsession
#exec mate-session
