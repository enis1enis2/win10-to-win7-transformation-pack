#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
$escapedScriptDir = $scriptDir.Replace("'", "''")
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "reg import `"$scriptDir\Pages\Printers CPL\Vista Style\Import as TrustedInstaller\printers.reg`"" -WindowStyle Hidden -Wait -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
