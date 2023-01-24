#!/usr/bin/env sh

export SRC_URL="https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz"

# Install dependencies 
sudo apt update
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev libbluetooth-dev -y

# Download Python
wget -q -O- $SRC_URL | tar -xz

# Configure installation
cd Python-3.* && ./configure --enable-optimizations
if [ $(nproc) -ge 2 ]; then
    make -j $(nproc)
else
    make
fi

# Install Python
sudo make install

# Remove old Python
sudo apt remove python3 -y && sudo apt autoremove -y
cd .. && sudo rm -rf Python-3.*

# Make aliases
echo 'alias python="python3"' >> ~/.zshrc
echo 'alias pip="python3 -m pip"' >> ~/.zshrc