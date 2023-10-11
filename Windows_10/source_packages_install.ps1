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
$config = @"
{
    "xMin": -1,
    "xMax": 10000,
    "yMin": -1,
    "yMax": 45,
    "printPosition": false
}
"@

echo $config | Out-File -Encoding ASCII -FilePath ./dist/config.json

( $res = Get-ScheduledTask "Taskbar_scroll" -ErrorAction SilentlyContinue ) 2> $null
if ($res -eq $null) {
    $exe_dir = "$PWD\dist"
    $action = New-ScheduledTaskAction -Execute "$exe_dir\scroll-desktops.exe" `
        -Argument "--nowindowed --noconsole" `
        -WorkingDirectory "$exe_dir"
    $trigger = New-ScheduledTaskTrigger -AtLogOn

    Register-ScheduledTask -TaskName 'Taskbar_scroll' `
        -Action $action -Trigger $trigger -RunLevel Highest
}

popd

Set-PSDebug -Trace 0
