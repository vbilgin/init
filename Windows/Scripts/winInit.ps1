Write-Host "%%% winInit Starting! %%%" -ForegroundColor Black -BackgroundColor White

# === Create local folders ===
$userName = [Environment]::UserName
Write-Host "Creating local directories..." -ForegroundColor Black -BackgroundColor White
New-Item "C:\Users\$userName\Apps" -ItemType Directory
New-Item "C:\Users\$userName\Dev" -ItemType Directory
New-Item "C:\Users\$userName\Dev\git" -ItemType Directory
New-Item "C:\Users\$userName\Dev\local" -ItemType Directory
Write-Host "Local directories created!" -ForegroundColor Black -BackgroundColor White

# === Install fonts ===
# https://blog.simontimms.com/2021/06/11/installing-fonts/
Write-Host "Installing fonts..." -ForegroundColor Black -BackgroundColor White
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
foreach ($file in Get-ChildItem "..\..\General\Fonts" -Recurse -File) {
  $fileName = $file.Name
  if (-not(Test-Path -Path "C:\Windows\Fonts\$fileName" )) {
    Write-Host "Installing: $fileName"
    $file | ForEach-Object { $fonts.CopyHere($_.fullname) }
  }
}
Write-Host "Fonts installed!" -ForegroundColor Black -BackgroundColor White

# === Run Chris Titus Tech's Windows Utility ===
# https://github.com/ChrisTitusTech/winutil
# Installs Chocolatey
Write-Host "Running CTT WinUtil..." -ForegroundColor Black -BackgroundColor White
Invoke-RestMethod https://christitus.com/win | Invoke-Expression
Write-Host "CTT WinUtil finished!" -ForegroundColor Black -BackgroundColor White

# Install most apps via Chocolatey
Write-Host "Installing choco apps..." -ForegroundColor Black -BackgroundColor White
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
Write-Host "Finished installing choco apps!" -ForegroundColor Black -BackgroundColor White

# === Check if running on Windows 11 ===
# App Installer comes in Win 11 by default
# If not on Win 11, continue with adding App Installer
$isWin11 = (Get-WmiObject Win32_OperatingSystem).Caption -Match "Windows 11"
if (-not $isWin11) {
  Write-Host "Installing App Installer..." -ForegroundColor Black -BackgroundColor White
  Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
}

# === Install some apps from MS Store ===
Write-Host "Installing MS Store apps..." -ForegroundColor Black -BackgroundColor White
winget install "Yubico Authenticator" --source msstore
winget install "Microsoft PowerToys" --source msstore

# Only install Windows Terminal if not on Win 11
if (-not $isWin11) {
  winget install "Windows Terminal" --source msstore
}
Write-Host "Finished installing MS Store apps!" -ForegroundColor Black -BackgroundColor White

# === Install some apps via .exe ===
Write-Host "Installing .exe apps..." -ForegroundColor Black -BackgroundColor White
# Tailscale (always pulls latest)
Invoke-WebRequest -Uri "https://pkgs.tailscale.com/stable/tailscale-setup-latest.exe" -OutFile "$PSScriptRoot\..\Tailscale.exe"
Start-Process -Filepath "$PSScriptRoot\..\Tailscale.exe"

# 1Password 8 (always pulls latest)
Invoke-WebRequest -Uri "https://downloads.1password.com/win/1PasswordSetup-latest.exe" -OutFile "$PSScriptRoot\..\1Password.exe"
Start-Process -Filepath "$PSScriptRoot\..\1Password.exe"

# Mullvad VPN (always pulls latest)
Invoke-WebRequest -Uri "https://mullvad.net/en/download/app/exe/latest" -OutFile "$PSScriptRoot\..\Mullvad.exe"
Start-Process -Filepath "$PSScriptRoot\..\Mullvad.exe"

Write-Host "Finished installing .exe apps!" -ForegroundColor Black -BackgroundColor White
Write-Host "%%% winInit Finished! %%%" -ForegroundColor Black -BackgroundColor White