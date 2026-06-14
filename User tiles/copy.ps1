#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"
$destDir = "C:\ProgramData\Microsoft\User Account Pictures\Default Pictures"

# === Backup existing files before modification ===
$__bkMod = Join-Path $scriptDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $scriptDir "..\Backup") | Out-Null }

if (-not (Test-Path $powerRun)) {
    Write-Error "PowerRun not found at: $powerRun"
    exit 1
}

$mkdirCmd = "powershell -ExecutionPolicy Bypass -Command New-Item -Name 'Default Pictures' -Path 'C:\ProgramData\Microsoft\User Account Pictures\' -ItemType 'Directory' -Force"
Start-Process $powerRun -ArgumentList $mkdirCmd -Wait -WindowStyle Hidden

# Backup destination before overwriting
Backup-BeforeCopy -Source "$scriptDir" -Destination "$destDir" -Recurse -UsePowerRun

$copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$scriptDir\*' -Destination '$destDir\' -Recurse -Force"
Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden

$cleanCmd = "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path '$destDir\copy.ps1' -Force"
Start-Process $powerRun -ArgumentList $cleanCmd -Wait -WindowStyle Hidden

Write-Host "User tiles copied to $destDir" -ForegroundColor Green