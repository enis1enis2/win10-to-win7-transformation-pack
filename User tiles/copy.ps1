#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"
$destDir = "C:\ProgramData\Microsoft\User Account Pictures\Default Pictures"

if (-not (Test-Path $powerRun)) {
    Write-Error "PowerRun not found at: $powerRun"
    exit 1
}

$mkdirCmd = "powershell -ExecutionPolicy Bypass -Command New-Item -Name 'Default Pictures' -Path 'C:\ProgramData\Microsoft\User Account Pictures\' -ItemType 'Directory' -Force"
Start-Process $powerRun -ArgumentList $mkdirCmd -Wait -WindowStyle Hidden

$copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$scriptDir\*' -Destination '$destDir\' -Recurse -Force"
Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden

$cleanCmd = "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path '$destDir\copy.ps1' -Force"
Start-Process $powerRun -ArgumentList $cleanCmd -Wait -WindowStyle Hidden

Write-Host "User tiles copied to $destDir" -ForegroundColor Green