#requires -RunAsAdministrator

Set-Location -Path (Split-Path -Parent $PSCommandPath)

$powerRun = ".\..\PowerRun\PowerRun_x64.exe"
$resHack = ".\..\resource_hacker\ResourceHacker.exe"
$pageDir = "Pages\Network and Sharing Center CPL"

# Patch netcenter.dll with 7-style resources using Resource Hacker
Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path 'C:\Windows\System32\netcenter.dll' -Destination '$pageDir\' -Force" -Wait -WindowStyle Hidden
Start-Process $resHack -ArgumentList "-open `"$pageDir\netcenter.dll`"", "-resource `"$pageDir\7 Style\system32\netcenter.dll\netcenter.res`"", "-save `"$pageDir\netcenter.dll`"", "-action addoverwrite" -Wait -WindowStyle Hidden
Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$pageDir\netcenter.dll' -Destination 'C:\Windows\System32\' -Force" -Wait -WindowStyle Hidden
Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path '$pageDir\netcenter.dll' -Force" -Wait -WindowStyle Hidden

# Copy MUI for netcenter.dll
Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$pageDir\7 Style\system32\en-US\netcenter.dll.mui' -Destination 'C:\Windows\System32\en-US' -Recurse -Force" -Wait -WindowStyle Hidden

# Import Connect To registry
Start-Process $powerRun -ArgumentList "reg import `"$pageDir\Import as TrustedInstaller\connectto.reg`"" -WindowStyle Hidden -Wait

# Copy network dialogs scripts to System32
Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$pageDir\7 Style\Windows 7 Network Dialogs\system32\*' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden

# Import PNIDUI registry for network flyout
Start-Process $powerRun -ArgumentList "reg import `"$pageDir\7 Style\Windows 7 Network Dialogs\Import as TrustedInstaller\pnidui.reg`"" -WindowStyle Hidden -Wait

Write-Host ""
Write-Host "Network and Sharing Center CPL installed." -ForegroundColor Green
Write-Host "  For the 7-style network flyout, install PNIDUI.dll from aubymori.github.io" -ForegroundColor Yellow
