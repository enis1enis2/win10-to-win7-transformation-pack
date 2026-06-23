#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\don''t load' -Name 'joy.cpl' -Force" -WindowStyle Hidden -Wait -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
reg import "$scriptDir\Pages\Game Controllers CPL\Vista Style\Import Normally\joy.reg"
