#!/bin/bash
apt update
apt install apache2 -y
systemctl start apache2
echo "BLUE instance $(hostname -f)" > /var/www/html/index.html