#!/bin/bash

# Copy SSH keys
cat >> /home/vagrant/.ssh/authorized_keys <<EOF
$(cat /vagrant/ssh_key.pub)
EOF

cp /vagrant/ssh_key /home/vagrant/.ssh/
chmod 600 /home/vagrant/.ssh/ssh_key

# # Download Node Exporter
# wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz

# # Create User
# sudo groupadd -f node_exporter
# sudo useradd -g node_exporter --no-create-home --shell /bin/false node_exporter
# sudo mkdir /etc/node_exporter
# sudo chown node_exporter:node_exporter /etc/node_exporter

# # Unpack Node Exporter
# tar -xvf node_exporter-1.0.1.linux-amd64.tar.gz
# mv node_exporter-1.0.1.linux-amd64 node_exporter-files

# # Install Node Exporter
# # /usr/bin itu buat nyimpen executable files
# sudo cp node_exporter-files/node_exporter /usr/bin/
# sudo chown node_exporter:node_exporter /usr/bin/node_exporter

# # Create node_exporter service file
# cat << EOF > /usr/lib/systemd/system/node_exporter.service
# [Unit]
# Description=Node Exporter
# Documentation=https://prometheus.io/docs/guides/node-exporter/
# Wants=network-online.target
# After=network-online.target

# [Service]
# User=node_exporter
# Group=node_exporter
# Type=simple
# Restart=on-failure
# ExecStart=/usr/bin/node_exporter \
#   --web.listen-address=:9200

# [Install]
# WantedBy=multi-user.target
# EOF

# # Ganti file permissionnya
# sudo chmod 664 /usr/lib/systemd/system/node_exporter.service

# # Reload systemd dan start Node Exporter
# sudo systemctl daemon-reload
# sudo systemctl start node_exporter

# # Enable Node Exporter ad startup
# sudo systemctl enable node_exporter

