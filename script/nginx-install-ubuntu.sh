
#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update
if [ $? -ne 0 ]; then
  echo "Error: Failed to update package list"
  exit 1
fi

# Install Nginx
echo "Installing Nginx..."
sudo apt install nginx -y
if [ $? -ne 0 ]; then
  echo "Error: Failed to install Nginx"
  exit 1
fi

# Start Nginx service
echo "Starting Nginx service..."
sudo systemctl start nginx
if [ $? -ne 0 ]; then
  echo "Error: Failed to start Nginx service"
  exit 1
fi

# Enable Nginx service to start on boot
echo "Enabling Nginx service to start on boot..."
sudo systemctl enable nginx
if [ $? -ne 0 ]; then
  echo "Error: Failed to enable Nginx service"
  exit 1
fi

# Adjust firewall to allow HTTP and HTTPS traffic
echo "Adjusting firewall to allow HTTP and HTTPS traffic..."
sudo ufw allow 'Nginx Full'
if [ $? -ne 0 ]; then
  echo "Error: Failed to adjust firewall"
  exit 1
fi

echo "Nginx installation and setup completed successfully."