Set-PSDebug -Trace 1
$ErrorActionPreference = "Stop"

# TODO - don't go into the WSL instance (that interrupts the init script)
wsl --install --distribution Ubuntu --no-launch
# TODO - see https://github.com/microsoft/WSL/issues/3369
# TODO see https://github.com/Microsoft/WSL-distrolauncher
# TODO see https://github.com/microsoft/windows-dev-box-setup-scripts/issues/32
# TODO see https://github.com/microsoft/windows-dev-box-setup-scripts/issues/33
# TODO see https://github.com/microsoft/windows-dev-box-setup-scripts/pull/68/commits
# TODO see https://learn.microsoft.com/en-us/windows/wsl/install-on-server
# TODO see https://github.com/microsoft/windows-dev-box-setup-scripts/blob/master/scripts/WSL.ps1
# wsl -u root apt-get update
# wsl -u root apt-get full-upgrade -y
# wsl -u root apt-get autoremove -y
# wsl -u root apt-get autoclean
# wsl --shutdown  # instead of 'reboot'

wsl --install --distribution Debian --no-launch

# TODO run the WSL setup scripts here
# TODO add remaining WSL setup here (e.g. mounting of Windows FS)
# - wsl - mount windows FS there?

Set-PSDebug -Trace 0
