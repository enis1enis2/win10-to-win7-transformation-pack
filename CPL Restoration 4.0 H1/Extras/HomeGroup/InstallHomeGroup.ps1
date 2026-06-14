#requires -RunAsAdministrator
#requires -Version 5.0

<#
.SYNOPSIS
    Restore HomeGroup functionality on Windows 10 1803-22H2
.DESCRIPTION
    Restores the HomeGroup feature removed since Windows 10 1803.
    Uses stobject.dll from Windows 10 Anniversary Update (build 14393)
    and restores required registry entries and services.
.NOTES
    Author: Based on work by Brawllux and Petya (winclassic.net)
    Requires: stobject.dll version 10.0.14393.7426 from Windows 10 1607
#>

$scriptDir = Split-Path -Parent $PSCommandPath
$powerRun = "$scriptDir\..\..\PowerRun\PowerRun_x64.exe"
$sys32 = "$env:SystemRoot\System32"

function Write-Status {
    param([string]$Msg, [string]$Color = "White")
    Write-Host $Msg -ForegroundColor $Color
}

# Step 1: Replace stobject.dll
Write-Status "=== Step 1: Replacing stobject.dll ===" -Color Cyan
$dllSrc = "$scriptDir\Windows\System32\stobject.dll"
$muiSrc = "$scriptDir\Windows\System32\en-US\stobject.dll.mui"
$dllDst = "$sys32\stobject.dll"
$muiDst = "$sys32\en-US\stobject.dll.mui"

if ((Test-Path $dllSrc) -and (Test-Path $muiSrc)) {
    $copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$dllSrc' -Destination '$dllDst' -Force"
    Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden
    $copyCmd2 = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$muiSrc' -Destination '$muiDst' -Force"
    Start-Process $powerRun -ArgumentList $copyCmd2 -Wait -WindowStyle Hidden
    Write-Status "  stobject.dll replaced" -Color Green
} else {
    Write-Status "  stobject.dll not found in HomeGroup directory!" -Color Yellow
    Write-Status "  Download from a Windows 10 build 14393 (Anniversary Update) system" -Color Yellow
    Write-Status "  Required files: stobject.dll + en-US\stobject.dll.mui (10.0.14393.7426)" -Color Yellow
}

# Step 2: Import registry keys (Normal)
Write-Status "=== Step 2: Importing registry keys (Normal) ===" -Color Cyan
$regNormal = "$scriptDir\Normal\CPL.reg"
if (Test-Path $regNormal) {
    Start-Process reg.exe -ArgumentList "import `"$regNormal`"" -Wait -WindowStyle Hidden
    Write-Status "  Normal registry imported" -Color Green
} else {
    Write-Status "  Normal registry file not found: $regNormal" -Color Yellow
}

# Step 3: Import registry keys (TI)
Write-Status "=== Step 3: Importing registry keys (TrustedInstaller) ===" -Color Cyan
$tiRegs = @("HomeGroupListener.reg", "HomeGroupProvider.reg")
foreach ($reg in $tiRegs) {
    $regFile = "$scriptDir\TI\$reg"
    if ((Test-Path $regFile) -and (Test-Path $powerRun)) {
        Start-Process $powerRun -ArgumentList "reg import `"$regFile`"" -Wait -WindowStyle Hidden
        Write-Status "  $reg imported" -Color Green
    } else {
        Write-Status "  $reg or PowerRun not found" -Color Yellow
    }
}

# Step 4: Add svchost entries
Write-Status "=== Step 4: Configuring svchost entries ===" -Color Cyan
$svchostPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost"

try {
    $localSysNet = Get-ItemProperty -Path $svchostPath -Name "LocalSystemNetworkRestricted" -ErrorAction Stop
    $list = [System.Collections.ArrayList]@($localSysNet.LocalSystemNetworkRestricted)
    if ($list -notcontains "HomeGroupListener") {
        $list.Add("HomeGroupListener") | Out-Null
        Set-ItemProperty -Path $svchostPath -Name "LocalSystemNetworkRestricted" -Value ($list.ToArray())
        Write-Status "  Added HomeGroupListener to LocalSystemNetworkRestricted" -Color Green
    } else {
        Write-Status "  HomeGroupListener already in LocalSystemNetworkRestricted" -Color Gray
    }
} catch {
    Write-Status "  Failed to update LocalSystemNetworkRestricted: $_" -Color Red
}

try {
    $localSvcNet = Get-ItemProperty -Path $svchostPath -Name "LocalServiceNetworkRestricted" -ErrorAction Stop
    $list = [System.Collections.ArrayList]@($localSvcNet.LocalServiceNetworkRestricted)
    if ($list -notcontains "HomeGroupProvider") {
        $list.Add("HomeGroupProvider") | Out-Null
        Set-ItemProperty -Path $svchostPath -Name "LocalServiceNetworkRestricted" -Value ($list.ToArray())
        Write-Status "  Added HomeGroupProvider to LocalServiceNetworkRestricted" -Color Green
    } else {
        Write-Status "  HomeGroupProvider already in LocalServiceNetworkRestricted" -Color Gray
    }
} catch {
    Write-Status "  Failed to update LocalServiceNetworkRestricted: $_" -Color Red
}

# Step 5: Set navpane sort order
Write-Status "=== Step 5: Configuring Explorer navpane ===" -Color Cyan
$navpanePaths = @(
    "HKCR:\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}",
    "HKCR:\WOW6432Node\CLSID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}"
)
foreach ($path in $navpanePaths) {
    if (Test-Path $path) {
        try {
            Set-ItemProperty -Path $path -Name "SortOrderIndex" -Value 46 -Type DWord
            Write-Status "  Set SortOrderIndex=46 at $path" -Color Green
        } catch {
            Write-Status "  Failed to set SortOrderIndex at $path: $_" -Color Yellow
        }
    }
}

# Step 6: Start services
Write-Status "=== Step 6: Starting HomeGroup services ===" -Color Cyan
try {
    Start-Service -Name "HomeGroupListener" -ErrorAction SilentlyContinue
    Start-Service -Name "HomeGroupProvider" -ErrorAction SilentlyContinue
    Write-Status "  Services started" -Color Green
} catch {
    Write-Status "  Some services could not be started. Reboot may be required." -Color Yellow
}

Write-Status ""
Write-Status "=== HomeGroup restoration complete ===" -Color Cyan
Write-Status "  Reboot your PC for changes to take full effect" -Color Yellow
Write-Status "  Ensure Network Discovery is enabled and network is set to Private" -Color Yellow
