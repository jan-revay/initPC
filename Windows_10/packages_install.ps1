# Run this file as administrator to avoid prompts

# TODOs:
# - ? repair broken packages e.g. by using the msstore version instead
#   resp. disabling the hash check using the --ignore-security-hash option ?
# - fine-tune this file on a virtual machine
# - add MS Office
# - add Qt
# - add zig compiler
# - next time also create a winget config file (once winget-config is released)
# - optimize for runtime performance (if some program has a service that
#   takes CPU/memory)
# TODO https://github.com/microsoft/winget-cli/blob/master/doc/Settings.md
# TODO nvidia driver (studio or gaming?)
# TODO other relevant drivers
# TODO add useful packages from here: https://github.com/actions/runner-images/blob/main/images/win/Windows2022-Readme.md
# TODO add `--silent` and `--disable-interactivity` options to `winget install` commands? https://learn.microsoft.com/en-us/windows/package-manager/winget/install
# TODO rewrite (package list and a single install command)

Set-PSDebug -Trace 1
$ErrorActionPreference = "Stop"

# Web browsers
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Mozilla.Firefox
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Google.Chrome

# Utils
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id VMware.WorkstationPlayer # broken
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id WinDirStat.WinDirStat
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Docker.DockerDesktop
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id XAMPPRocky.tokei # broken?
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id 7zip.7zip
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Ookla.Speedtest.Desktop
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id AltSnap.AltSnap
# TODO add relevant sysinternals packages (see `winget search sysinternals`)


# Version controll
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id GitHub.cli
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Git.Git
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id GitHub.GitHubDesktop
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id GitExtensionsTeam.GitExtensions
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id o2sh.onefetch

# Drivers and HW support
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Logitech.OptionsPlus

# Code editors
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Microsoft.VisualStudioCode
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Neovim.Neovim
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Helix.Helix

# Terminal emulators
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Microsoft.WindowsTerminal
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Maximus5.ConEmu
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Eugeny.Tabby
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Alacritty.Alacritty

# compilers, build tools and interpreters
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Python.Python.3.12
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id LLVM.LLVM
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id JFrog.Conan
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Kitware.CMake
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Ninja-build.Ninja

# Office work
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Adobe.Acrobat.Reader.64-bit
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id TrackerSoftware.PDF-XChangeEditor
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id KDE.Okular
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id TheDocumentFoundation.LibreOffice
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Amazon.Kindle
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Grammarly.Grammarly
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id calibre.calibre

# Desktop environment extensions and tools
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Microsoft.PowerToys
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id AutoHotkey.AutoHotkey

# Messaging and videoconferencing apps
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id OpenWhisperSystems.Signal
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id WhatsApp.WhatsApp # broken
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Zoom.Zoom  # broken
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Facebook.Messenger # broken
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Spotify.Spotify # broken

# Multimedia
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id GIMP.GIMP
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id IrfanSkiljan.IrfanView
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Audacity.Audacity

# Productivity
winget install --accept-source-agreements --accept-package-agreements --silent --disable-interactivity -e --id Doist.Todoist

winget upgrade --all --accept-source-agreements --accept-package-agreements --silent --disable-interactivity

# Pip packages
# TODO some packages below need to be fixed (or just installed globally?)
# TODO install python applications with pipx
py -3 -m pip install --user pipx
py -3 -m pipx ensurepath

pipx install flawfinder # C++ linter
pipx install cpplint

# TODO try installing these packages directly via winget
pip install matplotlib
pip install mock
pip install numpy
pip install pandas
pip install pytest
pip install requests
pip install scipy # TODO broken

Set-PSDebug -Trace 0
