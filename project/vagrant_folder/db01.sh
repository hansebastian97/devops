#!/bin/bash
DATABASE_PASS="17101997"
# Update required packages
sudo yum update -y
sudo yum install epel-release -y
sudo yum install git zip unzip -y

# Install Mariadb
sudo yum install mariadb-server -y

# Start Mariadb service
sudo systemctl start mariadb
sudo systemctl enable mariadb



