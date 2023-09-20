# init

A collection of files, scripts, and other bits to help me set up a new machine (Windows, macOS, Linux).

## Windows

Run the following commands in PowerShell (admin not needed but will be needed for scripts in the repo):

```powershell
Set-ExecutionPolicy Bypass
Invoke-WebRequest 'https://github.com/vbilgin/init/archive/refs/heads/main.zip' -OutFile .\init.zip
Expand-Archive .\init.zip .\
Rename-Item .\init-main .\init
Remove-Item .\init.zip

```

### Actions Performed

- Creates the following directories:
  - `C:\Users\<username>\Apps`
  - `C:\Users\<username>\Dev`
  - `C:\Users\<username>\Dev\git`
  - `C:\Users\<username>\Dev\local`
- Installs all of the fonts in the `General\Fonts` folder
- Runs Chris Titus Tech's Windows Utility (https://github.com/ChrisTitusTech/winutil)
  - This script also installs Chocolatey (https://chocolatey.org/)
- Installs the following apps via Chocolatey:
  - VS Code
  - VLC
  - Spotify
  - 7-zip
  - Google Chrome
  - Firefox
  - Python
  - Plex
  - Obsidian
  - qBittorrent
  - Git
  - PowerShell Core
- Installs winget/App Installer (if running Windows 10)
- Installs the following apps from the Microsoft Store:
  - Yubico Authenticator
  - Microsoft PowerToys
  - Windows Terminal (if running Windows 10)
- Installs the following apps via their .exe files (pulled from online sources):
  - Tailscale
  - 1Password 8
  - Mullvad VPN
