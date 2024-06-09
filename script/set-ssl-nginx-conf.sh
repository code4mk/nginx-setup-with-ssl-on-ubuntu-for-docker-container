#!/bin/bash

# Prompt user for domain name
read -p "Enter your domain name: " domain_name

# Prompt user for container running port
read -p "Enter your Container running port: " the_port

# Check if the config file exists
config_file="nginx-config/project-ssl.conf"
if [ ! -f "$config_file" ]; then
    echo "Error: Nginx config file not found at $config_file"
    exit 1
fi

# Read Nginx config file
nginx_config=$(<"$config_file")

# Replace domain name and container port in the config
nginx_config=$(echo "$nginx_config" | sed "s/your_domain_name/$domain_name/g")
nginx_config=$(echo "$nginx_config" | sed "s/the_port/$the_port/g")

# Define output file path
output_dir="temp/sites-available"
output_file="$output_dir/$domain_name"

# Check if the output directory exists, if not create it
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

# Write the modified config to a new file
echo "$nginx_config" > "$output_file"

# Inform user about the created file
echo "Nginx configuration file has been created at: $output_file"

# Prompt user if they want to setup Nginx
read -p "Do you want to set up Nginx? (yes/no): " setup_nginx

if [ "$setup_nginx" = "yes" ]; then
    # Copy the file to /etc/nginx/sites-available
    sudo cp "$output_file" "/etc/nginx/sites-available/"
    echo "Config file copied to /etc/nginx/sites-available/$domain_name"

    # Create a symbolic link in sites-enabled
    sudo ln -s "/etc/nginx/sites-available/$domain_name" "/etc/nginx/sites-enabled/"
    echo "Symbolic link created in /etc/nginx/sites-enabled/"

    # Validate nginx configuration and reload nginx
    echo "Validating nginx configuration..."
    sudo nginx -t
    echo "Reloading nginx..."
    sudo systemctl reload nginx

    echo "Nginx has been configured with the new site."
else
    echo "Nginx setup skipped. Make sure to configure Nginx manually."
fi
