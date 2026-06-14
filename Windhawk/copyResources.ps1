# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "") | Out-Null }
#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$resourceDir = "$scriptDir\ResourceRedirect"

if (Test-Path $resourceDir) {
    Copy-Item -Path $resourceDir -Destination 'C:\Windows\' -Recurse -Force
    Write-Host "ResourceRedirect copied to C:\Windows\ResourceRedirect" -ForegroundColor Green
} else {
    Write-Warning "ResourceRedirect directory not found at: $resourceDir"
}