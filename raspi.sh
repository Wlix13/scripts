#!/usr/bin/env sh

# Create a my user
read -p "Username: " USERNAME
adduser $USERNAME

# Install basics
apt update
apt upgrade
apt install sudo wpasupplicant -y
usermod -aG sudo $USERNAME

# Change hostname
read -p "Hostname: " HOSTNAME
echo $HOSTNAME > /etc/hostname
echo "127.0.0.1 $HOSTNAME" >> /etc/hosts

# Wi-Fi credentials input
read -p "Wi-Fi SSID: " SSID
read -p "Wi-Fi Passphrase: " PSK

# Create a wpa_supplicant.conf file
cp .config/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant.conf
sed -i "0,/ssid/s/ssid=/ssid=$SSID/" /etc/wpa_supplicant.conf
sed -i "0,/psk/s/psk=/psk=$PSK/" /etc/wpa_supplicant.conf

# Auto-connect to Wi-Fi at boot(make wpa_supplicant.service file)
cp .config/wpa_supplicant/wpa_supplicant.service /etc/systemd/system/wpa_supplicant.service

# Auto-obtain IP address(make dhclient.service file)
cp .config/wpa_supplicant/dhclient.service /etc/systemd/system/dhclient.service

# Enable services
systemctl daemon-reload
systemctl enable wpa_supplicant.service
systemctl enable dhclient.service
