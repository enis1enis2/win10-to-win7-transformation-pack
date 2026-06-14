#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
Set-Location -Path $scriptDir

Start-Process -FilePath "$scriptDir\windhawk_setup.exe" -ArgumentList "/S" -Wait