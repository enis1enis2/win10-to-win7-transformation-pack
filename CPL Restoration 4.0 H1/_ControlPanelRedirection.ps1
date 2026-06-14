$scriptDir = Split-Path -Parent $PSCommandPath
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"
$regFile = "$scriptDir\Patch CPL Redirection\desktopContextPatch.reg"
$vivetool = "$scriptDir\..\ViVeTool\ViVeTool.exe"

if (Test-Path $regFile) {
    Start-Process $powerRun -ArgumentList "reg import `"$regFile`"" -WindowStyle Hidden -Wait
} else {
    Write-Warning "Registry patch not found at: $regFile"
}

if (Test-Path $vivetool) {
    Start-Process $powerRun -ArgumentList "$vivetool /disable /id:25175482" -WindowStyle Hidden -Wait
} else {
    Write-Warning "ViVeTool not found at: $vivetool"
}