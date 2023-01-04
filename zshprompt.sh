#!/usr/bin/env sh

# Install ZSH prompt
sudo apt install zsh -y 
sudo usermod -s /usr/bin/zsh $(whoami) 
echo $SHELL

# Install Oh-My-ZSH
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Remind user to add plugins
echo "Add the plugin to the list of plugins for Oh My Zsh to load (inside ~/.zshrc):"
echo "zsh-autosuggestions"

# Install Starship
curl -sS https://starship.rs/install.sh | sh

# Add to .zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Install Nerd Font Symbols Preset
mkdir -p ~/.config && touch ~/.config/starship.toml
wget https://starship.rs/presets/toml/nerd-font-symbols.toml -O ~/.config/starship.toml