#!bin\sh


##************************** Network Security Configuration ******************************##
sudo ufw limit 22/tcp  
sudo ufw limit ssh
sudo ufw allow 80/tcp  
sudo ufw allow 443/tcp  
sudo ufw default deny
sudo ufw default deny incoming  
sudo ufw default allow outgoing
sudo allow from 192.168.0.0/24
sudo allow Deluge
sudo ufw enable