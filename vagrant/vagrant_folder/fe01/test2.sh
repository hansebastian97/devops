#!/bin/bash

NODE_VERSION="v18.16.0"
PROJECT_NAME="nodejs_frontend"
NEW_USER="vagrant"
GITHUB_REPO="https://github.com/hansebastian97/nodejs_frontend.git"



# Update package repositories and install required dependencies
sudo apt-get update
sudo apt-get install -y build-essential

# Install NVM (Node Version Manager) for the new user
sudo -u $NEW_USER wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Load NVM into the current shell for the new user
export NVM_DIR="/home/$NEW_USER/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js and npm using NVM for the new user
su - $NEW_USER -c "nvm install node"

# Install PM2 globally for the new user
su - $NEW_USER -c "npm install -g pm2"

