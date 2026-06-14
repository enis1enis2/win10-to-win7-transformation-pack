#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$powerRun = "$scriptDir\PowerRun\PowerRun_x64.exe"

if (Test-Path $powerRun) {
    Start-Process $powerRun -ArgumentList 'reg import "Pages\Default Programs CPL\import as TrustedInstaller\defaultprograms.reg"' -WindowStyle Hidden -Wait
} else {
    Write-Host "PowerRun not found, importing registry directly..." -ForegroundColor Yellow
    reg import "$scriptDir\Pages\Default Programs CPL\import as TrustedInstaller\defaultprograms.reg"
}
