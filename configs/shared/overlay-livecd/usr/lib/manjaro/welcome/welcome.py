#!/usr/bin/env python2

import sys
import pygtk
pygtk.require("2.0")
import gtk
import gtk.glade
import commands
import os
import gettext
from user import home
import webkit
import string

# i18n
gettext.install("welcome", "/usr/share/manjaro/locale")

# i18n for menu item
menuName = _("Welcome Screen")
menuComment = _("Introduction to Manjaro")

class welcome():
    def __init__(self):
        gladefile = "/usr/lib/manjaro/welcome/welcome.glade"
        wTree = gtk.glade.XML(gladefile,"main_window")
        wTree.get_widget("main_window").set_title(_("Welcome Screen"))
        wTree.get_widget("main_window").set_icon_from_file("/usr/share/icons/manjaro.png")

        sys.path.append('/usr/lib/manjaro/common')
        from configobj import ConfigObj
        config = ConfigObj("/etc/lsb-release")
        codename = config['DISTRIB_CODENAME']
        release = config['DISTRIB_RELEASE']
        if os.path.exists("/bootmnt/manjaro/i686/xfce-image.sqfs"):
           edition = "XFCE (32bit)"
        elif os.path.exists("/bootmnt/manjaro/i686/gnome-image.sqfs"):
           edition = "Gnome (32bit)"
        elif os.path.exists("/bootmnt/manjaro/i686/cinnamon-image.sqfs"):
           edition = "Cinnamon (32bit)"
        elif os.path.exists("/bootmnt/manjaro/i686/openbox-image.sqfs"):
           edition = "Openbox (32bit)"
        elif os.path.exists("/bootmnt/manjaro/i686/mate-image.sqfs"):
           edition = "MATE (32bit)"
        elif os.path.exists("/bootmnt/manjaro/i686/kde-image.sqfs"):
           edition = "KDE (32bit)"
        elif os.path.exists("/bootmnt/manjaro/i686/lxde-image.sqfs"):
           edition = "LXDE (32bit)"
        elif os.path.exists("/bootmnt/manjaro/i686/e17-image.sqfs"):
           edition = "E17 (32bit)"
        elif os.path.exists("/bootmnt/manjaro/i686/custom-image.sqfs"):
           edition = "Custom (32bit)"
        elif os.path.exists("/bootmnt/manjaro/x86_64/xfce-image.sqfs"):
           edition = "XFCE (64bit)"
        elif os.path.exists("/bootmnt/manjaro/x86_64/gnome-image.sqfs"):
           edition = "Gnome (64bit)"
        elif os.path.exists("/bootmnt/manjaro/x86_64/cinnamon-image.sqfs"):
           edition = "Cinnamon (64bit)"
        elif os.path.exists("/bootmnt/manjaro/x86_64/openbox-image.sqfs"):
           edition = "Openbox (64bit)"
        elif os.path.exists("/bootmnt/manjaro/x86_64/mate-image.sqfs"):
           edition = "MATE (64bit)"
        elif os.path.exists("/bootmnt/manjaro/x86_64/kde-image.sqfs"):
           edition = "KDE (64bit)"
        elif os.path.exists("/bootmnt/manjaro/x86_64/lxde-image.sqfs"):
           edition = "LXDE (64bit)"
        elif os.path.exists("/bootmnt/manjaro/x86_64/e17-image.sqfs"):
           edition = "E17 (64bit)"
        elif os.path.exists("/bootmnt/manjaro/x86_64/custom-image.sqfs"):
           edition = "Custom"
        else:
           edition = "Unknown"

        wTree.get_widget("main_window").connect("destroy", gtk.main_quit)

        browser = webkit.WebView()
        wTree.get_widget("scrolled_welcome").add(browser)
        browser.connect("button-press-event", lambda w, e: e.button == 3)
        subs = {}
        subs['release'] = "Manjaro %s \"%s\"" % (release, codename)
        subs['edition'] = edition
        subs['title'] = _("Welcome to Manjaro")
        subs['release_title'] = _("Release")
        subs['edition_title'] = _("Edition")
        subs['discover_title'] = _("Documentation")
        subs['find_help_title'] = _("Support")
        subs['contribute_title'] = _("Project")
        subs['community_title'] = _("Community")
        subs['system_title'] = _("System status")
        subs['new_features'] = _("New features")
        subs['know_problems'] = _("Known problems")
        subs['user_guide'] = _("User guide (PDF)")
        subs['forums'] = _("Forums")
        subs['irc'] = _("Chat Room")
        subs['sponsor'] = _("Sponsors")
        subs['donation'] = _("Donations")
        subs['get_involved'] = _("Get involved")
        subs['ideas'] = _("Contributions")
        subs['software'] = _("Software Manager")
        subs['hardware'] = _("Hardware Detection")
        subs['tutorials'] = _("Tutorials")
        subs['extra_apps'] = _("Upgrade to the DVD Edition")
                   
        subs['show'] = _("Show this dialog at startup")
        subs['close'] = _("Close")
        if os.path.exists(home + "/.manjaro/welcome/norun.flag"):
            subs['checked'] = ("")
        else:
            subs['checked'] = ("CHECKED")

        subs['welcome'] = _("Welcome and thank you for choosing Manjaro. We hope you'll enjoy using it as much as we did designing it. The links below will help you get started with your new operating system. Have a great time and don't hesitate to send us your feedback. Note: On live medias use 'manjaro' as password if needed.")
        template = open("/usr/lib/manjaro/welcome/templates/welcome.html").read()
        html = string.Template(template).safe_substitute(subs)
        browser.load_html_string(html, "file:/")
        browser.connect('title-changed', self.title_changed)
        wTree.get_widget("main_window").show_all()

    def title_changed(self, view, frame, title):
        if title.startswith("nop"):
            return
        # call directive looks like:
        #  "call:func:arg1,arg2"
        #  "call:func"
        if title == "event_irc":
            os.system("xdg-open http://forum.manjaro.org/index.php?action=irc &")
        elif title == "event_new_features":
            os.system("xdg-open http://wiki.manjaro.org &")
        elif title == "event_known_problems":
            os.system("xdg-open http://wiki.manjaro.org &")
        elif title == "event_user_guide":
            os.system("xdg-open \"/etc/manjaro/documents/Beginner User Guide.pdf\" &")
        elif title == "event_forums":
            os.system("xdg-open http://forum.manjaro.org/ &")
        elif title == "event_tutorials":
            os.system("xdg-open http://forum.manjaro.org/index.php?board=15.0 &")
        elif title == "event_ideas":
            os.system("xdg-open http://forum.manjaro.org/index.php?board=9.0 &")
        elif title == "event_software":
            os.system("xdg-open http://wiki.manjaro.org/index.php?title=Pacman &")
        elif title == "event_hardware":
            os.system("xdg-open http://wiki.manjaro.org/index.php?title=Manjaro_Hardware_Detection &")
        elif title == "event_get_involved":
            os.system("xdg-open http://wiki.manjaro.org/index.php?title=Basic_Submission_Rules &")
        elif title == "event_sponsor":
            os.system("xdg-open http://manjaro.org/our-sponsors/ &")
        elif title == "event_donation":
            os.system("xdg-open http://manjaro.org/donate/ &")            
        elif title == "event_close_true":
            if os.path.exists(home + "/.manjaro/welcome/norun.flag"):
                os.system("rm -rf " + home + "/.manjaro/welcome/norun.flag")
            gtk.main_quit()
        elif title == "event_close_false":
            os.system("mkdir -p " + home + "/.manjaro/welcome")
            os.system("touch " + home + "/.manjaro/welcome/norun.flag")
            gtk.main_quit()
        elif title == "checkbox_checked":
            if os.path.exists(home + "/.manjaro/welcome/norun.flag"):
                os.system("rm -rf " + home + "/.manjaro/welcome/norun.flag")
        elif title == "checkbox_unchecked":
            os.system("mkdir -p " + home + "/.manjaro/welcome")
            os.system("touch " + home + "/.manjaro/welcome/norun.flag")


if __name__ == "__main__":
    welcome()
    gtk.main()
