#!/usr/bin/env sh

# Install ZSH prompt
sudo apt update
sudo apt upgrade -y
sudo apt install zsh wget curl unzip git locales fontconfig -y

sudo usermod -s /usr/bin/zsh $(whoami)
echo $SHELL
zsh

# Install Oh-My-ZSH
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Install Starship
curl -fsSL https://starship.rs/install.sh | sudo sh
sed -i "s/ZSH_THEME=/#ZSH_THEME=/" ~/.zshrc

# Add support for FiraCode Nerd Font
export SRC_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip"
wget -q $SRC_URL -O ~/FiraCode.zip
unzip ~/FiraCode.zip -d ~/.local/share/fonts && rm -rf ~/FiraCode.zip
fc-cache -fv

# Install Nerd Font Symbols Preset
mkdir -p ~/.config && touch ~/.config/starship.toml
wget https://starship.rs/presets/toml/nerd-font-symbols.toml -O ~/.config/starship.toml

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i "s/plugins=(git)/plugins=(\ngit\nzsh-autosuggestions\n)/" ~/.zshrc

# Add to .zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Configure locales
sudo dpkg-reconfigure locales