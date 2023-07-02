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

# Utils
winget install -e --id BurntSushi.ripgrep.GNU # TODO test
winget install -e --id Microsoft.Sysinternals.ProcessMonitor

# IDEs and code editors
winget install -e --id Microsoft.VisualStudio.2022.Community
# components need to be added to the VS manually (start menu -> Visual Studio Installer)
# TODO try adding the components via command line here
winget install -e --id JetBrains.CLion
winget install -e --id JetBrains.PyCharm.Community
winget install -e --id KDE.kdevelop
winget install -e --id KDE.Kate
winget install -e --id Coq.CoqPlatform
winget install -e --id Meld.Meld
winget install -e --id Notepad++.Notepad++
winget install -e --id Postman.Postman

# Terminal emulators
winget install -e --id Mintty.WSLtty
winget install -e --id PuTTY.PuTTY

# File management
winget install -e --id GNU.MidnightCommander

# Compilers
winget install -e --id commercialhaskell.stack
winget install -e --id SWI-Prolog.SWI-Prolog
winget install -e --id Rustlang.Rustup
winget install -e --id Cygwin.Cygwin # TODO install stuff I use such as GCC

# Multimedia
winget install -e --id OBSProject.OBSStudio
winget install -e --id Canva.Canva # broken
winget install -e --id 9WZDNCRFJ3TJ # Netflix
winget install -e --id 9MSPC6MP8FM4 # MS Whiteboard
winget install -e --id Gyan.FFmpeg
winget install -e --id Inkscape.Inkscape
winget install -e --id BlenderFoundation.Blender

winget upgrade --all

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
# TrackerSoftware.PDF-XChangeEditor
# GitExtensionsTeam.GitExtensions

# Manually installed programs
# (TODO have a look on the next install, whether they are already packed for winget)
# - Cmder