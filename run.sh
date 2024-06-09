#!/bin/bash

# List available scripts
echo "Available scripts:"
echo "1. Docker deploy on Ubuntu"
echo "2. Nginx install on Ubuntu"
echo "3. Add SSL certificate"
echo "4. Set SSL Nginx config"

# Prompt user to select a script
read -p "Enter the number of the script you want to run: " script_number

case $script_number in
    1)
        # Execute docker-deploy-ubuntu.sh
        bash script/docker-deploy-ubuntu.sh
        ;;
    2)
        # Execute nginx-install-ubuntu.sh
        bash script/nginx-install-ubuntu.sh
        ;;
    3)
        # Execute add-cert.sh
        bash script/add-cert.sh
        ;;
    4)
        # Execute set-ssl-nginx-conf.sh
        bash script/set-ssl-nginx-conf.sh
        ;;
    *)
        echo "Invalid selection. Please enter a valid script number."
        ;;
esac
