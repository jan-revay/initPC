# TODO:
# RUN AS ADMINISTRATOR
# scaling on 4k monitor - try avoiding the fractional scaling as it causes blur sometimes
# TODO windows registry stuff
# TODO nvim config stuff
# TODO create PS and cmd aliases in WIN https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_aliases?view=powershell-7.3

../SharedConfigs/git_config.sh.ps1
../SharedConfigs/mkdirs.ps1

Copy-Item ../SharedConfigs/Profile.ps1 $PSHOME\Profile.ps1

# Manually changed settings
# Todo try to automatically set these windows settings in future
# Settings -> multitasking -> on the taskbar, show the windows that are open on all desktops
