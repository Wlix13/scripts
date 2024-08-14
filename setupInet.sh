#!/bin/bash

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
sudo apt install curl iputils-ping git net-tools dnsutils mtr -y

# Install & configure systemd-resolved
sudo apt install libnss-resolve -y
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sudo cp ./configs/etc/systemd/resolved.conf /etc/systemd/resolved.conf

# Setup Firewall
sudo apt install ufw -y

sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw default allow forward
sudo ufw allow 443
sudo ufw allow 8443
sudo ufw allow 22443
sudo ufw disable && echo y | sudo ufw enable
sudo ufw status verbose

# Setup SSH
# TODO: Use better sed streams
sudo sed -i "s/#Port 22$/Port 22443/" /etc/ssh/sshd_config
sudo sed -i "s/Port 22$/Port 22443/" /etc/ssh/sshd_config
sudo sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
sudo sed -i "s/PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
sudo sed -i "s/#UseDNS no/UseDNS yes/" /etc/ssh/sshd_config
sudo sed -i "s/UseDNS no/UseDNS yes/" /etc/ssh/sshd_config
sudo systemctl restart sshd

# Add network optimizations
cat ./configs/etc/sysctl.conf | sudo tee -a /etc/sysctl.conf
sudo sysctl --system

# Enable and start systemd-resolved
sudo systemctl enable --now systemd-resolved
sudo systemctl restart systemd-resolved
