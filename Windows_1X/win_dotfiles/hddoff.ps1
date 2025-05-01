Set-PSDebug -Trace 1

cd "C:\Users\jr\initPC\Windows_1X\win_dotfiles"
Start-Transcript -Path "hddoffOutput.log" -Append

$expectedModel = "WDC WD102KRYZ-01A5AB0"
$expectedSerial = "VH1JR5YM"
$hdparm = "C:\Program Files (x86)\hdparm\hdparm.exe"
$devcon = "C:\Program Files (x86)\Windows Kits\10\Tools\10.0.26100.0\x64\devcon.exe"
foreach ($dev in 'sda','sdb','sdc','sdd','sde','sdf','sdg','sdh') {
    $output = & $hdparm -I $dev 2>&1
    if ($LASTEXITCODE -ne 0) { continue }

    $model = ($output | Select-String "Model Number:" | ForEach-Object { $_.ToString().Split(":")[1].Trim() })
    $serial = ($output | Select-String "Serial Number:" | ForEach-Object { $_.ToString().Split(":")[1].Trim() })

    if ($model -eq $expectedModel -and $serial -eq $expectedSerial) {
        Write-Host "✅ Found target drive: $dev ($model, $serial)"
        Write-Host "✅ Putting the device: $dev ($model, $serial) to sleep"
        # Continue your script here
	& $hdparm -Y $dev
        break
    }
}

if ($model -ne $expectedModel -or $serial -ne $expectedSerial) {
    Write-Warning "❌ Target drive not found."
}

# & is used to execute a command string with spaces
& $devcon disable "*WD102KRYZ-01A5AB0*"
pause

