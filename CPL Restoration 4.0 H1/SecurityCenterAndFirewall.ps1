Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList 'reg import "Pages\Security Center and Firewall CPL\Import as TrustedInstaller\vistaFWall.reg"' -WindowStyle Hidden -Wait
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList 'reg import "Pages\Security Center and Firewall CPL\Import as TrustedInstaller\vistaSeCen.reg"' -WindowStyle Hidden -Wait

# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }
$__bkSrc = Join-Path $__sDir "Pages\Security Center and Firewall CPL\Vista Style\system32"
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\System32" -Recurse -UsePowerRun }
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Security Center and Firewall CPL\Vista Style\system32\*' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden
