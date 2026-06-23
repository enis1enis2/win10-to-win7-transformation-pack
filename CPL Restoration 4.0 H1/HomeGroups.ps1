#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
$escapedScriptDir = $scriptDir.Replace("'", "''")
$p = Start-Process reg.exe -ArgumentList "import `"$scriptDir\Pages\HomeGroups CPL\Import Normally\HGCPL.reg`"" -WindowStyle Hidden -Wait -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
