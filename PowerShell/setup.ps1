#requires -RunAsAdministrator
#requires -Version 7.0

# =====================================================================
#  Win11-Ricing setup.ps1
#  Automatically installs and configures: PowerShell profile,
#  Windows Terminal settings, Fastfetch config and oh-my-posh theme
#  Source: https://github.com/Dymyk58/Win11-Ricing
# =====================================================================

$ErrorActionPreference = "Stop"
$repoRaw = "https://raw.githubusercontent.com/Dymyk58/Win11-Ricing/main/PowerShell"

# #requires -RunAsAdministrator is not enforced when the script is run via `irm | iex`,
# so we check for admin rights explicitly at runtime.
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script requires administrator privileges." -ForegroundColor Red
    Write-Host "Open Windows Terminal / PowerShell via 'Run as administrator' and try again." -ForegroundColor Yellow
    exit 1
}

function Write-Step($msg) {
    Write-Host "`n==> $msg" -ForegroundColor Cyan
}

function Backup-IfExists($path) {
    if (Test-Path $path) {
        $backup = "$path.bak"
        Copy-Item -Path $path -Destination $backup -Force
        Write-Host "  Backup created: $backup" -ForegroundColor DarkGray
        # Clear hidden/read-only attributes so the next write (Invoke-WebRequest) doesn't fail
        try { (Get-Item $path -Force).Attributes = 'Normal' } catch {}
    }
}

# ---------------------------------------------------------------------
# 0. Checks
# ---------------------------------------------------------------------
if (-not ($Env:WT_SESSION)) {
    Write-Warning "Windows Terminal doesn't appear to be the active terminal. The script will continue, but it's recommended to run it from Windows Terminal."
}

# ---------------------------------------------------------------------
# 1. Dependencies via winget
# ---------------------------------------------------------------------
Write-Step "Installing dependencies via winget (oh-my-posh, zoxide, Nerd Font, fastfetch)"

$wingetApps = @(
    "JanDeDobbeleer.OhMyPosh",
    "ajeetdsouza.zoxide",
    "DEVCOM.JetBrainsMonoNerdFont",
    "Fastfetch-cli.Fastfetch",
    "Microsoft.WindowsTerminal"
)

foreach ($app in $wingetApps) {
    Write-Host "  -> $app"
    winget install --id $app --source winget --silent --accept-package-agreements --accept-source-agreements | Out-Null
}

# PowerShell module for terminal icons
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Write-Host "  -> Terminal-Icons (PowerShell module)"
    Install-Module -Name Terminal-Icons -Force -Repository PSGallery -Scope CurrentUser
}

# Make oh-my-posh available (in case it's not yet in PATH in this session)
$env:Path += ";$Env:LOCALAPPDATA\Programs\oh-my-posh\bin"

# ---------------------------------------------------------------------
# 2. Disable pwsh telemetry (same as before)
# ---------------------------------------------------------------------
[System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', '1', 'Machine')

# ---------------------------------------------------------------------
# 3. PowerShell profile
# ---------------------------------------------------------------------
Write-Step "Installing PowerShell profile"

Backup-IfExists $PROFILE
if (-not (Test-Path (Split-Path $PROFILE))) {
    New-Item -ItemType Directory -Path (Split-Path $PROFILE) -Force | Out-Null
}
Invoke-WebRequest -Uri "$repoRaw/Microsoft.PowerShell_profile.ps1" -OutFile $PROFILE

# oh-my-posh theme (Catppuccin Macchiato) - the profile references it as $Home\catppuccin_macchiato.omp.json
$theme = Join-Path $Home "catppuccin_macchiato.omp.json"
Backup-IfExists $theme
if (Test-Path $theme) {
    Remove-Item -Path $theme -Force
}
Invoke-WebRequest -Uri "$repoRaw/catppuccin_macchiato.omp.json" -OutFile $theme
attrib +h $theme

# ---------------------------------------------------------------------
# 4. Windows Terminal settings.json
# ---------------------------------------------------------------------
Write-Step "Installing Windows Terminal settings.json"

$wtPaths = @(
    "$Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json",
    "$Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json",
    "$Env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json"
)

$wtSettings = $wtPaths | Where-Object { Test-Path (Split-Path $_) } | Select-Object -First 1

if (-not $wtSettings) {
    Write-Warning "Could not find the Windows Terminal folder. Open Windows Terminal at least once and run the script again, or copy settings.json manually."
} else {
    Backup-IfExists $wtSettings
    Invoke-WebRequest -Uri "$repoRaw/settings.json" -OutFile $wtSettings
}

# ---------------------------------------------------------------------
# 5. Fastfetch config + ascii logo
# ---------------------------------------------------------------------
Write-Step "Installing Fastfetch config"

$fastfetchDir = Join-Path $Home ".config\fastfetch"
if (-not (Test-Path $fastfetchDir)) {
    New-Item -ItemType Directory -Path $fastfetchDir -Force | Out-Null
}

$fastfetchConfig = Join-Path $fastfetchDir "config.jsonc"
$fastfetchAscii  = Join-Path $fastfetchDir "ascii.txt"

Backup-IfExists $fastfetchConfig
Backup-IfExists $fastfetchAscii

Invoke-WebRequest -Uri "$repoRaw/config.jsonc" -OutFile $fastfetchConfig
Invoke-WebRequest -Uri "$repoRaw/ascii.txt" -OutFile $fastfetchAscii

# Fix the hardcoded path (C:/Users/Dymyk/...) to the current user
$userProfileForward = $Env:USERPROFILE -replace '\\', '/'
(Get-Content $fastfetchConfig -Raw) `
    -replace 'C:/Users/[^/"]+/\.config/fastfetch', "$userProfileForward/.config/fastfetch" |
    Set-Content $fastfetchConfig -Encoding UTF8

# ---------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------
Write-Host "`nDone! Win11-Ricing PowerShell setup installed successfully." -ForegroundColor Green
Write-Host "Close and reopen Windows Terminal for all changes to take effect." -ForegroundColor Yellow
Write-Host "In Windows Terminal settings, check that the font is set to 'JetBrainsMono Nerd Font'." -ForegroundColor Yellow
