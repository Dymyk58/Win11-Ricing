#requires -RunAsAdministrator
#requires -Version 7.0

# =====================================================================
#  Win11-Ricing setup.ps1
#  Automaticky nainstaluje a nakonfiguruje: PowerShell profil,
#  Windows Terminal settings, Fastfetch config a oh-my-posh tému
#  Zdroj: https://github.com/Dymyk58/Win11-Ricing
# =====================================================================

$ErrorActionPreference = "Stop"
$repoRaw = "https://raw.githubusercontent.com/Dymyk58/Win11-Ricing/main/PowerShell"

# #requires -RunAsAdministrator sa nevynuti, ked sa skript spusti cez `irm | iex`,
# preto kontrolujeme admin prava explicitne za behu.
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Tento skript potrebuje administratorske prava." -ForegroundColor Red
    Write-Host "Spusti Windows Terminal / PowerShell cez 'Spustit ako spravca' a skus to znova." -ForegroundColor Yellow
    exit 1
}

function Write-Step($msg) {
    Write-Host "`n==> $msg" -ForegroundColor Cyan
}

function Backup-IfExists($path) {
    if (Test-Path $path) {
        $backup = "$path.bak"
        Copy-Item -Path $path -Destination $backup -Force
        Write-Host "  Zaloha vytvorena: $backup" -ForegroundColor DarkGray
    }
}

# ---------------------------------------------------------------------
# 0. Kontroly
# ---------------------------------------------------------------------
if (-not ($Env:WT_SESSION)) {
    Write-Warning "Windows Terminal sa nezda byt aktivny terminal. Skript pokracuje, ale odporucam spustit ho z Windows Terminalu."
}

# ---------------------------------------------------------------------
# 1. Zavislosti cez winget
# ---------------------------------------------------------------------
Write-Step "Instalujem zavislosti cez winget (oh-my-posh, zoxide, Nerd Font, fastfetch)"

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

# PowerShell modul pre ikony v termináli
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Write-Host "  -> Terminal-Icons (PowerShell modul)"
    Install-Module -Name Terminal-Icons -Force -Repository PSGallery -Scope CurrentUser
}

# Zapnutie oh-my-posh (ak este nie je v PATH v tejto relacii)
$env:Path += ";$Env:LOCALAPPDATA\Programs\oh-my-posh\bin"

# ---------------------------------------------------------------------
# 2. Vypnutie telemetrie pwsh (rovnako ako doteraz)
# ---------------------------------------------------------------------
[System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', '1', 'Machine')

# ---------------------------------------------------------------------
# 3. PowerShell profil
# ---------------------------------------------------------------------
Write-Step "Instalujem PowerShell profil"

Backup-IfExists $PROFILE
if (-not (Test-Path (Split-Path $PROFILE))) {
    New-Item -ItemType Directory -Path (Split-Path $PROFILE) -Force | Out-Null
}
Invoke-WebRequest -Uri "$repoRaw/Microsoft.PowerShell_profile.ps1" -OutFile $PROFILE

# oh-my-posh tema (Catppuccin Macchiato) - profil na nu odkazuje ako $Home\catppuccin_macchiato.omp.json
$theme = Join-Path $Home "catppuccin_macchiato.omp.json"
Backup-IfExists $theme
Invoke-WebRequest -Uri "$repoRaw/catppuccin_macchiato.omp.json" -OutFile $theme
attrib +h $theme

# ---------------------------------------------------------------------
# 4. Windows Terminal settings.json
# ---------------------------------------------------------------------
Write-Step "Instalujem Windows Terminal settings.json"

$wtPaths = @(
    "$Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json",
    "$Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json",
    "$Env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json"
)

$wtSettings = $wtPaths | Where-Object { Test-Path (Split-Path $_) } | Select-Object -First 1

if (-not $wtSettings) {
    Write-Warning "Nenasiel som priecinok Windows Terminalu. Otvor Windows Terminal aspon raz a spusti skript znova, alebo skopiruj settings.json manualne."
} else {
    Backup-IfExists $wtSettings
    Invoke-WebRequest -Uri "$repoRaw/settings.json" -OutFile $wtSettings
}

# ---------------------------------------------------------------------
# 5. Fastfetch config + ascii logo
# ---------------------------------------------------------------------
Write-Step "Instalujem Fastfetch config"

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

# Oprava natvrdo zadanej cesty (C:/Users/Dymyk/...) na aktualneho pouzivatela
$userProfileForward = $Env:USERPROFILE -replace '\\', '/'
(Get-Content $fastfetchConfig -Raw) `
    -replace 'C:/Users/[^/"]+/\.config/fastfetch', "$userProfileForward/.config/fastfetch" |
    Set-Content $fastfetchConfig -Encoding UTF8

# ---------------------------------------------------------------------
# Hotovo
# ---------------------------------------------------------------------
Write-Host "`nHotovo! Uspesne nainstalovany Win11-Ricing PowerShell setup." -ForegroundColor Green
Write-Host "Zavri a znova otvor Windows Terminal, aby sa vsetky zmeny prejavili." -ForegroundColor Yellow
Write-Host "V nastaveniach Windows Terminalu skontroluj, ci je font nastaveny na 'JetBrainsMono Nerd Font'." -ForegroundColor Yellow
