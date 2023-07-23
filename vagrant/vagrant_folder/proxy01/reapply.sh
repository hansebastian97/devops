#!/bin/bash

set -e
PROJECT_NAME="proxy"

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

sudo systemctl reload nginx