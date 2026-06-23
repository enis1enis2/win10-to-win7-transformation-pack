#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
$escapedScriptDir = $scriptDir.Replace("'", "''")

Set-Location -Path (Split-Path -Parent $PSCommandPath)

$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"
$pageDir = "$scriptDir\Pages\Network Map CPL"

# Copy network map DLLs to System32
# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }
$__bkSrc = Join-Path $scriptDir "Pages\Network Map CPL\7 Style\system32"
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\System32" -Recurse -UsePowerRun }
$p = Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$pageDir\7 Style\system32\*' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }

# Import netmap.reg (CLSID registration for Network Map)
$p = Start-Process $powerRun -ArgumentList "reg import `"$pageDir\7 Style\import as TI\netmap.reg`"" -WindowStyle Hidden -Wait -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }

# Import LLTDIO.reg (enable LLTDIO driver for network discovery)
$p = Start-Process $powerRun -ArgumentList "reg import `"$pageDir\7 Style\import as TI\LLTDIO.reg`"" -WindowStyle Hidden -Wait -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }

Write-Host ""
Write-Host "Network Map CPL installed." -ForegroundColor Green
