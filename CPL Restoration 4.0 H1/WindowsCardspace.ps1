#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
#MAKE SURE TO ENABLE .NET 3.5 FROM "WINDOWS FEATURES" BEFORE CONTINUING WITH THE RESTORATION PROCESS
#PLEASE RESTART YOUR COMPUTER AFTER ENABLING .NET 3.5

$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "reg import `"$scriptDir\Pages\Windows Cardspace CPL\Import as TrustedInstaller\cardspacePlusSVC.reg`"" -WindowStyle Hidden -Wait -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }

# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }
$__bkSrc = Join-Path $scriptDir "Pages\Windows Cardspace CPL\7 Style\system32"
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\System32" -Recurse -UsePowerRun }
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$scriptDir\Pages\Windows Cardspace CPL\7 Style\system32\*' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
$__bkSrc = Join-Path $scriptDir "Pages\Windows Cardspace CPL\7 Style\Microsoft.NET"
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\Microsoft.NET" -Recurse -UsePowerRun }
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$scriptDir\Pages\Windows Cardspace CPL\7 Style\Microsoft.NET\*' -Destination 'C:\Windows\Microsoft.NET' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }

Write-Warning "A system restart is required to enable the Windows Cardspace service. Please restart your computer and then run this script again to complete the installation."
Set-Service 'idsvc' -StartupType Automatic