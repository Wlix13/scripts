#!/usr/bin/env sh

# Install-update basics
sudo apt update && sudo apt upgrade -y
sudo apt install sudo gcc g++ -y

# Check for architecture
if [ "$(uname -m)" = "x86_64" ]; then
    echo "Architecture: x86_64"
    # Install neovim(Linux x86_64)
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract
    sudo mv squashfs-root /usr/bin/nvim-source
    sudo ln -s /usr/bin/nvim-source/AppRun /usr/bin/nvim
    rm nvim.appimage
elif [ "$(uname -m)" = "aarch64" ]; then
    echo "Architecture: aarch64"
    # Install neovim(Raspberry Pi)
    sudo apt install snapd -y
    sudo snap install core
    sudo snap install nvim --classic
    sudo ln -s /snap/bin/nvim /usr/bin/nvim
else
    echo "Architecture: Unknown"
    echo "Exiting..."
    exit 1
fi

# Setup NeoVIM Chad
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
echo "alias vim='nvim'" >> ~/.zshrc
source ~/.zshrc
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

# Fix cursor
echo "-- Change cursor to original after exiting vim" >> ~/.config/nvim/init.lua
echo "vim.api.nvim_create_autocmd(\"VimLeave\", {" >> ~/.config/nvim/init.lua
echo "  callback = function()" >> ~/.config/nvim/init.lua
echo "    vim.api.nvim_command('set guicursor= | call chansend(v:stderr, \"\x1b[ q\")')" >> ~/.config/nvim/init.lua
echo "  end" >> ~/.config/nvim/init.lua
echo "})" >> ~/.config/nvim/init.lua

# ----------------------------- #

# Install tmux from source
sudo apt install libevent-dev ncurses-dev build-essential bison pkg-config -y
wget https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz
tar -zxf tmux-*.tar.gz && rm -f tmux-*.tar.gz
cd tmux-*/
./configure
make && sudo make install
cd .. && rm -rf tmux-*

# Install TPM(Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
mkdir ~/.config/tmux
touch ~/.config/tmux/tmux.conf

# Setup TPM config
echo "# Support for colors and mouse" >> ~/.config/tmux/tmux.conf
echo "set-option -sa terminal-overrides \",xterm*:Tc\"" >> ~/.config/tmux/tmux.conf
echo "set -g mouse on" >> ~/.config/tmux/tmux.conf
echo "# Shift Alt vim keys to switch windows" >> ~/.config/tmux/tmux.conf
echo "bind -n M-H previous-window" >> ~/.config/tmux/tmux.conf
echo "bind -n M-L next-window" >> ~/.config/tmux/tmux.conf
echo "# Start windows and panes at 1, not 0" >> ~/.config/tmux/tmux.conf
echo "set -g base-index 1" >> ~/.config/tmux/tmux.conf
echo "set -g pane-base-index 1" >> ~/.config/tmux/tmux.conf
echo "set-window-option -g pane-base-index 1" >> ~/.config/tmux/tmux.conf
echo "set-option -g renumber-windows on" >> ~/.config/tmux/tmux.conf
echo "# Open pane in same directory" >> ~/.config/tmux/tmux.conf
echo "bind '\"' split-window -v -c \"#{pane_current_path}\"" >> ~/.config/tmux/tmux.conf
echo "bind % split-window -h -c \"#{pane_current_path}\"" >> ~/.config/tmux/tmux.conf
echo "# Plugins" >> ~/.config/tmux/tmux.conf
echo "set -g @plugin 'tmux-plugins/tpm'" >> ~/.config/tmux/tmux.conf
echo "set -g @plugin 'tmux-plugins/tmux-sensible'" >> ~/.config/tmux/tmux.conf
echo "set -g @plugin 'janoamaral/tokyo-night-tmux'" >> ~/.config/tmux/tmux.conf
echo "run '~/.tmux/plugins/tpm/tpm'" >> ~/.config/tmux/tmux.conf

tmux source ~/.config/tmux/tmux.conf