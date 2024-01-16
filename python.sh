#!/usr/bin/env sh

SRC_URL="https://www.python.org/ftp/python/3.11.6/Python-3.11.6.tgz"

# Install dependencies
sudo apt update
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev liblzma-dev libbluetooth-dev -y

# Download Python
curl -fsSL $SRC_URL --output python.tar.gz
tar -zxf python.tar.gz && rm -f python.tar.gz

# Configure installation
cd Python-3.* && ./configure --enable-optimizations
if [ $(nproc) -ge 2 ]; then
    make -j $(nproc)
else
    make
fi

# Install Python
sudo make altinstall
python3 -m pip install --upgrade pip

# Clean up
cd .. && sudo rm -rf Python-3.*

# Make aliases
echo 'alias python="python3"' >> ~/.zshrc
echo 'alias pip="python3 -m pip"' >> ~/.zshrc
source ~/.zshrc
