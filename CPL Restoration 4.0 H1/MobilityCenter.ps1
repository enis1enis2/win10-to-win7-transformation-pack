#requires -RunAsAdministrator

Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Mobility Center CPL\7 Style\system32\batmete7.dll' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Mobility Center CPL\7 Style\system32\mblctr.exe' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Mobility Center CPL\7 Style\system32\en-US\*' -Destination 'C:\Windows\System32\en-US' -Recurse -Force" -Wait -WindowStyle Hidden
