#!/bin/bash

# Update the package index and install required dependencies
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add the official Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add the Docker repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again and install Docker Engine
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add the current user to the 'docker' group to run Docker without sudo
sudo usermod -aG docker $USER
useradd -m -s /bin/bash -G sudo,docker hansebastian97
newgrp docker
# Enable Docker to start on boot
sudo systemctl enable docker

# Display Docker version
docker version
exit