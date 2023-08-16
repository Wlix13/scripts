#!/usr/bin/env sh

# Install ZSH prompt
sudo apt update
sudo apt upgrade -y
sudo apt install zsh wget curl unzip git locales fontconfig toilet screenfetch -y

sudo usermod -s /usr/bin/zsh $(whoami)

# Install Oh-My-ZSH
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
zsh && exit

# Install Starship
curl -fsSL https://starship.rs/install.sh | sudo sh
sed -i "s/ZSH_THEME=/#ZSH_THEME=/" ~/.zshrc

# Add to .zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Add support for FiraCode Nerd Font
fonts_dir="~/.local/share/fonts"
if [ ! -d "${fonts_dir}" ]; then
    mkdir -p "${fonts_dir}"
fi
version=6.2
zip=Fira_Code_v${version}.zip
curl --fail --location --show-error https://github.com/tonsky/FiraCode/releases/download/${version}/${zip} --output ${zip}
unzip -o -q -d ${fonts_dir} ${zip} && rm ${zip}
fc-cache -fv

# Install Nerd Font Symbols Preset
mkdir -p ~/.config && touch ~/.config/starship.toml
wget https://starship.rs/presets/toml/nerd-font-symbols.toml -O ~/.config/starship.toml

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i "s/plugins=(git)/plugins=(\ngit\nzsh-autosuggestions\n)/" ~/.zshrc

# Configure locales
sudo dpkg-reconfigure locales