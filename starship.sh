#!/usr/bin/env sh


# Install ZSH prompt
sudo apt install zsh -y 
sudo usermod -s /usr/bin/zsh $(whoami) 
echo $SHELL

# Install Oh-My-ZSH
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Starship
curl -sS https://starship.rs/install.sh | sh

# Install Starship theme
wget https://starship.rs/presets/toml/nerd-font-symbols.toml -O ~/.config/starship.toml

