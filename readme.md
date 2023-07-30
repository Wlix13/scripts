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
  <a href="#scripts-list">Scripts list</a> •
  <a href="#contents">Contents</a> •
  <a href="#usage">Usage</a> •
  <a href="#contributing">Contributing</a>
</p>

# About
This repository contains scripts which I use to automate installing and configuring my systems. I use them to configure my personal computers, servers and Raspberry Pi. I hope you will find them useful.

## Scripts list:
1) [issue-cert.ps1](#issue-cert) - Issue OpenSSL certificate for local
2) [format-udf.sh](#format-udf) - Format USB drive to UDF
3) [zshprompt.sh](#zshprompt) - Installs starship prompt
4) [tools.sh](#tools) - Install different tools with preconfigured settings
5) [python.sh](#python) - Compile and install python 3.11.* from source
6) [raspi.sh](#raspi) - Automatically configure Raspberry Pi
7) [serverinfo.sh](#serverinfo) - Get information about server on login

## <center>Scripts description:</center>

### Zshprompt:
    - Install ZSH as default shell
    - Install Oh-My-ZSH framework
    - Install zsh-autosuggestions plugin
    - Install Starship prompt
    - Install Nerd Font Symbols Preset
    - FiraCode Nerd Font support
    - Configure locales
 
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

### Issue cert:
    - Create a self-signed certificate for local development

### Format UDF:
    - Format USB drive to UDF format

## Usage

Don't hesitate to use these scripts. You can use them as you wish. If you have any questions, please contact me.

## Contributing

If you want to contribute to this repository, please contact me. I will be glad to see your pull requests.

## License

This repository and its contents are licensed under the [MIT License](https://opensource.org/licenses/MIT).