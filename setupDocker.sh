#!/usr/bin/env sh

# Download docker script
curl -fsSL https://get.docker.com -o get-docker.sh

# Install docker
sudo sh get-docker.sh

# Install docker-compose
sudo apt install docker-compose

# Add user to docker group
sudo usermod -aG docker $(whoami)