#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
$escapedScriptDir = $scriptDir.Replace("'", "''")
# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }
Backup-File -Path "C:\Windows\System32\intl.cpl" -UsePowerRun
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedScriptDir\Pages\Region and Input CPL\7 Style\intl.cpl' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
Backup-File -Path "C:\Windows\System32\input.dll" -UsePowerRun
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedScriptDir\Pages\Region and Input CPL\7 Style\7nput.dll' -Destination 'C:\Windows\System32\input.dll' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
Backup-File -Path "C:\Windows\System32\en-US\intl.cpl.mui" -UsePowerRun
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedScriptDir\Pages\Region and Input CPL\7 Style\en-US\intl.cpl.mui' -Destination 'C:\Windows\System32\en-US\' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
Backup-File -Path "C:\Windows\System32\en-US\input.dll.mui" -UsePowerRun
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedScriptDir\Pages\Region and Input CPL\7 Style\en-US\7nput.dll.mui' -Destination 'C:\Windows\System32\en-US\' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
