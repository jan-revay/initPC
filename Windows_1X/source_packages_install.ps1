# THIS SCRIPT MUST BE RUN AS ADMINISTRATOR

Set-PSDebug -Trace 1
$ErrorActionPreference = "Stop"

# Virtual desktop scroll

pushd ~/x
git clone https://github.com/sean-nicholas/scroll-windows-v-desktops.git
popd

pushd ~/x/scroll-windows-v-desktops
pip install -r requirements.txt
pyinstaller --onefile scroll-desktops.py
# TODO - it would probably be better to do this via Autohotkey (see my todoist section "virtual desktops" for examples
# TODO try adapting this position so that it works well on Win11 i.e. taskbar on the bottom
# Having the desktop scrolling area up is buggy because of the focus on hover (the cursor will move to the focused window
# and break the flow when scrolling.
$config = @"
{
    "xMin": -1,
    "xMax": 10000,
    "yMin": 2090,
    "yMax": 10000,
    "printPosition": false
}
"@

echo $config | Out-File -Encoding ASCII -FilePath ./dist/config.json

( $res = Get-ScheduledTask "Taskbar_scroll" -ErrorAction SilentlyContinue ) 2> $null
if ($null -eq $res) {
    $exe_dir = "$PWD\dist"
    $action = New-ScheduledTaskAction -Execute "$exe_dir\scroll-desktops.exe" `
        -Argument "--nowindowed --noconsole" `
        -WorkingDirectory "$exe_dir"
    $trigger = New-ScheduledTaskTrigger -AtLogOn

    Register-ScheduledTask -TaskName 'Taskbar_scroll' `
        -Action $action -Trigger $trigger -RunLevel Highest
}

popd


( $res = Get-ScheduledTask "AltSnap" -ErrorAction SilentlyContinue ) 2> $null
if ($null -eq $res) {
    $exe_dir = "C:\Users\janci\AppData\Roaming\AltSnap"
    $action = New-ScheduledTaskAction -Execute "$exe_dir\AltSnap.exe" `
        -WorkingDirectory "$exe_dir"
    $trigger = New-ScheduledTaskTrigger -AtLogOn

    Register-ScheduledTask -TaskName 'AltSnap' `
        -Action $action -Trigger $trigger -RunLevel Highest
}

# TODO - turn off startup programs and services that I do not use

Set-PSDebug -Trace 0
