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
# TODO add relevant packages from the package list here: <https://github.com/xsukax/xwgg/blob/main/index.html>
# TODO - make the install script list packages which failed to install (currently it just prints error codes in red to stdout)
# is not present in winget via choco

Set-PSDebug -Trace 1
$ErrorActionPreference = "Stop"

# Install Scoop
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
    # TODO an attempt to reload the path (investigate further)
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}
scoop bucket add extras
# TODO uncomment the next line resp. fix it so that it works and (scoop is not found right after the installation, probably path problem)
scoop install windows-virtualdesktop-helper

# TODO - go over this list https://github.com/ChrisTitusTech/winutil/blob/main/config/applications.json and add useful apps
# TODO add linux versions of the useful apps to linux initPC script

$WINGET_PACKAGES = @(
# HW monitoring
    'CPUID.CPU-Z'
    'CPUID.HWMonitor'

# Drivers and HW support
    'Logitech.OptionsPlus'

# Runtimes
    'Microsoft.DotNet.DesktopRuntime.6' # for GitExtensions
    'Microsoft.DotNet.DesktopRuntime.7'
    'Microsoft.VCRedist.2015+.x64'
    'RubyInstallerTeam.RubyWithDevKit.3.2'
    'Microsoft.PowerShell'

# Virtualisation and containers
    'Docker.DockerDesktop'
    'VMware.WorkstationPlayer' # broken
    # TODO? add WSL installation here?

# Utils & TOSORT TODO - sort to cathegories
    '7zip.7zip'
    'Gyan.FFmpeg'
    # TODO WizTree does what WinDirStat does but better and quicker, consider commenting WinDirStat out
    'WinDirStat.WinDirStat'
    'AntibodySoftware.WizTree'
    'XAMPPRocky.tokei' # broken? TODO FIX?
    'Ookla.Speedtest.Desktop'
    'fzf'
    'AlDanial.Cloc' # count number of lines of code
    'starship.starship'
    'pCloudAG.pCloudDrive'
    'Anki.Anki'
    'Hex-Rays.IDA.Free'
    'Qalculate'
    'Joplin'
    'Geany.Geany'
    'PuTTY.PuTTY'
    'DBBrowserForSQLite.DBBrowserForSQLite'
    'voidtools.Everything'
    'Oracle.VirtualBox'
    'Google.EarthPro'
    'CodeSector.TeraCopy'
    'Gyan.FFmpeg'
    'NirSoft.OpenedFilesView'
    'NirSoft.InsideClipboard'
    'Google.GoogleDrive'
    'qBittorrent.qBittorrent'
    'dotPDN.PaintDotNet'
    'Inkscape.Inkscape'
    'Audacity.Audacity'
    'KDE.Kdenlive'
    'Microsoft.Sysinternals.Autoruns'
    'Rufus.Rufus'

# Desktop environment & window management extensions
    'AltSnap.AltSnap' # https://github.com/RamonUnch/AltSnap/wiki (TODO read)
    # TODO implement matching behaviour in Win and Linux (same keyboard shortcuts
    # and same possibilities)
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
    'WerWolv.ImHex'
    'RKibria.frhed'

# Terminal emulators
    'Alacritty.Alacritty'
    'Microsoft.WindowsTerminal'
    'wez.wezterm'

# compilers, build tools and interpreters
    'Python.Python.3.13' # Try always installing the latest Python package instead of fixing the version
    'Kitware.CMake'
    'LLVM.LLVM'
    'Rustlang.Rustup'
    'JFrog.Conan'
    'Ninja-build.Ninja'
    'Microsoft.VisualStudio.2022.BuildTools'
    'Cppcheck.Cppcheck'
    'Microsoft.WinDbg'

# Web browsers
    'Google.Chrome'
    'Mozilla.Firefox'

# Office work & document readers & books
    'Adobe.Acrobat.Reader.64-bit'
    'TrackerSoftware.PDF-XChangeEditor'
    'SumatraPDF.SumatraPDF'
    'KDE.Okular'
    'TheDocumentFoundation.LibreOffice'
    'Amazon.Kindle'
    'Grammarly.Grammarly'
    'calibre.calibre'

# Messaging and videoconferencing apps
    'Zoom.Zoom'  # broken TODO FIX?
    '9NKSQGP7F2NH' # WhatsApp, the winget package is broken
    'OpenWhisperSystems.Signal'
    'Facebook.Messenger' # broken? TODO FIX? TODO maybe replace with Chrome PWA
    'Discord.Discord'

# Multimedia
    '9NCBCSZSJRSB' # Spotify, the winget package is broken
    'GIMP.GIMP'
    'IrfanSkiljan.IrfanView'
    'Audacity.Audacity'
    'VideoLAN.VLC'

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
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" `
    + [System.Environment]::GetEnvironmentVariable("Path","User")

python -m pip install --upgrade pip
py -3 -m pip install --user pipx
py -3 -m pipx ensurepath

# refresh Path variable
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" `
    + [System.Environment]::GetEnvironmentVariable("Path","User")

# C++ linters
pipx install flawfinder
pipx install cpplint

# TODO try installing these packages directly via winget
pip install matplotlib
pip install mock
pip install numpy
pip install pandas
pip install pytest
pip install requests
pip install scipy # TODO broken
pip install statsmodels # TODO broken
pip install seaborn # TODO broken
pip install scikit-learn
pip install shap

# TODO an attempt to reload the path (investigate further)
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" `
    + [System.Environment]::GetEnvironmentVariable("Path","User")

# TODO uncomment and fix the next line
# gem install github-linguist

# TODO - investigate more and integrate: https://github.com/MScholtes/VirtualDesktop
# Install-Module -Name VirtualDesktop

## INSTALL RAW .EXE PACKAGES

# TODO solve updates, automatic config import (probably in C:\Program Files\Pentablet\config, diff the file
# with my saved config), maybe just check for the updates manually or find a link that always has the latest version
if (-not (Test-Path "C:\Program Files\Pentablet")) {
    $downloadUrl = "https://www.xp-pen.com/download/file.html?id=2866&pid=51&ext=zip"
    $zipPath = "$env:TEMP\xppen_driver.zip"
    $extractPath = "$env:TEMP\xppen_driver"
    
    # Create the extract path if it doesn't exist
    if (-Not (Test-Path -Path $extractPath)) {
        New-Item -ItemType Directory -Path $extractPath | Out-Null
    }
    
    # Download the ZIP file
    Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath

    # Unzip the file
    Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
    
    # Find the .exe installer (assumes there's only one .exe inside the ZIP)
    $exeFile = Get-ChildItem -Path $extractPath -Filter *.exe -Recurse | Select-Object -First 1
    
    # Check if the EXE was found
    if ($exeFile) {
        Start-Process -FilePath $exeFile.FullName -ArgumentList '/VERYSILENT', '/SUPPRESSMSGBOXES', '/NORESTART', '/SP-' -Wait
    } else {
        Write-Host "No executable installer found in the extracted files."
    }
}

Set-PSDebug -Trace 0
