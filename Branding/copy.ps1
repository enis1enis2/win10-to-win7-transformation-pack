#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"

if (-not (Test-Path $powerRun)) {
    Write-Error "PowerRun not found at: $powerRun"
    exit 1
}

$brandingSource = "$scriptDir\Branding"
# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }
$__bkSrc = Join-Path $__sDir "Branding"
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\Branding" -Recurse -UsePowerRun }
$copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$brandingSource' -Destination 'C:\Windows\' -Recurse -Force"

Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden

Write-Host "Branding copied to C:\Windows\Branding" -ForegroundColor Green