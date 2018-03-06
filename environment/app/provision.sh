#!/bin/bash

# update and upgrade
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
# copy templates nginx from host to guest
sudo cp /home/ubuntu/templates/nginx.conf /etc/nginx/sites-available
# copy profile.sh to guest
# sudo cp /home/ubuntu/templates/profile.sh /etc/profile.d
# Install nodejs
# curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
# sudo bash ./nodesource_setup.sh
# sudo apt-get install nodejs -y
# # Install pm2
# sudo npm install pm2 -g
# restart nginx
# sudo systemctl restart nginx
# # 
# sudo pm2 start app.js