#!/bin/bash

set -e

#Variables
PASSWD="vagrant"
NODE_VERSION="v18.16.0"
PROJECT_NAME="nodejs_customer"
NEW_USER="vagrant"
GITHUB_REPO="https://github.com/hansebastian97/nodejs_shopping.git"


sudo apt update
# sudo apt upgrade -y

echo ""
echo "##############################"
echo "Installing Nginx"
echo "##############################" 
echo ""

# Install Nginx
sudo apt install nginx -y

# Delete default template
if [ -f /etc/nginx/sites-available/default ]; then
    sudo rm /etc/nginx/sites-available/default
    sudo rm /etc/nginx/sites-enabled/default
fi

# Copy Nginx Config
sudo cp /vagrant/nginx.conf /etc/nginx/sites-available/$PROJECT_NAME.conf
sudo ln -s /etc/nginx/sites-available/$PROJECT_NAME.conf /etc/nginx/sites-enabled

echo ""
echo "##############################"
echo "Successfully installed Nginx!"
echo "##############################" 
echo ""


echo ""
echo "##############################"
echo "Installing NodeJS"
echo "##############################" 
echo ""

# Install NVM and NodeJS
sudo apt update
sudo apt install wget -y
sudo -H -u $NEW_USER bash -c "wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash"
source "/home/vagrant/.nvm/nvm.sh"
nvm install $NODE_VERSION

echo ""
echo "##############################"
echo "Successfully installed NodeJS!"
echo "##############################" 
echo ""

echo ""
echo "##############################"
echo "Setup Project!"
echo "##############################" 
echo ""

# Setup Project
mkdir -p /home/vagrant/srv/
cd /home/vagrant/srv/

# Declare github username and email
git config --global user.name "hansebastian97"
git clone -b main "$GITHUB_REPO"
sudo chown -R $USER:$USER /home/vagrant/srv/
sudo chmod -R 755 /home/vagrant/srv/
sudo apt update

# Installing PM2
npm install -g pm2

# Setup directory for app
cd /home/vagrant/srv/$PROJECT_NAME
npm install
pm2 start npm --name "Shopping Cart" -- run "start"
pm2 save

# Start NPM
sudo systemctl restart nginx