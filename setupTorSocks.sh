#!/bin/bash

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
sudo apt install tor -y

# SocksPort 9050
sudo sed -i "s/#SocksPort 9050/SocksPort 9050/" /etc/tor/torrc

# SafeSocks 1
# AutomapHostsOnResolve 1
# DnsPort 53
sudo sed -i "/SocksPort 9050/a SafeSocks 1\nAutomapHostsOnResolve 1\nDnsPort 53" /etc/tor/torrc

# SocksPolicy accept 127.0.0.1
# SocksPolicy reject *
sudo sed -i "s/#SocksPolicy accept 192.168.0.0\/16/SocksPolicy accept 127.0.0.1/" /etc/tor/torrc
sudo sed -i "s/#SocksPolicy reject/SocksPolicy reject/" /etc/tor/torrc

sudo systemctl enable --now tor
sudo systemctl restart tor
