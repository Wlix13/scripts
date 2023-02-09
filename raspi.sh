#!/usr/bin/env sh

# Create a my user
read  -p "Username: " USERNAME
adduser $USERNAME

# Install basics
apt update
apt install sudo wpasupplicant -y
usermod -aG sudo $USERNAME

# Wi-Fi credentials input
read  -p "Wi-Fi SSID: " SSID
read  -p "Wi-Fi Passphrase: " PSK

# Create a wpa_supplicant.conf file
echo "ctrl_interface=DIR=/var/run/wpa_supplicant" | tee -a /etc/wpa_supplicant.conf
echo "update_config=1" | tee -a /etc/wpa_supplicant.conf
echo "country=RU" | tee -a /etc/wpa_supplicant.conf
echo "network={" | tee -a /etc/wpa_supplicant.conf
echo "ssid=\"$SSID\"" | tee -a /etc/wpa_supplicant.conf
echo "psk=\"$PSK\"" | tee -a /etc/wpa_supplicant.conf
echo "key_mgmt=WPA-PSK" | tee -a /etc/wpa_supplicant.conf
echo "scan_ssid=1" | tee -a /etc/wpa_supplicant.conf
echo "}" | tee -a /etc/wpa_supplicant.conf

# Auto-connect to Wi-Fi at boot(make wpa_supplicant.service file)
echo "[Unit]" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "Description=WPA supplicant daemon" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "Before=network.target" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "After=dbus.service" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "Wants=network.target" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "IgnoreOnIsolate=true" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "[Service]" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "Type=dbus" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "BusName=fi.w1.wpa_supplicant1" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "ExecStart=/sbin/wpa_supplicant -u -s -c /etc/wpa_supplicant.conf -i wlan0" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "Restart=always" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "ExecReload=/bin/kill -HUP $MAINPID" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "Group=netdev" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "RuntimeDirectory=wpa_supplicant" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "RuntimeDirectoryMode=0750" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "[Install]" | tee -a /etc/systemd/system/wpa_supplicant.service
echo "WantedBy=multi-user.target" | tee -a /etc/systemd/system/wpa_supplicant.service

# Auto-obtain IP address(make dhclient.service file)
echo "[Unit]" | tee -a /etc/systemd/system/dhclient.service
echo "Description=DHCP Client" | tee -a /etc/systemd/system/dhclient.service
echo "Before=network.target" | tee -a /etc/systemd/system/dhclient.service
echo "After=wpa_supplicant.service" | tee -a /etc/systemd/system/dhclient.service
echo "" | tee -a /etc/systemd/system/dhclient.service
echo "[Service]" | tee -a /etc/systemd/system/dhclient.service
echo "Type=forking" | tee -a /etc/systemd/system/dhclient.service
echo "ExecStart=/sbin/dhclient wlan0 -v" | tee -a /etc/systemd/system/dhclient.service
echo "ExecStop=/sbin/dhclient wlp4s0 -r" | tee -a /etc/systemd/system/dhclient.service
echo "Restart=always" | tee -a /etc/systemd/system/dhclient.service
echo "" | tee -a /etc/systemd/system/dhclient.service
echo "[Install]" | tee -a /etc/systemd/system/dhclient.service
echo "WantedBy=multi-user.target" | tee -a /etc/systemd/system/dhclient.service

# Enable services
systemctl daemon-reload
systemctl enable wpa_supplicant.service
systemctl enable dhclient.service