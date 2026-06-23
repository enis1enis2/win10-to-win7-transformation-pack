#MAKE SURE TO ENABLE .NET 3.5 FROM "WINDOWS FEATURES" BEFORE CONTINUING WITH THE RESTORATION PROCESS
#PLEASE RESTART YOUR COMPUTER AFTER ENABLING .NET 3.5

Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList 'reg import "Pages\Windows Cardspace CPL\Import as TrustedInstaller\cardspacePlusSVC.reg"' -WindowStyle Hidden -Wait

# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }
$__bkSrc = Join-Path $__sDir "Pages\Windows Cardspace CPL\7 Style\system32"
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\System32" -Recurse -UsePowerRun }
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Windows Cardspace CPL\7 Style\system32\*' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden
$__bkSrc = Join-Path $__sDir "Pages\Windows Cardspace CPL\7 Style\Microsoft.NET"
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\Microsoft.NET" -Recurse -UsePowerRun }
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Windows Cardspace CPL\7 Style\Microsoft.NET\*' -Destination 'C:\Windows\Microsoft.NET' -Recurse -Force" -Wait -WindowStyle Hidden

Write-Warning "A system restart is required to enable the Windows Cardspace service. Please restart your computer and then run this script again to complete the installation."
Set-Service 'idsvc' -StartupType Automatic