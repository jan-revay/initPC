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
# TODO other relevant drivers (maybe to a separate file...)
# TODO add useful packages from here: https://github.com/actions/runner-images/blob/main/images/win/Windows2022-Readme.md
# TODO add `--silent` and `--disable-interactivity` options to `winget install` commands? https://learn.microsoft.com/en-us/windows/package-manager/winget/install
# TODO install broken winget packages from msstore if possible
# TODO move some packages from here to optional and the most used optional packages here
# TODO make the script break if a single package installation fails (I think that currently the script continues in that case)
# TODO some packages fail to install - mark them and find an alternative way
# TODO add choco package managers and install stuff that fails or
# is not present in winget via choco

Set-PSDebug -Trace 1
$ErrorActionPreference = "Stop"

$WINGET_PACKAGES = @(
# HW monitoring
    'CPUID.CPU-Z'
    'CPUID.HWMonitor'

# Drivers and HW support
    'Logitech.OptionsPlus'

# Runtimes
    'Microsoft.DotNet.DesktopRuntime.6' # for GitExtensions
    'Microsoft.DotNet.DesktopRuntime.7'

# Virtualisation and containers
    'Docker.DockerDesktop'
    'VMware.WorkstationPlayer' # broken
    # TODO? add WSL installation here?

# Utils
    '7zip.7zip'
    'Gyan.FFmpeg'
    'WinDirStat.WinDirStat'
    'XAMPPRocky.tokei' # broken? TODO FIX?
    'Ookla.Speedtest.Desktop'

# Desktop environment & window management extensions
    'AltSnap.AltSnap'
    'Microsoft.PowerToys'
    'AutoHotkey.AutoHotkey'
    # TODO add relevant sysinternals packages (see `winget search sysinternals`)

# Version control
    'Git.Git'
    'GitHub.cli'
    'GitHub.GitHubDesktop'
    'GitExtensionsTeam.GitExtensions'
    'o2sh.onefetch'

# Code editors
    'Microsoft.VisualStudioCode'
    'Neovim.Neovim'
    'Helix.Helix'
    'Notepad++.Notepad++'

# Terminal emulators
    'Alacritty.Alacritty'
    'Microsoft.WindowsTerminal'

# compilers, build tools and interpreters
    'Python.Python.3.12' # Try always installing the latest Python package instead of fixing the version
    'Kitware.CMake'
    'LLVM.LLVM'
    'Rustlang.Rustup'
    'JFrog.Conan'
    'Ninja-build.Ninja'

# Web browsers
    'Google.Chrome'
    'Mozilla.Firefox'

# Office work & document readers & books
    'Adobe.Acrobat.Reader.64-bit'
    'TrackerSoftware.PDF-XChangeEditor'
    'KDE.Okular'
    'TheDocumentFoundation.LibreOffice'
    'Amazon.Kindle'
    'Grammarly.Grammarly'
    'calibre.calibre'

# Messaging and videoconferencing apps
    'Zoom.Zoom'  # broken TODO FIX?
    '9NKSQGP7F2NH' # WhatsApp, the winget package is broken
    'OpenWhisperSystems.Signal'
    'Facebook.Messenger' # broken? TODO FIX?

# Multimedia
    '9NCBCSZSJRSB' # Spotify, the winget package is broken
    'GIMP.GIMP'
    'IrfanSkiljan.IrfanView'
    'Audacity.Audacity'

# Productivity
    'Doist.Todoist'
)

$WINGET_PACKAGES | ForEach-Object {
    echo "### Winget is installing a package: $PSItem"
    winget install --accept-source-agreements --accept-package-agreements `
        --silent --disable-interactivity -e --id  $PSItem
    }
winget upgrade --all --accept-source-agreements --accept-package-agreements `
    --silent --disable-interactivity

# Pip packages
# TODO some packages below need to be fixed (or just installed globally?)
# TODO install python applications with pipx
# refresh Path variable
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
py -3 -m pip install --user pipx
py -3 -m pipx ensurepath

# refresh Path variable
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
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
