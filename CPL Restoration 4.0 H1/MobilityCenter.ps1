#requires -RunAsAdministrator

# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "") | Out-Null }
Backup-File -Path "C:\Windows\System32\batmete7.dll" -UsePowerRun
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Mobility Center CPL\7 Style\system32\batmete7.dll' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden
Backup-File -Path "C:\Windows\System32\mblctr.exe" -UsePowerRun
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Mobility Center CPL\7 Style\system32\mblctr.exe' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden
$__bkSrc = Join-Path $__sDir "Pages\Mobility Center CPL\7 Style\system32\en-US"
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\System32\en-US" -Recurse -UsePowerRun }
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Mobility Center CPL\7 Style\system32\en-US\*' -Destination 'C:\Windows\System32\en-US' -Recurse -Force" -Wait -WindowStyle Hidden
