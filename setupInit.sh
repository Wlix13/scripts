#!/usr/bin/env sh

# Update system
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y && sudo apt autoclean -y

# Install zsh shell
sudo apt install zsh -y

# Change shell
sudo usermod -s /usr/bin/zsh $(whoami)

# Install basics
sudo apt install gcc g++ wget curl unzip git locales fontconfig -y

# Install Oh-My-zsh
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Set timezone
sudo timedatectl set-timezone Europe/Moscow

# Configure locales
sudo dpkg-reconfigure locales

# Init zsh
mkdir -p ~/.config
zsh && exit
