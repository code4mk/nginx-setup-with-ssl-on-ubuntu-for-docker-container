
#!/bin/bash

# Update package list and upgrade packages
echo "Updating package list and upgrading packages..."
sudo apt update && sudo apt upgrade -y
if [ $? -ne 0 ]; then
  echo "Error: Failed to update and upgrade packages"
  exit 1
fi

# Install prerequisites
echo "Installing prerequisites..."
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
if [ $? -ne 0 ]; then
  echo "Error: Failed to install prerequisites"
  exit 1
fi

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
if [ $? -ne 0 ]; then
  echo "Error: Failed to add Docker's GPG key"
  exit 1
fi

# Set up the Docker stable repository
echo "Setting up Docker stable repository..."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
if [ $? -ne 0 ]; then
  echo "Error: Failed to add Docker repository"
  exit 1
fi

# Update package list again
echo "Updating package list again..."
sudo apt update
if [ $? -ne 0 ]; then
  echo "Error: Failed to update package list after adding Docker repository"
  exit 1
fi

# Install Docker CE
echo "Installing Docker CE..."
sudo apt install docker-ce -y
if [ $? -ne 0 ]; then
  echo "Error: Failed to install Docker CE"
  exit 1
fi

# Change permissions of Docker socket
echo "Changing permissions of Docker socket..."
sudo chmod 666 /var/run/docker.sock
if [ $? -ne 0 ]; then
  echo "Error: Failed to change permissions of Docker socket"
  exit 1
fi

echo "Docker installation completed successfully."