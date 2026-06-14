#requires -RunAsAdministrator

$powerRun = ".\..\PowerRun\PowerRun_x64.exe"

# Copy network map DLLs to System32
Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Network Map CPL\7 Style\system32\*' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden

# Import registry
Start-Process $powerRun -ArgumentList 'reg import "Pages\Network Map CPL\7 Style\import as TI\netmap.reg"' -WindowStyle Hidden -Wait

Write-Host ""
Write-Host "IMPORTANT: Enable LLTDIO driver via Group Policy for Network Map to work:" -ForegroundColor Yellow
Write-Host "  1. Press Win+R, type 'gpedit.msc' and press Enter" -ForegroundColor Yellow
Write-Host "  2. Go to: Computer Config > Admin Templates > Network > Link-Layer Topology Discovery" -ForegroundColor Yellow
Write-Host "  3. Enable 'Turn on Mapper I/O (LLTDIO) Driver'" -ForegroundColor Yellow
Write-Host "  4. Check 'Allow Operation While In Domain' and the option below (NOT the 3rd box)" -ForegroundColor Yellow
Write-Host "  5. See readme.rtf in Pages\Network Map CPL\ for details" -ForegroundColor Yellow
