#!/bin/bash

set -e

#Variables
PASSWD="vagrant"
NODE_VERSION="v18.16.0"
PROJECT_NAME="shopping_cart.com"
USER="vagrant"
GITHUB_REPO="https://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@github.com/hansebastian97/nodejs_frontend.git"

sudo apt update -y
# sudo apt upgrade -y

# Install Nginx
sudo apt install nginx -y

# Delete default template
if [ -f /etc/nginx/sites-available/default ]; then
    sudo rm /etc/nginx/sites-available/default
    sudo rm /etc/nginx/sites-enabled/default
fi

# Setup project directory
if [ -d "/srv/$PROJECT_NAME/" ]; then
    sudo rm -rf /srv/$PROJECT_NAME/
    mkdir /srv/$PROJECT_NAME/
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
sudo apt install wget -y
sudo -H -u vagrant bash -c "wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash"
source "/home/vagrant/.nvm/nvm.sh"
nvm install $NODE_VERSION

# Install pm2
npm install pm2 -g

# Setup project
# Download projects (Frontend)
mkdir /srv/$PROJECT_NAME
cd /srv/$PROJECT_NAME
git clone -b main "$GITHUB_REPO"
sudo chown -R $USER:$USER /srv/$PROJECT_NAME
sudo chmod -R 755 /srv/$PROJECT_NAME

npm install
pm2 start npm --name "Shopping Cart" -- start



sudo systemctl restart nginx

exit