Set-PSDebug -Trace 1

# TODO make the script more compact
# TODO add Set-Disk -Number 1 -IsOffline $true

# Desired HDD identifier
# $targetFriendlyName = "WDC WD102KRYZ-01A5AB0"
# $targetSerial       = "VH1JR5YM"

# # Find the physical disk matching both FriendlyName and SerialNumber
# $targetDisk = Get-PhysicalDisk | Where-Object {
#     $_.FriendlyName -eq $targetFriendlyName -and $_.SerialNumber -eq $targetSerial
# }

# if (-not $targetDisk) {
#     Write-Error "Target disk not found using FriendlyName and SerialNumber."
#     exit 1
# }

# # Map PhysicalDisk to corresponding Disk Number
# $diskNumber = (Get-Disk | Where-Object {
#     $_.UniqueId -eq $targetDisk.UniqueId
# }).Number

# if ($null -eq $diskNumber) {
#     Write-Error "Failed to match PhysicalDisk to Disk Number."
# }

# # Offline the disk
# try {
#     Set-Disk -Number $diskNumber -IsOffline $true -ErrorAction Stop
#     Write-Host "Disk $diskNumber offlined successfully."
# } catch {
#     Write-Error "Failed to offline disk $diskNumber: $_"
# }

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
# TODO figure out why longer paths do not work
& $devcon remove "*SCSI\DISK&VEN_WDC&PROD_WD102KRYZ-01A5AB\7&16843F94&0&010000*"
& $devcon remove "*PROD_WD102KRYZ-01A5AB*"
& $devcon remove "*WD102KRYZ-01A5AB0*"
pause

