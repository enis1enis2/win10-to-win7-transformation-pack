#requires -RunAsAdministrator

$powerRun = ".\..\PowerRun\PowerRun_x64.exe"

# Copy MUI for netcenter.dll
Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Network and Sharing Center CPL\7 Style\system32\en-US\netcenter.dll.mui' -Destination 'C:\Windows\System32\en-US' -Recurse -Force" -Wait -WindowStyle Hidden

# Import Connect To registry
Start-Process $powerRun -ArgumentList 'reg import "Pages\Network and Sharing Center CPL\Import as TrustedInstaller\connectto.reg"' -WindowStyle Hidden -Wait

# Copy network dialogs scripts to System32
Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Network and Sharing Center CPL\7 Style\Windows 7 Network Dialogs\system32\*' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden

# Import PNIDUI registry for network flyout
Start-Process $powerRun -ArgumentList 'reg import "Pages\Network and Sharing Center CPL\7 Style\Windows 7 Network Dialogs\Import as TrustedInstaller\pnidui.reg"' -WindowStyle Hidden -Wait

Write-Host ""
Write-Host "IMPORTANT: Additional steps required:" -ForegroundColor Yellow
Write-Host "  1. Use Resource Hacker to import 'netcenter.res' into C:\Windows\System32\netcenter.dll" -ForegroundColor Yellow
Write-Host "  2. Install PNIDUI.dll from aubymori.github.io for the network flyout" -ForegroundColor Yellow
Write-Host "  3. See readme.rtf in Pages\Network and Sharing Center CPL\ for details" -ForegroundColor Yellow
