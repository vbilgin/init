# init

A collection of files, scripts, and other bits to help me set up a new machine (Windows, macOS, Linux).

## Windows

Run the following commands in PowerShell (admin not needed but will be needed for scripts in the repo):

```powershell
Invoke-WebRequest 'https://github.com/vbilgin/init/archive/refs/heads/main.zip' -OutFile .\init.zip
Expand-Archive .\init.zip .\
Rename-Item .\init-main .\init
Remove-Item .\init.zip
```
