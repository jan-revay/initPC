# TODO test
Set-PSDebug -Trace 1

. $PSScriptRoot/packages_install.ps1
# ./packages__install_optional.ps1
. $PSScriptRoot/wsl_install.ps1
. $PSScriptRoot/configs_install.ps1

Set-PSDebug -Trace 0
