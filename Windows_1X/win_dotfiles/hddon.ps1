Set-PSDebug -Trace 1
# & is used to execute a command string with spaces

cd "C:\Users\jr\initPC\Windows_1X\win_dotfiles"
Start-Transcript -Path "hddonOutput.log" -Append

$expectedModel = "WDC WD102KRYZ-01A5AB0"
$expectedSerial = "VH1JR5YM"
$hdparm = "C:\Program Files (x86)\hdparm\hdparm.exe"
$devcon = "C:\Program Files (x86)\Windows Kits\10\Tools\10.0.26100.0\x64\devcon.exe"

& $devcon rescan
& $devcon enable "*WD102KRYZ-01A5AB0*"

foreach ($dev in 'sda','sdb','sdc','sdd','sde','sdf','sdg','sdh') {
    $output = & $hdparm -I $dev 2>&1
    if ($LASTEXITCODE -ne 0) { continue }

    $model = ($output | Select-String "Model Number:" | ForEach-Object { $_.ToString().Split(":")[1].Trim() })
    $serial = ($output | Select-String "Serial Number:" | ForEach-Object { $_.ToString().Split(":")[1].Trim() })

    if ($model -eq $expectedModel -and $serial -eq $expectedSerial) {
        Write-Host "✅ Found target drive: $dev ($model, $serial)"
        Write-Host "✅ Setting -S to 2: $dev ($model, $serial)"
        # Continue your script here
	& $hdparm -S 2 $dev
        break
    }
}

if ($model -ne $expectedModel -or $serial -ne $expectedSerial) {
    Write-Warning "❌ Target drive not found."
}
