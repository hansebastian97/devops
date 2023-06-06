#!/bin/bash

PASSWD="vagrant"
NODE_VERSION="v18.16.0"
PROJECT_NAME="anjaymabar.com"
SUDO() {
    local COMMAND="$@"
    eval "echo $PASSWD | sudo -S $COMMAND"
}

# Nginx config
cat <<'EOF' > /$PROJECT_NAME.conf
server{
    listen 80;
    listen [::]:80;


    server_name 192.168.56.200;

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_pass http://localhost:3000/;
        proxy_redirect http://localhost:3000/ http://$server_name;
    }
}
EOF

if [ ! -f "/etc/nginx/sites-available/$PROJECT_NAME.conf" ]; then
    SUDO rm /etc/nginx/sites-enabled/$PROJECT_NAME.conf
    SUDO mv /$PROJECT_NAME.conf /etc/nginx/sites-available/$PROJECT_NAME.conf
    SUDO ln -s /etc/nginx/sites-available/$PROJECT_NAME.conf /etc/nginx/sites-enabled
fi
SUDO systemctl restart nginx