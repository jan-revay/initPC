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

# Web browsers
winget install -e --id Mozilla.Firefox
winget install -e --id Google.Chrome

# Utils
winget install -e --id VMware.WorkstationPlayer # broken
winget install -e --id WinDirStat.WinDirStat

# Drivers and HW support
winget install -e --id Logitech.OptionsPlus

# Code editors
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id Neovim.Neovim

# Terminal emulators
winget install -e --id Microsoft.WindowsTerminal
winget install -e --id Maximus5.ConEmu
winget install -e --id Eugeny.Tabby

# compilers, build tools and interpreters
winget install -e --id Python.Python.3.12
winget install -e --id LLVM.LLVM
winget install -e --id JFrog.Conan
winget install -e --id Kitware.CMake
winget install -e --id Ninja-build.Ninja

# Office work
winget install -e --id Adobe.Acrobat.Reader.64-bit
winget install -e --id KDE.Okular
winget install -e --id TheDocumentFoundation.LibreOffice
winget install -e --id Amazon.Kindle
winget install -e --id Grammarly.Grammarly

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
winget install -e --id Audacity.Audacity

# Productivity
winget install -e --id Doist.Todoist

winget upgrade --all

# Pip packages
# TODO some packages bellow need to be fixed (or just installed globally?)
pip install flawfinder # C++ linter
pip install cpplint

pip install matplotlib
pip install mock
pip install numpy
pip install pandas
pip install pytest
pip install requests
pip install scipy # TODO broken
