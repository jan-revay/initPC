Set-PSDebug -Trace 1

# TODO - don't go into the WSL instance (that interrupts the init script)
wsl --install --distribution Ubuntu

# TODO run the WSL setup scripts here
# TODO add remaining WSL setup here (e.g. mounting of Windows FS)
# - wsl - mount windows FS there?

Set-PSDebug -Trace 0
