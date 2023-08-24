# ===== GNOME EXTENSIONS =====

# org.gnome.Shell.Extensions.InstallRemoteExtension() is the same DBus method that is used in the
# gnome-browser-connector package (the package that installs extesions via Chrome/Firefox plugin)
## @note the gdbus call InstallRemoteExtension() is invoked twice twice as sometimes the first call fails

# TODO try to remove || true
# TODO create a function install_gnome_extension() and call it on a list, instead of this

gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "scroll-workspaces@gfxmonk.net" \
    || true
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "scroll-workspaces@gfxmonk.net" \
    || true

gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "workspaces-bar@fthx" \
    || true
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "workspaces-bar@fthx" \
    || true

sudo apt install -y gnome-shell-extension-manager gir1.2-gtop-2.0 lm-sensors # vitals monitor needs that

gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "Vitals@CoreCoding.com" \
    || true
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "Vitals@CoreCoding.com" \
    || true

gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "hide-universal-access@akiirui.github.io" \
    || true
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "hide-universal-access@akiirui.github.io" \
    || true

gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension \
    "auto-move-windows@gnome-shell-extensions.gcampax.github.com" \
    || true
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension \
    "auto-move-windows@gnome-shell-extensions.gcampax.github.com" \
    || true

# TODO Gnome extensions to try
# - some new clipboard manager
