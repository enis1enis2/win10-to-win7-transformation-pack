#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$resourceDir = "$scriptDir\ResourceRedirect"

if (Test-Path $resourceDir) {
    Copy-Item -Path $resourceDir -Destination 'C:\Windows\' -Recurse -Force
    Write-Host "ResourceRedirect copied to C:\Windows\ResourceRedirect" -ForegroundColor Green
} else {
    Write-Warning "ResourceRedirect directory not found at: $resourceDir"
}