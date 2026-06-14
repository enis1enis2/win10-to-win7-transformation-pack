$scriptDir = Split-Path -Parent $PSCommandPath
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"

$cplSource = "$scriptDir\Control Panel Links\Universal\7 Style\system32"
$cplBat = "$scriptDir\Control Panel Links\Universal\7 Style\Run as TrustedInstaller\cpl7.bat"

$copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$cplSource\*' -Destination 'C:\Windows\System32\' -Recurse -Force"
Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden

Start-Process $powerRun -ArgumentList $cplBat