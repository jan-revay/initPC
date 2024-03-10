# packages I can live without...

# SOFT to try
# - terminus terminal
# - Drawboard pdf
# - photoshop resp. Adobe suite
# - davinci resolve
# - go over packages here: https://github.com/microsoft/winget-pkgs/tree/master/manifests
#   and in Windows store, add relevant.
# - ask Michal about video editing soft
# - web research
# - try installing turing off services created by the optional soft resp.
#   installing it as a separate user, so that they do not run when I don't use them.
# TODO add `--accept-source-agreements --accept-package-agreements` options as in packages_install.ps1

Set-PSDebug -Trace 1
$ErrorActionPreference = "Stop"

$WINGET_PACKAGES = @(

# Utils
    'BurntSushi.ripgrep.GNU' # TODO test
    'Microsoft.Sysinternals.ProcessMonitor'
# TODO - always install latest ?
    'Microsoft.DotNet.DesktopRuntime.6' # for GitExtensions
    'Microsoft.DotNet.DesktopRuntime.7'
    'Microsoft.DotNet.SDK.7'
    'GitExtensionsTeam.GitExtensions' # TODO this package is also in packages_install.ps1

# IDEs and code editors
    'Microsoft.VisualStudio.2022.Community'
# components need to be added to the VS manually (start menu -> Visual Studio Installer)
# TODO try adding the components via command line here
    'JetBrains.CLion'
    'JetBrains.PyCharm.Community'
    'KDE.kdevelop'
    'KDE.Kate'
    'Coq.CoqPlatform'
    'Meld.Meld'
    'Notepad++.Notepad++'
    'Postman.Postman'

# Terminal emulators
    'Mintty.WSLtty'
    'PuTTY.PuTTY'

# Office work
    'Foxit.FoxitReader'

# File management
    'GNU.MidnightCommander'

# Compilers
    'commercialhaskell.stack'
    'SWI-Prolog.SWI-Prolog'
    'Rustlang.Rustup'
    'Cygwin.Cygwin' # TODO install stuff I use such as GCC

# Multimedia
    'OBSProject.OBSStudio'
    'Canva.Canva' # broken
    '9WZDNCRFJ3TJ' # Netflix
    '9MSPC6MP8FM4' # MS Whiteboard
    'Gyan.FFmpeg'
    'Inkscape.Inkscape'
    'BlenderFoundation.Blender'

# benchmarks and stress tests
    'Maxon.CinebenchR23'
    'FinalWire.AIDA64.Engineer'
    'PrimateLabs.Geekbench.6'
    'Geeks3D.FurMark'
    'TechPowerUp.GPU-Z'
    'CrystalDewWorld.CrystalDiskMark'
    'Antutu.AntutuBenchmark'
    '9NX2VQG25JXJ' # PassMark PerformanceTest
    '9N7ZMT6X8VLN' # GFX Memory Speed Benchmark
    # TODO add PassMark burnIn test
    # TODO prime95 does not have a winget package - install manually?

# learning & reading
    'anki.anki'
)

$WINGET_PACKAGES | ForEach-Object {
    echo "### Winget is installing a package: $PSItem"
    winget install --accept-source-agreements --accept-package-agreements `
        --silent --disable-interactivity -e --id  $PSItem
    }
winget upgrade --all --accept-source-agreements --accept-package-agreements `
    --silent --disable-interactivity

# Pip packages
# TODO some of the packages bellow are broken - fix
pip install bitarray
pip install bson
pip install docutils
pip install h5py
pip install hypothesis
pip install jinja2
pip install jira
pip install log4mongo
pip install lxml
pip install Pillow
pip install pyyaml
pip install quantities
pip install scikit-image
pip install tabulate

# To consider from David
# "Logitech.SetPoint"

# Manually installed programs
# (TODO have a look on the next install, whether they are already packed for winget)
# - Cmder

Set-PSDebug -Trace 0
