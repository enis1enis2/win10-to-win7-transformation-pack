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
# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }
$__bkSrc = Join-Path $__sDir "Windows 7 Sounds"
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\Media" -Recurse -UsePowerRun }
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
