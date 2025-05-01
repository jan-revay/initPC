Set-PSDebug -Trace 1

# & is used to execute command string with spaces
& "C:\Program Files (x86)\hdparm\hdparm.exe" -Y hda
& "C:\Program Files (x86)\Windows Kits\10\Tools\10.0.26100.0\x64\devcon.exe" disable "*WD102KRYZ-01A5AB0*"

