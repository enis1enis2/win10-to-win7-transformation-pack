# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }
$__bkSrc = Join-Path $__sDir "Pages\Recovery CPL\7 Style\system32"
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\System32" -Recurse -UsePowerRun }
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Recovery CPL\7 Style\system32\*' -Destination 'C:\Windows\System32\' -Recurse -Force" -Wait -WindowStyle Hidden
