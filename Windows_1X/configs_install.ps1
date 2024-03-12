# TODO:
# RUN AS ADMINISTRATOR https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771525(v=ws.10)?redirectedfrom=MSDN
# scaling on 4k monitor - try avoiding the fractional scaling as it causes blur sometimes
# TODO windows registry stuff
# TODO nvim config stuff
# TODO create PS and cmd aliases in WIN https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_aliases?view=powershell-7.3

Set-PSDebug -Trace 1
$ErrorActionPreference = "Stop"

. $PSScriptRoot/../CommonInitScripts/git_config.sh.ps1
. $PSScriptRoot/../CommonInitScripts/mkdirs.ps1

# Todo consider adding this only for current user so that I don't need sudo.
# Maybe that would also be safer.
# TODO update the profile to be up to date with Bash aliases
# TODO pwsh does not use this profile for som reason -> also set it for pwsh
Copy-Item -Force $PSScriptRoot/win_dotfiles/Profile.ps1 $PSHOME/Profile.ps1

# Manually changed settings
# Todo try to automatically set these windows settings in future
# Settings -> multitasking -> on the taskbar, show the windows that are open on all desktops

# TODO - debloat Windows
# TODO optimize Windows startup times & BG processes
# TODO try running PowerShell and pwsh with the new profile here or in
# the CI tests. 

Set-PSDebug -Trace 0
