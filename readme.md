<h2 align="center">Scripts which I use to automate installing and configuring my systems.</h2>

<p align="center">
    <a href="https://github.com/wlix13/scripts/commits/master">
    <img src="https://img.shields.io/github/last-commit/wlix13/scripts.svg?style=flat-square&logo=github&logoColor=white"
         alt="GitHub last commit">
    <a href="https://github.com/wlix13/scripts/issues">
    <img src="https://img.shields.io/github/issues-raw/wlix13/scripts.svg?style=flat-square&logo=github&logoColor=white"
         alt="GitHub issues">
</p>

<p align="center">
  <a href="#about">About</a> •
  <a href="#bash-scripts">Bash scripts</a> •
  <a href="#powershell-scripts">PowerShell scripts</a> •
  <a href="#scripts-description">Description</a> •
  <a href="#usage">Usage</a> •
  <a href="#contributing">Contributing</a>
</p>

# <center>About</center>
This repository contains scripts which I use to automate installing and configuring my systems. I use them to configure my personal computers, servers, and Raspberry Pi. I hope you will find them useful.

## Bash scripts:
1) [zshprompt.sh](#zshprompt) - Installs starship prompt
2) [tools.sh](#tools) - Install different tools with preconfigured settings
3) [python.sh](#python) - Compile and install python 3.11.* from source
4) [raspi.sh](#raspi) - Automatically configure Raspberry Pi
5) [serverinfo.sh](#serverinfo) - Get information about server on login

## PowerShell scripts:
1) [Microsoft.PowerShell_profile.ps1](#powershell_profile) - PowerShell profile.
2) [functions.ps1](#functions) - Custom functions.
3) [install_modules.ps1](#install_modules) - Install PowerShell modules.
4) [issue-cert.ps1](#issue-cert) - Issue OpenSSL certificate for local development.

# <center>Scripts description</center>

## Bash scripts description:

### Zshprompt:
   - Install zsh as default shell
   - Install Oh My Zsh framework and plugins
   - Install Starship prompt
   - Install Nerd Font Symbols Preset and FiraCode Nerd Font
   - Install additional tools:
     - zoxide
     - direnv 
     - screenfetch
   - Configure locales

### Tools:
   - Install neovim and configure it
   - Install tmux with TPM(Tmux Plugin Manager)

### Python:
   - Install all dependencies(for bluetooth support too)
   - Download Python 3.11 source code
   - Compile and install Python
   - Clean up old versions

### Raspi:
   - Create user and add it to sudo group
   - Create wpa_supplicant config file
   - Create Wi-Fi services 

### Serverinfo:
   - Uptime
   - Memory usage
   - Disk usage
   - Get information about running services(set in script)
   - Docker containers status

## PowerShell scripts description:

### PowerShell_profile
   - Configs and variables
   - Tools invoking
   - Aliases
   - Modules importing

### Functions
   - Overwrite default functions
     - New-Alias (Now it doesn't create alias if it already exists)
     - Set-Location (Auto load .env file into environment if it in current directory)
   - Add custom functions
     - Get-TimePythonScript
     - ConvertTo-PDF
     - Convert-ToJpeg

### Install modules
   - Install modules from PowerShell Gallery
   <!-- TODO: - Install modules from local directory -->

### Issue cert:
   - Create a self-signed certificate for local development

## Usage

Don't hesitate to use these scripts. You can use them as you wish. If you have any questions, please contact me.

## Contributing

If you want to contribute to this repository, please contact me. I will be glad to see your pull requests.
