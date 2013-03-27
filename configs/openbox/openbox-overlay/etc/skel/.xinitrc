
#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

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
## Needs only to be run once, so last sed command hashes the sed
## commands!

sed 's/_user_/'$(whoami)'/' ~/.config/obmenu-generator/schema.pl -i
sed 's/_user_/'$(whoami)'/' ~/.config/obmenu-generator/config.pl -i


DEFAULTSESSION=openbox-session

case "$1" in
     openbox) exec openbox-session ;;
     xfce) exec xfce4-session ;;
     gnome3) exec gnome-session ;;
     kde) exec startkde ;;
     cinnamon) exec gnome-session-cinnamon ;;
     razor-qt) exec razor-session ;;
     lxde) exec lxsession ;;
     mate) exec mate-session ;;
     *) exec $DEFAULTSESSION ;;
esac
