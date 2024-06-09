#!/bin/bash

# Prompt user for domain name
read -p "Enter your domain name: " domain_name

# Check if certbot and python3-certbot-nginx are installed
if ! command -v certbot &> /dev/null || ! dpkg -l | grep -q python3-certbot-nginx; then
    echo "Installing Certbot and Certbot Nginx plugin..."
    sudo apt install certbot python3-certbot-nginx -y
    echo "Certbot and Certbot Nginx plugin installed."
fi

# Check if SSL certificates exist for the domain
if sudo test -f "/etc/letsencrypt/live/$domain_name/fullchain.pem"; then
    echo "Let's Encrypt certificates already exist for $domain_name."
else
    # Request SSL certificate for the domain using Certbot
    echo "Requesting SSL certificate for $domain_name using Certbot..."
    sudo certbot --nginx -d "$domain_name"
fi

# Test certificate renewal
echo "Testing certificate renewal..."
sudo certbot renew --dry-run

# Show certificate expiry date
echo "Certificate expiry date:"
sudo openssl x509 -enddate -noout -in "/etc/letsencrypt/live/$domain_name/fullchain.pem"
