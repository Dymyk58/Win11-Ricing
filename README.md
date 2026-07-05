<h1 align="center">⚠️ UNDER CONSTRUCTION ⚠️</h1>
<h3 align="center">✨ My Windows 11 Setup ✨</h3>

<p align="center">
A complete guide to my Windows 11 customization
</p>

---

## 📑 Table of Contents

| 📚 Entry | ✨ App |
|---------------------|------------|
| Status Bar          | [YASB](#yasb) |
| App Launcher        | [Flow Launcher](#flowlauncher) |
| Taskbar             | [Windhawk](#windhawk) |
| Terminal            | [Windows Terminal](#windows-terminal) |
| Browser             | [Zen Browser](#zen) |
| System Fetch        | [Fastfetch](#Fastfetch) |   
| Shell Prompt        | [Oh My Posh](#ohmyposh) |
| Audio Visualizer    | [Cava](#cava) |
| Music Player        | [Spotify](#spotify) | 

Other

| 📚 Entry | ✨ App |
|---------------------|------------|
| Colorscheme         | [Catppuccin Macchiato](https://catppuccin.com) |
| Font                | [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip) |


---

# ⚡ Details

## 📏 YASB
> [!NOTE] 
> Some stuff in my config might not work if you just copy and paste it. Be sure to app your api for the weather widget to work and your wallpaper folder location for the wallpapers widget

A highly configurable Windows status bar written in Python. 

**⚙️ Installation:**  
- Install [**YASB**]([(https://github.com/amnweb/yasb)])   
- Copy the config files from [**here**](https://github.com/SleepyCatHey/Ultimate-Win11-Setup/tree/main/YASB).
- Remove the codes from **your** YASB config and paste the one you just copied.
- Restart **YASB** for the changes to take effect.

---

## 🔍 Flow Launcher

Quick File Search & App Launcher for Windows

**⚙️ Installation:**  
You can follow the steps below,
- Install [**Flow Launcher**](https://www.flowlauncher.com/).
- Download the theme file from [**here**](https://github.com/Dymyk58/Win11-Ricing/tree/main/Flow%20Launcher).
- Open Flow Launcher's Settings window, select **Appearance** on the sidebar, and click the "Open Theme Folder" button at the bottom.
- Move your theme file downloaded in Step 1 to this directory, and restart Flow Launcher.
- Again in Flow Launcher's Settings window, select **Appearance** on the sidebar, and select your Catppuccin flavor from the list of themes.
Installation guide was taken from [**here**](https://github.com/catppuccin/flow-launcher). Thanks :)

---

## 🦅 Windhawk
> [!NOTE] 
> Right now I have just listed the advance section codes for the mods I use.

Windhawk aims to make it easier to customize Windows programs.

**⚙️ Installation:**  
- Install [**Windhawk**](https://windhawk.net/)   
- Copy the config file from [**here**](https://github.com/Dymyk58/Win11-Ricing/tree/main/Windhawk).
- Remove the codes from the advance section in **your** Windhawk mod and paste the one you just copied.
- Click **Save settings** for the changes to take effect.

---

## 👾 Terminal + Fastfetch
> [!NOTE] 
> This will overwrite your existing PowerShell profile and Windows Terminal `settings.json` without asking, so back them up first if you have your own customizations you want to keep.
>
> If you see **"execution of scripts is disabled on this system"**, don't panic! Just open PowerShell and run: 
> `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force`

A single PowerShell script that sets up my whole terminal experience in one go — no manual copy-pasting of config files needed.

**What it does:**
- Installs [**Oh My Posh**](https://ohmyposh.dev/), [**zoxide**](https://github.com/ajeetdsouza/zoxide), the **JetBrainsMono Nerd Font** and [**Fastfetch**](https://github.com/fastfetch-cli/fastfetch) via `winget`
- Installs the `Terminal-Icons` PowerShell module
- Downloads and applies my PowerShell profile to `$PROFILE`
- Downloads the Catppuccin Macchiato Oh My Posh theme
- Downloads and applies my Windows Terminal `settings.json`
- Downloads my Fastfetch config and ASCII art into `%USERPROFILE%\.config\fastfetch`
- Opts you out of PowerShell telemetry (bloatware)

**⚙️ Installation:**
- Open PowerShell (no admin rights needed)
- Run:
  ```powershell
  irm https://raw.githubusercontent.com/Dymyk58/Win11-Ricing/main/PowerShell/setup.ps1 | iex
  ```
- Restart your terminal once it's done, and you're set.

---

## 🪟 AppName
> [!NOTE] 
> This setup is compatible with the latest version of **AppName**.

A short description about what the app/config does and why you’re using it.  
(Example: Minimal tiling window manager setup with custom keybindings and themes.)

**⚙️ Installation:**  
You can follow the steps below, or jump to the [setup video](https://www.youtube.com/watch?v=your-video-id).
- Install [**AppName**](https://appname-website.com/download)   
- Copy the config file:  
  `windots/.config/appname/config.file → %USERPROFILE%\.config\appname\config.file`  
- Restart **AppName** for the changes to take effect

---
