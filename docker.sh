#!/usr/bin/env sh

# Download docker script
curl -fsSL https://get.docker.com -o get-docker.sh

# Install docker
sudo sh get-docker.sh

# Add user to docker group
sudo usermod -aG docker $(whoami)
