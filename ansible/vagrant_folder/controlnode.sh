#!/bin/bash

# Create SSH keys
# ssh-keygen -t rsa -f "/vagrant/ssh_key" -m PEM

# openssl rsa -in /vagrant/ssh_key -outform pem > ssh_key.pem

# ssh-keygen -f /vagrant/ssh_key.pub -e -m pem > /vagrant/ssh_key.pub.pem


# Copy SSH keys
cat >> /home/vagrant/.ssh/authorized_keys <<EOF
$(cat /vagrant/ssh_key.pub)
EOF

cp /vagrant/ssh_key.pem /home/vagrant/.ssh/
chmod 600 /home/vagrant/.ssh/ssh_key.pem

sudo apt update -y
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
# sudo apt install ansible -y