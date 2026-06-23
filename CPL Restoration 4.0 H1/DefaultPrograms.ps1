#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"
$regFile = Join-Path $scriptDir "Pages\Default Programs CPL\import as TrustedInstaller\defaultprograms.reg"

if (Test-Path $powerRun) {
    Start-Process $powerRun -ArgumentList "reg import `"$regFile`"" -WindowStyle Hidden -Wait
} else {
    Write-Host "PowerRun not found, importing registry directly..." -ForegroundColor Yellow
    reg import "$regFile"
}
