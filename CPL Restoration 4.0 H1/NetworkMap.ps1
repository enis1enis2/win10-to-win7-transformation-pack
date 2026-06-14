#requires -RunAsAdministrator

Set-Location -Path (Split-Path -Parent $PSCommandPath)

$powerRun = ".\..\PowerRun\PowerRun_x64.exe"
$pageDir = "Pages\Network Map CPL"

# Copy network map DLLs to System32
Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$pageDir\7 Style\system32\*' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden

# Import netmap.reg (CLSID registration for Network Map)
Start-Process $powerRun -ArgumentList "reg import `"$pageDir\7 Style\import as TI\netmap.reg`"" -WindowStyle Hidden -Wait

# Import LLTDIO.reg (enable LLTDIO driver for network discovery)
Start-Process $powerRun -ArgumentList "reg import `"$pageDir\7 Style\import as TI\LLTDIO.reg`"" -WindowStyle Hidden -Wait

Write-Host ""
Write-Host "Network Map CPL installed." -ForegroundColor Green
