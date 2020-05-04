#!/bin/bash

PROJECT_NAME="nodejs"
TOP_LEVEL_DOMAIN="local"
SERVER_NAME="$PROJECT_NAME.$TOP_LEVEL_DOMAIN"
nginx=stable

Update() {
    echo "-- Update packages --"
    sudo apt-get update -y
    # apt get upgrade without any prompt
    sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
}

Update

echo "-- Add PPA --"
sudo add-apt-repository ppa:nginx/$nginx -y

Update

echo "-- Installing Nginx --"
sudo apt install -y nginx

echo "-- Configure Nginx --"
sudo ufw allow "Nginx Full"
sudo ufw allow "OpenSSH"
yes | sudo ufw enable

echo "-- Create Server Block --"
sudo rm /etc/nginx/sites-available/${SERVER_NAME} -f
sudo cat <<EOF | sudo tee -a /etc/nginx/sites-available/${SERVER_NAME}
upstream ${SERVER_NAME} {
    server 127.0.0.1:3000;
    keepalive 8;
}

server {
    listen 80;
    listen [::]:80;

    server_name ${SERVER_NAME};
    access_log /var/log/nginx/${SERVER_NAME}.log;

    location / {
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header Host \$http_host;
        proxy_set_header X-NginX-Proxy true;

        proxy_pass http://${SERVER_NAME}/;
        proxy_redirect off;
    }
 }

EOF

echo "-- Enabling Site --"
sudo ln -s /etc/nginx/sites-available/${SERVER_NAME} /etc/nginx/sites-enabled/${SERVER_NAME}
sudo ln -fs /vagrant/public/ /var/www/${PROJECT_NAME}

echo "-- Restart Server --"
sudo systemctl restart nginx

echo "-- Installing Node JS --"
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "-- Install additional tools --"
sudo apt-get install -y build-essential

echo "-- Install NPM packages --"
sudo npm install pm2@latest -g

echo "-- Configure NPM packages --"
pm2 startup systemd

echo "-- Launch application --"
pm2 start /vagrant/public/app.js

Update