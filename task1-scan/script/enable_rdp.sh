#!/bin/bash

#Make sure you create a user "infosecuser"

# Update system
sudo apt update && sudo apt upgrade -y

# Install XFCE desktop and xRDP
sudo apt install -y xrdp xfce4 xfce4-goodies dbus-x11

# Set XFCE as default session
echo "xfce4-session" > ~/.xsession

# Fix xrdp startup script to start XFCE instead of GNOME
sudo cp /etc/xrdp/startwm.sh /etc/xrdp/startwm.sh.bak
sudo sed -i '/^test -x \/etc\/X11\/Xsession/ c\startxfce4' /etc/xrdp/startwm.sh


# Add new user "infosecuser" to ssl-cert group (needed by xrdp)
sudo adduser infosecuser ssl-cert

# Enable and restart xrdp service
sudo systemctl enable xrdp
sudo systemctl restart xrdp

# Done
echo "✅ RDP setup complete. Please reboot and connect using RDP."
