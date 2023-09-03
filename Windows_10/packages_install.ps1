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

Set-PSDebug -Trace 1

# Web browsers
winget install -e --id Mozilla.Firefox
winget install -e --id Google.Chrome

# Utils
winget install -e --id VMware.WorkstationPlayer # broken
winget install -e --id WinDirStat.WinDirStat
winget install -e --id Docker.DockerDesktop
winget install -e --id XAMPPRocky.tokei # broken?
winget install -e --id 7zip.7zip
winget install -e --id Ookla.Speedtest.Desktop
winget install -e --id Microsoft.MouseandKeyboardCenter

# Version controll
winget install -e --id GitHub.cli
winget install -e --id Git.Git
winget install -e --id GitHub.GitHubDesktop
winget install -e --id GitExtensionsTeam.GitExtensions
winget install -e --id o2sh.onefetch

# Drivers and HW support
winget install -e --id Logitech.OptionsPlus

# Code editors
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id Neovim.Neovim
winget install -e --id Helix.Helix

# Terminal emulators
winget install -e --id Microsoft.WindowsTerminal
winget install -e --id Maximus5.ConEmu
winget install -e --id Eugeny.Tabby
winget install -e --id Alacritty.Alacritty

# compilers, build tools and interpreters
winget install -e --id Python.Python.3.12
winget install -e --id LLVM.LLVM
winget install -e --id JFrog.Conan
winget install -e --id Kitware.CMake
winget install -e --id Ninja-build.Ninja

# Office work
winget install -e --id Adobe.Acrobat.Reader.64-bit
winget install -e --id TrackerSoftware.PDF-XChangeEditor
winget install -e --id KDE.Okular
winget install -e --id TheDocumentFoundation.LibreOffice
winget install -e --id Amazon.Kindle
winget install -e --id Grammarly.Grammarly
winget install -e --id calibre.calibre

# Desktop environment extensions and tools
winget install -e --id Microsoft.PowerToys
winget install -e --id AutoHotkey.AutoHotkey

# Messaging and videoconferencing apps
winget install -e --id OpenWhisperSystems.Signal
winget install -e --id WhatsApp.WhatsApp # broken
winget install -e --id Zoom.Zoom  # broken
winget install -e --id Facebook.Messenger # broken
winget install -e --id Spotify.Spotify # broken

# Multimedia
winget install -e --id GIMP.GIMP
winget install -e --id IrfanSkiljan.IrfanView
winget install -e --id Audacity.Audacity

# Productivity
winget install -e --id Doist.Todoist

winget upgrade --all

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
