#!/bin/bash

set -e

#Variables
PASSWD="vagrant"
NODE_VERSION="v18.16.0"
PROJECT_NAME="nodejs_products"
USER="vagrant"
GITHUB_REPO="https://github.com/hansebastian97/nodejs_products.git"

sudo apt update
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
ln -s /etc/nginx/sites-available/$PROJECT_NAME.conf /etc/nginx/sites-enabled

# sudo cp /vagrant/apicall.js /srv/$PROJECT_NAME/src/utils/apicall.js
# sudo chown -R $USER:$USER /srv/$PROJECT_NAME
# sudo chmod -R 755 /srv/$PROJECT_NAME

# Install NVM and NodeJS
sudo apt update
sudo apt install wget -y
sudo -H -u vagrant bash -c "wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash"
source "/home/vagrant/.nvm/nvm.sh"
nvm install $NODE_VERSION

# Install pm2
sudo apt update
npm install pm2 -g

# Setup project
# Download projects (Frontend)
# Setup project directory
if [ -d "/home/vagrant/srv/$PROJECT_NAME/" ]; then
    sudo rm -rf /home/vagrant/srv/$PROJECT_NAME/
fi

mkdir -p /home/vagrant/srv/
cd /home/vagrant/srv/

# Declare github username and email
git config --global user.name "hansebastian97"
git clone -b main "$GITHUB_REPO"
sudo chown -R $USER:$USER /home/vagrant/srv/
sudo chmod -R 755 /home/vagrant/srv/

sudo apt update
cd /home/vagrant/srv/$PROJECT_NAME
npm install
pm2 start npm --name "Products" -- start

sudo systemctl restart nginx