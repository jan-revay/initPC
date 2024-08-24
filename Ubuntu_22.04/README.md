# Init script for Ubuntu desktop (Ubuntu + GNOME)


# Bugs

- commit 5dca40894e79c15c5b832c2958a5df0bf85b8f95 made GNOME unstable (unable to use mouse)
  - going to overview and back (Win, pause, Win) might have solved the problem
  - if the problem reoccurs, consider reverting the commit

## TODO

- create an automatic tiling script via ydotool and simulating keyboard shortcuts
  see: <https://www.reddit.com/r/linuxquestions/comments/u5mxzi/xdotool_alternative_for_wayland/>


## GNOME extensions to try

### Tiling

- gTile
- https://youtu.be/R2k9PG-TXFE?si=83O-h7dkwTTw3YeU
- https://www.youtube.com/watch?v=MOr8jWtSmMI
- https://www.youtube.com/watch?v=zEe1CqlWKZ0
- https://www.youtube.com/watch?v=b5kaEtv0BtE
- https://www.youtube.com/watch?v=KtjYPMCvQ7Y
- https://www.youtube.com/watch?v=-t_H_HfOPss
- https://www.youtube.com/watch?v=AE1-W2bMVEs
- https://www.youtube.com/watch?v=pV9oFUHX9bo
- https://www.youtube.com/watch?v=ZgHX8jPuHjE
- https://www.youtube.com/watch?v=JtXptDCaP-c
- https://www.youtube.com/watch?v=TTPjZUo44-k
- https://youtu.be/MOr8jWtSmMI?si=fwfcOr9FsVDKx92i
- https://www.youtube.com/watch?v=R2k9PG-TXFE

#### Tiling GNOME extensions
- https://extensions.gnome.org/extension/7065/tiling-shell/
  - https://github.com/domferr/tilingshell
  - https://www.omgubuntu.co.uk/2024/06/tiling-shell-gnome-extension-in-ubuntu
- https://extensions.gnome.org/extension/3733/tiling-assistant/
- https://extensions.gnome.org/extension/4702/awesome-tiles/
- https://extensions.gnome.org/extension/6553/rectangle/
- https://extensions.gnome.org/extension/6099/paperwm/
- https://extensions.gnome.org/extension/4481/forge/
- https://extensions.gnome.org/extension/1604/arrange-windows/
- https://extensions.gnome.org/extension/6970/wintile-beyond/
- https://extensions.gnome.org/extension/4548/tactile/
- https://extensions.gnome.org/extension/28/gtile/
- reviews
   - https://gist.github.com/bmaupin/5ebd4d7fd52f8911e14fa55cd58aee2d
   - https://www.reddit.com/r/gnome/comments/17qid5h/looking_for_tiling_extensions_for_gnome_45/
   - https://itsfoss.com/gnome-tiling-assistant/
   - https://www.omgubuntu.co.uk/2024/07/tiling-shell-adds-another-way-to-tile-windows-quickly
   - https://www.omglinux.com/wintile-gnome-extension-v13/
   - https://itsfoss.com/material-shell/
   - https://xerolinux.xyz/posts/tiling-shell/
   - https://repology.org/project/gnome:tiling-assistant/packages
   - https://www.linuxpromagazine.com/index.php/layout/set/print/Issues/2021/244/Material-Shell
   - https://x.com/omgubuntu/status/1802461186933260781
   - https://forum.endeavouros.com/t/extensions-in-gnome-45/45209?page=3

## Script to position all windows after restart

Have a look at these gnome extensions:
- https://github.com/ickyicky/window-calls
- https://github.com/hseliger/window-calls-extended
- https://github.com/lucaswerkmeister/activate-window-by-title
- https://extensions.gnome.org/extension/5592/focused-window-d-bus/
- I could use script and keyboard shortcuts to automatically tile windows on startup

### Window management

Add shortcuts with arrows as well as vim keys (so that I don't need to move my hands)

#### Window management P1
- https://extensions.gnome.org/extension/6768/lomotion/ (or implement this shortcuts the standard way)

#### Window management - to prioritize
- search "window" in gnome extensions and go throug the entire list
- https://extensions.gnome.org/extension/5696/one-window-wonderland/
- sth. to automatically tile windows
- https://extensions.gnome.org/extension/6385/steal-my-focus-window/ vs. https://extensions.gnome.org/extension/5410/grand-theft-focus/
- https://extensions.gnome.org/extension/6730/wsp-windows-search-provider/
- https://extensions.gnome.org/extension/4709/another-window-session-manager/
- https://extensions.gnome.org/extension/4412/advanced-alttab-window-switcher/
- https://extensions.gnome.org/extension/973/switcher/
- https://extensions.gnome.org/extension/1007/window-is-ready-notification-remover/
- https://extensions.gnome.org/extension/6610/move-to-next-screen/
- https://extensions.gnome.org/extension/1336/run-or-raise/
- https://extensions.gnome.org/extension/6084/fix-focus-on-workspace-switch/
- https://extensions.gnome.org/extension/6768/lomotion/
- https://extensions.gnome.org/extension/4783/default-workspace/

### PIP mode

- https://github.com/iamlemec/miniview
- https://extensions.gnome.org/extension/6816/wtmb-window-thumbnails/


### Other gnome extensions to try

- https://extensions.gnome.org/extension/3843/just-perfection/
- https://extensions.gnome.org/extension/6084/fix-focus-on-workspace-switch/
- https://extensions.gnome.org/extension/7068/kando-integration/
- https://extensions.gnome.org/extension/3942/toggle-alacritty/
- https://extensions.gnome.org/extension/4167/custom-hot-corners-extended/
- https://extensions.gnome.org/extension/4158/gnome-40-ui-improvements/
- https://extensions.gnome.org/extension/5177/vertical-workspaces/
- https://extensions.gnome.org/extension/6269/extensions-glass-grid/
- https://extensions.gnome.org/extension/6580/open-bar/
- https://extensions.gnome.org/extension/5353/window-state-manager/
- https://extensions.gnome.org/extension/6254/application-tabs/
- https://extensions.gnome.org/extension/1689/always-show-titles-in-overview/
- https://extensions.gnome.org/extension/2542/floating-dock/
- https://extensions.gnome.org/extension/6771/hide-items/
- https://github.com/StreamController/StreamController
- https://github.com/StreamController/streamcontroller-core447.com?tab=readme-ov-file
- https://extensions.gnome.org/extension/1849/screen-word-translate/
- https://extensions.gnome.org/extension/4158/gnome-40-ui-improvements/
- https://extensions.gnome.org/extension/6490/overview-hover/
- https://extensions.gnome.org/extension/6712/dash-to-dock-workaround/
- https://extensions.gnome.org/extension/5188/super-key/
- consider PopOS extensions


## TODO

### Bugs
- solve everlaying keyboard shortcuts
    - Win+e
- dash-to-dock
  - Unable to start two instances of the same application
    - https://ubuntuforums.org/showthread.php?t=2487347
    - https://forum.manjaro.org/t/2-issues-with-dash-to-dock-extension/83474/4
    - https://www.reddit.com/r/pop_os/comments/ns3oh4/do_you_use_dash_to_dock_extension/
    - consider using some other dock extension from other linux distro
    - https://askubuntu.com/questions/1332616/whats-the-difference-between-dash-and-dock
    - https://www.reddit.com/r/Fedora/comments/snsdsn/dashtodock_favorite_applications_take_a_long_time/
- add keyboard shortcut for changing tiling layout in Tiling Shell gnome extension
