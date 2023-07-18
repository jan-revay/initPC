# ===== GNOME EXTENSIONS =====

# org.gnome.Shell.Extensions.InstallRemoteExtension() is the same DBus method that is used in the
# gnome-browser-connector package (the package that installs extesions via Chrome/Firefox plugin)
## @note the gdbus call InstallRemoteExtension() is invoked twice twice as sometimes the first call fails

gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "scroll-workspaces@gfxmonk.net"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "scroll-workspaces@gfxmonk.net"

gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "workspaces-bar@fthx"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "workspaces-bar@fthx"


sudo apt install -y gnome-shell-extension-manager gir1.2-gtop-2.0 lm-sensors # vitals monitor needs that
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "Vitals@CoreCoding.com"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "Vitals@CoreCoding.com"

gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "hide-universal-access@akiirui.github.io"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "hide-universal-access@akiirui.github.io"

gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension \
    "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension \
    "auto-move-windows@gnome-shell-extensions.gcampax.github.com"

# TODO Gnome extensions to try
# - some new clipboard manager