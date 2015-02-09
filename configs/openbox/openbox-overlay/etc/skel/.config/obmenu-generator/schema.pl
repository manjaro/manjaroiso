#!/usr/bin/perl

# obmenu-generator - schema file
# Modified by Dan

=for comment
    item:      add an item inside the menu               {item => ["command", "label", "icon"]},
    cat:       add a category inside the menu             {cat => ["name", "label", "icon"]},
    sep:       horizontal line separator                  {sep => undef}, {sep => "label"},
    pipe:      a pipe menu entry                         {pipe => ["command", "label", "icon"]},
    raw:       any valid Openbox XML string               {raw => q(xml string)},
    begin_cat: begin of a category                  {begin_cat => ["name", "icon"]},
    end_cat:   end of a category                      {end_cat => undef},
    obgenmenu: generic menu settings                {obgenmenu => ["label", "icon"]},
    exit:      default "Exit" action                     {exit => ["label", "icon"]},
=cut

# NOTE:
#    * Keys and values are case sensitive. Keep all keys lowercase.
#    * ICON can be a either a direct path to an icon or a valid icon name
#    * Category names are case insensitive. (X-XFCE and x_xfce are equivalent)

require "$ENV{HOME}/.config/obmenu-generator/config.pl";

our $SCHEMA = [
#             COMMAND                           	LABEL          		ICON
   {cat  => ['filemanager',                         'File Managers',    'system-file-manager']},
   {item => ['lxterminal',   	 	            'Terminal',         'lxterminal']},
   {item => ['gnome-screenshot --interactive',      'Screenshot',       'gnome-screenshot']},
   {item => ['nitrogen',   	 	            'Nitrogen',         'nitrogen']},
   {sep  => undef},

    #          NAME            LABEL                ICON
    {cat => ['utility',     'Accessories', 'applications-utilities']},
    {cat => ['development', 'Development', 'applications-development']},
    {cat => ['education',   'Education',   'applications-science']},
    {cat => ['game',        'Games',       'applications-games']},
    {cat => ['graphics',    'Graphics',    'applications-graphics']},
    {cat => ['audiovideo',  'Multimedia',  'applications-multimedia']},
    {cat => ['network',     'Network',     'applications-internet']},    
    {cat => ['settings',    'Settings',    'applications-accessories']},
    
    #            COMMAND     LABEL        ICON
    #{pipe => ['obbrowser', 'Disk', 'drive-harddisk']},

## Custom "OB menu"

   {begin_cat => ['OB Settings',  'gnome-settings']},
   {begin_cat => ['Desktop and Login',  '48/dconf-editor']},
   {item => ['geany -m ~/.conkyrc','Conky RC','geany']},
   {item => ['geany -m ~/.config/tint2/tint2rc','Tint2 Panel','geany']},
   {item => ['gksu geany /etc/lxdm/lxdm.conf','SLxdm Configuration','geany']},
   {item => ['geany -m ~/.xinitrc','.xinitrc','geany']},
   {item => ['geany -m ~/.xprofile','.xprofile','geany']},
   {end_cat   => undef},
   {begin_cat => ['Obmenu-Generator', 'menu-editor']},
		{item => ['geany -m ~/.config/obmenu-generator/schema.pl','Pipe Menu Schema','geany']},
		{item => ['geany -m ~/.config/obmenu-generator/config.pl','Pipe Menu Config','geany']},
		{item => ['obmenu-generator -d','Refresh Icon Set','application-default-icon']},
   {end_cat   => undef},
   {begin_cat => ['Openbox',  'openbox']},
		{item => ['openbox --reconfigure','Reconfigure Openbox','openbox']},
		{item => ['geany -m ~/.config/openbox/autostart','Openbox Autostart','geany']},
		{item => ['geany -m ~/.config/openbox/rc.xml','Openbox RC','geany']},
		{item => ['geany -m ~/.config/openbox/menu.xml','Openbox Menu','geany']},
		{item => ['gksu geany /etc/oblogout.conf','Openbox Logout','geany']},
   {end_cat   => undef},
   {begin_cat => ['Pacman / Servers', 'package-manager-icon']},		
		{item => ['gksu geany /etc/pacman.conf','Pacman Config','geany']},
		{item => ['gksu geany /etc/pacman.d/mirrorlist','Pacman Mirrorlist','geany']},
   {end_cat   => undef},
   {end_cat   => undef},

## Back to standard pipe-menu

   {cat => ['system',      'System',      'applications-system']},
   {sep => undef},


## Use Oblogout script instead of simple exit command

   {item => ['xlock -mode blank', 'Lock Screen', 'lock']},
   {item => ['oblogout',        'Logout...',      'exit']},

    #{cat => ['qt',          'QT Applications',    'qtlogo']},
    #{cat => ['gtk',         'GTK Applications',   'gnome-applications']},
    #{cat => ['x_xfce',      'XFCE Applications',  'applications-other']},
    #{cat => ['gnome',       'GNOME Applications', 'gnome-applications']},
    #{cat => ['consoleonly', 'CLI Applications',   'applications-utilities']},
]
