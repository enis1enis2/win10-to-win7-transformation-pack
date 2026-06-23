#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"

if (-not (Test-Path $powerRun)) {
    Write-Error "PowerRun not found at: $powerRun"
    return
}

$brandingSource = "$scriptDir\Branding"
# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) {
    . $__bkMod
    Initialize-Backup | Out-Null
    Backup-BeforeCopy -Source $brandingSource -Destination "C:\Windows\Branding" -Recurse -UsePowerRun
}

$copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$brandingSource' -Destination 'C:\Windows\' -Recurse -Force"
$p = Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden -PassThru
if ($p.ExitCode -ne 0) { throw "Branding copy failed with exit code $($p.ExitCode)" }

Write-Host "Branding copied to C:\Windows\Branding" -ForegroundColor Green
