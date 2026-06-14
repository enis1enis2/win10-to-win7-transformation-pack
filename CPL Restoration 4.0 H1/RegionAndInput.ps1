# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "") | Out-Null }
Backup-File -Path "C:\Windows\System32\intl.cpl" -UsePowerRun
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Region and Input CPL\7 Style\intl.cpl' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden
Backup-File -Path "C:\Windows\System32\input.dll" -UsePowerRun
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Region and Input CPL\7 Style\7nput.dll' -Destination 'C:\Windows\System32\input.dll' -Recurse -Force" -Wait -WindowStyle Hidden
Backup-File -Path "C:\Windows\System32\en-US\intl.cpl.mui" -UsePowerRun
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Region and Input CPL\7 Style\en-US\intl.cpl.mui' -Destination 'C:\Windows\System32\en-US\' -Recurse -Force" -Wait -WindowStyle Hidden
Backup-File -Path "C:\Windows\System32\en-US\input.dll.mui" -UsePowerRun
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Region and Input CPL\7 Style\en-US\7nput.dll.mui' -Destination 'C:\Windows\System32\en-US\' -Recurse -Force" -Wait -WindowStyle Hidden