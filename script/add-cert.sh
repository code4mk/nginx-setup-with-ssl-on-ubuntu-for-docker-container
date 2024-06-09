#!/bin/bash

# Get the hostname
hostname=$(hostname)

# Get the IP address associated with the hostname
ip_address=$(nslookup "$hostname" | awk '/^Address: / { print $2 }')

# Display the IP address
echo "The IP address of this machine is: $ip_address"

# Prompt user for domain name
read -p "Enter your domain name: " domain_name

# Inform user to add an A record with the IP address
echo "Before proceeding, please ensure you have added an A record with the IP address $ip_address for $domain_name in your DNS settings."

# Check if DNS is working for the domain
if ! nslookup "$domain_name" >/dev/null 2>&1; then
    echo "DNS lookup failed for $domain_name."
    echo "Please verify your DNS configuration and try again."
    exit 1
fi

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
