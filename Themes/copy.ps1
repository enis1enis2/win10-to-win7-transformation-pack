#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"

if (-not (Test-Path $powerRun)) {
    Write-Error "PowerRun not found at: $powerRun"
    exit 1
}

# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }
$__bkSrc = $scriptDir
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\Resources\Themes" -Recurse -UsePowerRun }
$copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$scriptDir\*' -Destination 'C:\Windows\Resources\Themes\' -Recurse -Force"
$cleanCmd = "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path 'C:\Windows\Resources\Themes\copy.ps1' -Force"

Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden
Start-Process $powerRun -ArgumentList $cleanCmd -Wait -WindowStyle Hidden

Write-Host "Themes copied to C:\Windows\Resources\Themes" -ForegroundColor Green