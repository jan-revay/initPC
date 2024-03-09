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

$WINGET_PACKAGES = @(
    # Web browsers
    'Mozilla.Firefox'
    'Google.Chrome'

# Utils
    'VMware.WorkstationPlayer' # broken
    'WinDirStat.WinDirStat'
    'Docker.DockerDesktop'
    'XAMPPRocky.tokei' # broken?
    '7zip.7zip'
    'Ookla.Speedtest.Desktop'
    'AltSnap.AltSnap'
    'CPUID.HWMonitor'
    'CPUID.CPU-Z'
# TODO add relevant sysinternals packages (see `winget search sysinternals`)


# Version controll
    'GitHub.cli'
    'Git.Git'
    'GitHub.GitHubDesktop'
    'GitExtensionsTeam.GitExtensions'
    'o2sh.onefetch'

# Drivers and HW support
    'Logitech.OptionsPlus'

# Code editors
    'Microsoft.VisualStudioCode'
    'Neovim.Neovim'
    'Helix.Helix'

# Terminal emulators
    'Microsoft.WindowsTerminal'
    'Maximus5.ConEmu'
    'Eugeny.Tabby'
    'Alacritty.Alacritty'

# compilers, build tools and interpreters
    'Python.Python.3.12'
    'LLVM.LLVM'
    'JFrog.Conan'
    'Kitware.CMake'
    'Ninja-build.Ninja'

# Office work
    'Adobe.Acrobat.Reader.64-bit'
    'TrackerSoftware.PDF-XChangeEditor'
    'KDE.Okular'
    'TheDocumentFoundation.LibreOffice'
    'Amazon.Kindle'
    'Grammarly.Grammarly'
    'calibre.calibre'

# Desktop environment extensions and tools
    'Microsoft.PowerToys'
    'AutoHotkey.AutoHotkey'

# Messaging and videoconferencing apps
    'OpenWhisperSystems.Signal'
     # WhatsApp should be installed from msstore, the winget package is broken
    '9NKSQGP7F2NH' # WhatsApp
    'Zoom.Zoom'  # broken
    'Facebook.Messenger' # broken
    '9NCBCSZSJRSB' # Spotify, the winget package is broken broken

# Multimedia
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
