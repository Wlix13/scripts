#!/usr/bin/env sh

# Install Starship
curl -fsSL https://starship.rs/install.sh | sudo sh
sed -i "s/ZSH_THEME=/# ZSH_THEME=/" ~/.zshrc

# Install additional tools
apt install zoxide direnv toilet -y

# Config for direnv to load dotenv files
mkdir -p ~/.config/direnv
cp ./configs/direnv/direnv.toml ~/.config/direnv/direnv.toml

# Add support for FiraCode Nerd Font
# latest_release=$(curl --silent "https://api.github.com/repos/tonsky/FiraCode/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
fonts_dir="~/.local/share/fonts"
[ ! -d $fonts_dir ] && mkdir -p $fonts_dir
latest_release=$(curl -s https://api.github.com/repos/tonsky/FiraCode/releases/latest | grep browser_download_url | cut -d '"' -f 4)
curl -fsSL $latest_release --output font.zip
unzip -oqd ${fonts_dir} font.zip && rm -f font.zip
fc-cache -fv

# Install Nerd Font Symbols Preset
touch ~/.config/starship.toml
curl -fsSL https://starship.rs/presets/toml/nerd-font-symbols.toml --output ~/.config/starship.toml

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Enable plugins
sed -i "s/plugins=(git)/plugins=(\ngit\nzsh-autosuggestions\nzsh-syntax-highlighting\n)/" ~/.zshrc

# Add to .zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
source ~/.zshrc
