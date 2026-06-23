#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"

$cplSource = "$scriptDir\Control Panel Links\Universal\7 Style\system32"
$cplBat = "$scriptDir\Control Panel Links\Universal\7 Style\Run as TrustedInstaller\cpl7.bat"

# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }
$__bkSrc = Join-Path $__sDir "Control Panel Links\Universal\7 Style\system32"
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\System32" -Recurse -UsePowerRun }
$copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$cplSource\*' -Destination 'C:\Windows\System32\' -Recurse -Force"
$p = Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }

Start-Process $powerRun -ArgumentList $cplBat