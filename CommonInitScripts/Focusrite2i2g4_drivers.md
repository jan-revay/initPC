# Focusrite Scarlett 2i2 4th Gen Linux drivers

1. Driver for Scarlett 4th Gen (Solo/2i2/4i4) is already part of the Linux kernel since Linux 6.8 (no need for any extra steps)
2. (FCP driver is not needed for Scarlett 4th Gen Solo/2i2/4i4)
3. Install Focusrite Scarlett GUI: <https://github.com/geoffreybennett/alsa-scarlett-gui/tree/master> resp. <https://github.com/geoffreybennett/alsa-scarlett-gui/blob/master/docs/INSTALL.md>
4. Read the docs:
   - <https://github.com/geoffreybennett/alsa-scarlett-gui/blob/master/docs/iface-4th-gen-small.md>
   - <https://github.com/geoffreybennett/alsa-scarlett-gui/blob/master/docs/USAGE.md>
5. Add .desktop file:
   - `cd ~/.local/share/applications`
   - `v alsa-scarlett-gui.desktop`
   - `chmod +x alsa-scarlett-gui.desktop`
   - ```
      [Desktop Entry]
      Name=Focusrite Control
      Comment=Open ALSA Scarlett GUI for Focusrite interfaces
      Exec=sh -c "cd /home/jr/x/alsa-scarlett-gui/src/ && ./alsa-scarlett-gui"
      Icon=audio-card
      Terminal=false
      Type=Application
      Categories=AudioVideo;Mixer;Settings;
      StartupNotify=true
      StartupWMClass=vu.b4.alsa-scarlett-gui
      ```
