#!/bin/bash

#Variables
PASSWD="vagrant"
NODE_VERSION="v18.16.0"
PROJECT_NAME="anjaymabar.com"

#Custom SUDO function
SUDO() {
    local COMMAND="$@"
    eval "echo $PASSWD | sudo -S $COMMAND"
}


SUDO apt update -y
# NVM
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.nvm/nvm.sh
# nvm install $NODE_VERSION

# wget -qO nvm_script.sh https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh
# chmod +x nvm_script.sh 
# source ./nvm_script.sh
# rm nvm_script.sh