#!/bin/bash

# ----------------------------- #
# Install btop

sudo apt install btop -y

echo "alias top='btop'" >> ~/.zshrc

# ----------------------------- #
# Install neovim
sudo apt install xsel -y

# Check for architecture
if [ "$(uname -m)" = "x86_64" ]; then
    echo "Architecture: x86_64"
    curl -fsSLO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod +x nvim.appimage
    ./nvim.appimage --appimage-extract
    sudo mv squashfs-root /usr/bin/nvim-source
    sudo ln -s /usr/bin/nvim-source/AppRun /usr/bin/nvim
    rm nvim.appimage
elif [ "$(uname -m)" = "aarch64" ]; then
    echo "Architecture: aarch64"
    sudo apt install snapd -y
    sudo snap install core
    sudo snap install nvim --classic
    sudo ln -s /snap/bin/nvim /usr/bin/nvim
    rm -rf snap
else
    echo "Architecture: Unknown"
    echo "Exiting..."
    exit 1
fi

# Setup NvChad
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
echo "alias vim='nvim'" >> ~/.zshrc
source ~/.zshrc
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# Fix cursor
echo "" >> ~/.config/nvim/init.lua
cat ./configs/nvim/init.lua >> ~/.config/nvim/init.lua

# Add plugins support
sed -i "s/local M = {}/local M = {}\n M.plugins = 'custom.plugins'/" ~/.config/nvim/lua/custom/chadrc.lua
cp ./configs/nvim/plugins.lua ~/.config/nvim/lua/custom/plugins.lua

# Change theme
sed -i "s/onedark/tokyonight/" ~/.config/nvim/lua/custom/chadrc.lua

echo "--- Plugins options ---" >> ~/.config/nvim/lua/core/init.lua
echo "g.suda_smart_edit = 1" >> ~/.config/nvim/lua/core/init.lua

# ----------------------------- #
# Install tmux from source

sudo apt install libevent-dev ncurses-dev build-essential bison pkg-config -y
curl -fsSL https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz --output tmux.tar.gz
tar -zxf tmux.tar.gz && rm -f tmux.tar.gz
cd tmux-*/
./configure
make && sudo make install
cd .. && rm -rf tmux-*

# Install TPM(Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
mkdir -p ~/.config/tmux

# Setup TPM config
cp ./configs/tmux/tmux.conf ~/.config/tmux/tmux.conf

echo "Done! Run 'tmux' to start tmux and press 'prefix + I' to install plugins."
