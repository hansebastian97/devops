#!/bin/bash

set -e

#Variables
PROJECT_NAME="proxy"


sudo apt update
sudo apt install net-tools
# sudo apt upgrade -y

# Install Nginx
sudo apt install nginx -y

# Delete default template
if [ -f /etc/nginx/sites-available/default ]; then
    sudo rm /etc/nginx/sites-available/default
    sudo rm /etc/nginx/sites-enabled/default
fi

# Setup Nginx configuration
if [ -f "/etc/nginx/sites-available/$PROJECT_NAME.conf" ]; then
    sudo rm /etc/nginx/sites-available/$PROJECT_NAME.conf
    sudo rm /etc/nginx/sites-enabled/$PROJECT_NAME.conf
fi


sudo cp /vagrant/nginx.conf /etc/nginx/sites-available/$PROJECT_NAME.conf
sudo ln -s /etc/nginx/sites-available/$PROJECT_NAME.conf /etc/nginx/sites-enabled


sudo systemctl restart nginx
