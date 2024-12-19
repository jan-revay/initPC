# TODO test
Set-PSDebug -Trace 1
$ErrorActionPreference = "Stop"

# TODO set to break on errors
# TODO - add gh auth login
echo $PSVersionTable.PSVersion

# Scripts requiring user input
. $PSScriptRoot/wsl_install.ps1
# WSL installation might need a restart before Linux distros can be installed TODO test it...

# Noninteractive scripts
. $PSScriptRoot/packages_install.ps1
. $PSScriptRoot/optional_packages_install.ps1
. $PSScriptRoot/configs_install.ps1
. $PSScriptRoot/source_packages_install.ps1

Set-PSDebug -Trace 0
