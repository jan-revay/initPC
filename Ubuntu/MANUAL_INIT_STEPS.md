# Manual Init steps - Ubuntu

## Audio
### Ubuntu Studio Installer

If this is a PC on which I am recording audio, install:
- <https://ubuntustudio.org/ubuntu-studio-installer/>
and select options:
- ubuntustudio-lowlatency-settings (kernel parameters)
- ubuntustudio-performance-tweaks (pam_limits a.s.o.)
- optionally other packages from the Ubuntu Studio Installer
- ubuntustudio-audio-config - set PW/jack quantum to 256
- edit /etc/security/limits.d/30-ubuntustudio-audio.conf  - uncomment #@audio   -  nice      -19 and #@pipewire - nice -19
- PW quantum - set to 256

### Focusrite Scarlet 2i2 config

- install focusrite control GUI
- set 2i2 into pro audio mode in Pipewire
- create a virtual source for AUX0

Setup: <https://ubuntustudio.org/audio-configuration/>

### Chrome - disable automatic volume adjustment

When clipping in 2i2 with google chrome, system mic volume is lowered. This messes up recordings. To disable set these in chrome://flags/  :

- #enable-webrtc-allow-input-volume-adjustment - DISABLED
- #enable-webrtc-apm-downmix-capture-audio-method - DISABLED




## Other

Install Discord apt repo <https://github.com/palfrey/discord-apt>

sudo prime-select nvidia

TODO read: <https://wiki.archlinux.org/title/PRIME>
TODO: research how much more power it will use to force the use of the NVIDIA GPU for everything

TODO - install DaVinci Resolve <https://www.dedoimedo.com/computers/davinci-resolve-ubuntu-24-04.html?utm_source=chatgpt.com> - works - confirmed

- Vypnut fractional scaling.
- setup extensions

Firefox - scrollable tabs - enable <https://support.mozilla.org/en-US/questions/1285434>

- test whether the suspend works and set up the suspend timeout
- check the security tab in GNOME settings

TODO:

- harmonize keybindings and behavior between ubuntu dock and all workspaces-by-open-apps extension (e.g. what a middle click does and what a right click does...) consider whether overview on second click is ok

- PWAs
    * install pwas-for-firefox extensions <https://addons.mozilla.org/en-US/firefox/addon/pwas-for-firefox/>
    * install Messages, Messenger and WhatsApp as PWAs
    * install MS Whiteboard and Google Keep as PWAs (via Google Chrome)
    * install keybindings extension <https://browsergadgets.io/gadgets/mywebshortcuts> and set up shortcuts for MS Whiteboard
