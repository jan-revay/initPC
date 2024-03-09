# TODO test
Set-PSDebug -Trace 1
$ErrorActionPreference = "Stop"

# TODO set to break on errors
#TODO - add gh auth login

# Scripts requiring user input
. $PSScriptRoot/wsl_install.ps1

# Noninteractive scripts
. $PSScriptRoot/packages_install.ps1
# ./optional_packages__install.ps1
. $PSScriptRoot/configs_install.ps1
. $PSScriptRoot/source_packages_install.ps1

Set-PSDebug -Trace 0
