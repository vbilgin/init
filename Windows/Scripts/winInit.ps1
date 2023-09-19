# === Create local folders ===
New-Item "C:\Users\%USERNAME%\Apps" -ItemType Directory
New-Item "C:\Users\%USERNAME%\Dev" -ItemType Directory
New-Item "C:\Users\%USERNAME%\Dev\git" -ItemType Directory
New-Item "C:\Users\%USERNAME%\Dev\local" -ItemType Directory

# === Install fonts ===
# https://blog.simontimms.com/2021/06/11/installing-fonts/
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
foreach ($file in Get-ChildItem "..\..\General\Fonts" -Recurse -File) {
  $fileName = $file.Name
  if (-not(Test-Path -Path "C:\Windows\Fonts\$fileName" )) {
    Write-Host "Installing $fileName"
    Get-ChildItem $file | ForEach-Object { $fonts.CopyHere($_.fullname) }
  }
}
Copy-Item "..\..\General\Fonts\*" "C:\Windows\Fonts\" -Recurse -File

# === Run Chris Titus Tech's Windows Utility ===
# https://github.com/ChrisTitusTech/winutil
# Installs Chocolatey
Invoke-RestMethod https://christitus.com/win | Invoke-Expression

# Install most apps via Chocolatey
choco install `
  vscode `
  vlc `
  spotify `
  7zip `
  googlechrome `
  firefox `
  python `
  plex `
  obsidian `
  qbittorrent `
  git `
  powershell-core -y

# === Check if running on Windows 11 ===
# App Installer comes in Win 11 by default
# If not on Win 11, continue with adding App Installer
$isWin11 = (Get-WmiObject Win32_OperatingSystem).Caption -Match "Windows 11"
if (-not $isWin11) {
  Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
}

# === Install some apps from MS Store ===
winget install "Yubico Authenticator" --source msstore
winget install "Microsoft PowerToys" --source msstore
winget install "Windows Terminal" --source msstore

# === Install WSL ===
wsl --install

# === Install some apps via .exe ===
# Tailscale (always pulls latest)
Invoke-WebRequest -Uri "https://pkgs.tailscale.com/stable/tailscale-setup-latest.exe" -OutFile "$PSScriptRoot\..\Tailscale.exe"
Start-Process -Filepath "$PSScriptRoot\..\Tailscale.exe"

# 1Password 8 (always pulls latest)
Invoke-WebRequest -Uri "https://downloads.1password.com/win/1PasswordSetup-latest.exe" -OutFile "$PSScriptRoot\..\1Password.exe"
Start-Process -Filepath "$PSScriptRoot\..\1Password.exe"

# Mullvad VPN (always pulls latest)
Invoke-WebRequest -Uri "https://mullvad.net/en/download/app/exe/latest" -OutFile "$PSScriptRoot\..\Mullvad.exe"
Start-Process -Filepath "$PSScriptRoot\..\Mullvad.exe"