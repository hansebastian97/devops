#!/bin/bash
# Setup NodeJS
set -e

#Variables
NODE_VERSION="v18.16.0"
PROJECT_NAME="shopping_cart.com"
USER="vagrant"



# Run PM2
cd /srv/$PROJECT_NAME
npm install
sudo chown -R $USER:$USER /srv/$PROJECT_NAME
sudo chmod -R 755 /srv/$PROJECT_NAME

pm2 start npm --name "Shopping Cart" -- start



sudo systemctl restart nginx

exit