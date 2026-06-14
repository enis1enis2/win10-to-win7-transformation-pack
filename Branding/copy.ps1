#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"

if (-not (Test-Path $powerRun)) {
    Write-Error "PowerRun not found at: $powerRun"
    exit 1
}

$brandingSource = "$scriptDir\Branding"
$copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$brandingSource' -Destination 'C:\Windows\' -Recurse -Force"

Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden

Write-Host "Branding copied to C:\Windows\Branding" -ForegroundColor Green