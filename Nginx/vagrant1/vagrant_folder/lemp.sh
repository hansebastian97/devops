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

# Initial
SUDO apt update -y && SUDO apt upgrade -y

# Install required packages
# Nginx
SUDO apt install nginx -y
SUDO ufw allow 'Nginx HTTP'
SUDO ufw allow 'Nginx HTTPS'
SUDO systemctl enable ufw
SUDO ufw enable
SUDO ufw allow 'Nginx HTTPS'
SUDO ufw allow 'Nginx HTTPS'
SUDO rm -rf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default


# NVM
echo $PASSWD | sudo -S apt install wget -y
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.nvm/nvm.sh
nvm install $NODE_VERSION

# PM2
npm install pm2 -g

# Setup project directory
if [ -d "/srv/$PROJECT_NAME/" ]; then
    SUDO rm -rf /srv/$PROJECT_NAME/
fi
SUDO git clone https://github.com/hansebastian97/note_app.git /srv/$PROJECT_NAME
SUDO chown -R $USER:$USER /srv/$PROJECT_NAME
SUDO chmod -R 755 /srv/$PROJECT_NAME

# Start project
cd /srv/$PROJECT_NAME
npm install
pm2 start server.js

# Nginx config
cat <<'EOF' > $HOME/$PROJECT_NAME.conf
server{
    listen 80;
    listen [::]:80;


    server_name 192.168.56.20;

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
    SUDO mv $HOME/$PROJECT_NAME.conf /etc/nginx/sites-available/$PROJECT_NAME.conf
    SUDO ln -s /etc/nginx/sites-available/$PROJECT_NAME.conf /etc/nginx/sites-enabled
fi
SUDO systemctl restart nginx
exit