export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

DEFAULT_SESSION=xfce4-session
case $1 in
  xfce) exec  ck-launch-session dbus-launch xfce4-session ;;
  *) exec ck-launch-session dbus-launch  $DEFAULT_SESSION ;;
esac



