<h1 align="center">⚠️ UNDER CONSTRUCTION ⚠️</h1>
<h3 align="center">✨ My Windows 11 Setup ✨</h3>

<p align="center">
A complete guide to my Windows 11 customization – from the YASB bar to all the little tweaks that make it clean, aesthetic, and productive.
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
You can follow the steps below, or jump to the [**setup video**](https://www.youtube.com/watch?v=your-video-id).
- Install [**YASB**]([(https://github.com/amnweb/yasb)])   
- Copy the config files from [**here**](https://github.com/SleepyCatHey/Ultimate-Win11-Setup/tree/main/YASB).
- Remove the codes from **your** YASB config and paste the one you just copied.
- Restart **YASB** for the changes to take effect.

---

## 🦅 Windhawk
> [!NOTE] 
> Right now I have just listed the advance section codes for the mods I use.

Windhawk aims to make it easier to customize Windows programs.

**⚙️ Installation:**  
- Install [**Windhawk**](https://windhawk.net/)   
- Copy the config file from [**here**](https://github.com/SleepyCatHey/Ultimate-Win11-Setup/tree/main/Windhawk).
- Remove the codes from the advance section in **your** Windhawk mod and paste the one you just copied.
- Click **Save settings** for the changes to take effect.

---

## 🔍 Flow Launcher

Quick File Search & App Launcher for Windows

**⚙️ Installation:**  
You can follow the steps below,
- Install [**Flow Launcher**](https://www.flowlauncher.com/).
- Download the theme file from [**here**](https://github.com/SleepyCatHey/Ultimate-Win11-Setup/tree/main/Flow%20Launcher).
- Open Flow Launcher's Settings window, select **Appearance** on the sidebar, and click the "Open Theme Folder" button at the bottom.
- Move your theme file downloaded in Step 1 to this directory, and restart Flow Launcher.
- Again in Flow Launcher's Settings window, select **Appearance** on the sidebar, and select your Catppuccin flavor from the list of themes.
Installation guide was taken from [**here**](https://github.com/catppuccin/flow-launcher). Thanks :)

---

## 👾 Terminal + Fastfetch
> [!NOTE] 
> If you just wanna fully use it just like I'm using then I recommend watchng the video. If you just want the config for Fastfetch then just paste the config where **your** Fastfetch config is located. If you have a PowerShell profile then just add your location and other stuff in your profile yourself as idk what you got.
>
> If you see **"execution of scripts is disabled on this system"**, don’t panic! Just open PowerShell as Administrator and run: 
> `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force`
>
> Also if you notice that the ASCII art is not showing then try editing `"source": "C:/Users/%USERPROFILE%/.config/fastfetch/ascii.txt"` to `"source": "%USERPROFILE%/.config/fastfetch/ascii.txt"`. That should fix it. [**Credits**](https://github.com/SleepyCatHey/Ultimate-Win11-Setup/issues/1#issue-3498937609).
>
> If you want to add FastFetch to CMD as well, then please check out this [**issue**](https://github.com/SleepyCatHey/Ultimate-Win11-Setup/issues/9#issue-3958846174). Big thanks to [**Augtive85YT**](https://github.com/Augtive85YT).
 
Fastfetch is a neofetch-like tool for fetching system information and displaying it in a visually appealing way. It is written mainly in C, with a focus on performance and customizability.

**⚙️ Installation:**
- Install [**Fastfetch**](https://github.com/fastfetch-cli/fastfetch/releases) and I believe you already got the **Windows terminal** installed.
- Copy the config file for your Terminal [**here**](https://github.com/SleepyCatHey/Ultimate-Win11-Setup/tree/main/Terminal), PowerShell profile from [**here**](https://github.com/SleepyCatHey/Ultimate-Win11-Setup/tree/main/PowerShell) and Fastfetch config from [**here**](https://github.com/SleepyCatHey/Ultimate-Win11-Setup/tree/main/Fastfetch)
- Remove the codes from the settings.json file in **your terminal** and paste the one you just copied from above. Do the same thing for your PowerShell profile.
- Create a **.config** *hidden* file in your C:\Users\%USERPROFILE% and create a folder called **fastfetch** inside. Copy the config and ascii code you just downloaded and paste it in that folder.
- Change the %USERPROFILE% from the config file in the fastfetch folder and the PowerShell profile with **your username**..
- Restart your terminal and your done. If this feel complicated just watch the [**setup video**](https://youtu.be/z3NpVq-y6jU).

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
