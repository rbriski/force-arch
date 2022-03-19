cd /etc/nginx/sites-enabled && ln -s ../sites-available/force .
systemctl start force
systemctl enable force
systemctl restart nginx

snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot
certbot --nginx -d deanzaforce.club -d www.deanzaforce.club -m $EMAIL --agree-tos --no-eff-email