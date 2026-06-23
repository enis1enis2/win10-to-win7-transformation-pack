#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$escapedScriptDir = $scriptDir.Replace("'", "''")
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"
$regFile = Join-Path $scriptDir "Pages\Default Programs CPL\Import as TrustedInstaller\FixDeadLinks.reg"

if (Test-Path $powerRun) {
    $p = Start-Process $powerRun -ArgumentList "reg import `"$regFile`"" -WindowStyle Hidden -Wait -PassThru
    if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
} else {
    Write-Host "PowerRun not found, importing registry directly..." -ForegroundColor Yellow
    reg import "$regFile"
}
