#!/bin/bash
# Install Docker Engine (Latest)
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Test Docker Engine Installation
sudo docker run hello-world
sudo systemctl enable docker


# Add your user to Docker group
sudo usermod -aG docker vagrant

# Create user
useradd -m -s /bin/bash -G sudo,docker hansebastian97

exit