#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"

if (-not (Test-Path $powerRun)) {
    Write-Error "PowerRun not found at: $powerRun"
    exit 1
}

$soundsSource = "$scriptDir\Windows 7 Sounds"
$regFile = "$scriptDir\Windows 7 Sounds Settings.reg"

if (Test-Path $soundsSource) {
    $copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$soundsSource\*' -Destination 'C:\Windows\Media' -Recurse -Force"
    Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden
    Write-Host "Sound files copied to C:\Windows\Media" -ForegroundColor Green
} else {
    Write-Warning "Windows 7 Sounds folder not found at: $soundsSource"
}

if (Test-Path $regFile) {
    Start-Process $powerRun -ArgumentList "reg import `"$regFile`"" -WindowStyle Hidden -Wait
    Write-Host "Windows 7 sound scheme applied" -ForegroundColor Green
} else {
    Write-Warning "Registry file not found at: $regFile"
}
