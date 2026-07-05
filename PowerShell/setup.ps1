#requires -RunAsAdministrator
#requires -Version 7.0

$ErrorActionPreference = "Stop"
$repoRaw = "https://raw.githubusercontent.com/Dymyk58/Win11-Ricing/main/PowerShell"

try {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        throw "This script requires administrator privileges. Open Windows Terminal / PowerShell via 'Run as administrator' and try again."
    }

    $wingetApps = @(
        "JanDeDobbeleer.OhMyPosh",
        "ajeetdsouza.zoxide",
        "DEVCOM.JetBrainsMonoNerdFont",
        "Fastfetch-cli.Fastfetch"
    )
    foreach ($app in $wingetApps) {
        winget install --id $app --source winget --silent --accept-package-agreements --accept-source-agreements | Out-Null
    }

    if ((Get-PSRepository -Name PSGallery).InstallationPolicy -ne 'Trusted') {
        Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    }
    Install-Module -Name Terminal-Icons -Force -Repository PSGallery -Scope CurrentUser

    $env:Path += ";$Env:LOCALAPPDATA\Programs\oh-my-posh\bin"

    [System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', '1', 'Machine')

    if (-not (Test-Path (Split-Path $PROFILE))) {
        New-Item -ItemType Directory -Path (Split-Path $PROFILE) -Force | Out-Null
    }
    Invoke-WebRequest -Uri "$repoRaw/Microsoft.PowerShell_profile.ps1" -OutFile $PROFILE

    $theme = Join-Path $Home "catppuccin_macchiato.omp.json"
    Invoke-WebRequest -Uri "$repoRaw/catppuccin_macchiato.omp.json" -OutFile $theme
    attrib +h $theme

    $wtPaths = @(
        "$Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState",
        "$Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState",
        "$Env:LOCALAPPDATA\Microsoft\Windows Terminal"
    )
    $wtDirToUse = $wtPaths | Where-Object { Test-Path $_ } | Select-Object -First 1
    if (-not $wtDirToUse) {
        $wtDirToUse = $wtPaths[0]
        New-Item -ItemType Directory -Path $wtDirToUse -Force | Out-Null
    }
    Invoke-WebRequest -Uri "$repoRaw/settings.json" -OutFile (Join-Path $wtDirToUse "settings.json")

    $fastfetchDir = Join-Path $Home ".config\fastfetch"
    New-Item -ItemType Directory -Path $fastfetchDir -Force | Out-Null
    Invoke-WebRequest -Uri "$repoRaw/config.jsonc" -OutFile (Join-Path $fastfetchDir "config.jsonc")
    Invoke-WebRequest -Uri "$repoRaw/ascii.txt" -OutFile (Join-Path $fastfetchDir "ascii.txt")

    Write-Host "Successfully installed Win11-Ricing PowerShell setup." -ForegroundColor Green
}
catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}