#!/usr/bin/env sh

export SRC_URL="https://www.python.org/ftp/python/3.10.7/Python-3.10.7.tgz"

# Install dependencies 
sudo apt update
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev


# TODO: Download latest stable version of Python
# Download Python
wget -q -O- $SRC_URL | tar -xz

# Configure installation
cd Python-3.* && ./configure --enable-optimizations
make -j &(nproc)

# Install Python
sudo make install

# Remove old Python
sudo apt remove python3 && sudo apt autoremove
rm -rf Python-3.*

# Make aliases
echo 'alias python="python3"' >> ~/.zshrc
echo 'alias pip="python3 -m pip"' >> ~/.zshrc