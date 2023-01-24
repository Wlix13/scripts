#!/usr/bin/env sh

# Install ZSH prompt
sudo apt update
sudo apt install zsh wget curl -y 

sudo usermod -s /usr/bin/zsh $(whoami) 
echo $SHELL

# Install Oh-My-ZSH
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Install Starship
curl -fsSL https://starship.rs/install.sh | sh

# Add to .zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Add support for FiraCode Nerd Font
sudo apt install fontconfig -y 
export SRC_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip"
wget -q $SRC_URL -O /tmp/FiraCode.zip
unzip /tmp/FiraCode.zip -d ~/.local/share/fonts && rm /tmp/FiraCode.zip
fc-cache -fv

# Install Nerd Font Symbols Preset
mkdir -p ~/.config && touch ~/.config/starship.toml
wget https://starship.rs/presets/toml/nerd-font-symbols.toml -O ~/.config/starship.toml

# Install zsh-autosuggestions
sudo apt install git -y 
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i "s/plugins=(git)/plugins=(\ngit\nzsh-autosuggestions\n)/" ~/.zshrc

# Install optional tools
sudo apt install tmux mc locales gcc g++ ssh-keygen -y

# Configure locales
sudo dpkg-reconfigure locales