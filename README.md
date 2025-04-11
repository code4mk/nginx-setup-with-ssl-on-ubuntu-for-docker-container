# Nginx Setup with SSL for Docker Containers on Ubuntu

This repository provides a collection of scripts to automate the setup of Nginx with SSL certificates for Docker containers running on Ubuntu. The tools help you install dependencies, configure Nginx, and set up SSL certificates using Let's Encrypt.

## Prerequisites

- Ubuntu operating system
- SSH access to your server
- A domain name pointed to your server's IP address
- Root or sudo privileges

## Installation

1. Clone the repository:
```bash
git clone https://github.com/code4mk/nginx-setup-with-ssl-on-ubuntu-for-docker-container
cd nginx-setup-with-ssl-on-ubuntu-for-docker-container
```

2. Make the scripts executable:
```bash
chmod +x run.sh
chmod +x script/*.sh
```

## Usage

Run the setup script:
```bash
./run.sh
```

The script provides four options:

1. **Docker Install on Ubuntu**
   - Installs Docker and Docker Compose on your Ubuntu system

2. **Nginx Install on Ubuntu**
   - Installs and configures Nginx
   - Sets up firewall rules for HTTP/HTTPS traffic
   - Enables Nginx to start on boot

3. **Add SSL Certificate**
   - Installs Certbot and its Nginx plugin
   - Obtains SSL certificates from Let's Encrypt
   - Configures automatic renewal
   - Verifies DNS configuration

4. **Set SSL Nginx Config**
   - Creates Nginx configuration for your domain
   - Sets up SSL certificate paths
   - Configures proxy settings for your Docker container
   - Creates necessary symbolic links
   - Validates and reloads Nginx configuration

## Configuration

When running the SSL setup scripts, you'll need to provide:

- Your domain name
- The port number where your Docker container is running
- Confirmation for various setup steps

The Nginx configuration will:
- Redirect all HTTP traffic to HTTPS
- Set up SSL certificate paths
- Configure proxy settings to your Docker container
- Set appropriate headers for proxy communication

## SSL Certificate Renewal

SSL certificates from Let's Encrypt are valid for 90 days. The setup includes automatic renewal configuration, but you can manually test the renewal process:

```bash
sudo certbot renew --dry-run
```

## Directory Structure

- `script/` - Contains individual setup scripts
- `nginx-config/` - Contains Nginx configuration templates
- `temp/` - Temporary files created during setup
- `run.sh` - Main script to orchestrate the setup process

## Troubleshooting

1. If SSL certificate acquisition fails:
   - Verify your domain's DNS settings
   - Ensure your domain points to the correct IP address
   - Check that ports 80 and 443 are accessible

2. If Nginx configuration fails:
   - Check the Nginx error logs: `sudo tail -f /var/log/nginx/error.log`
   - Verify the configuration: `sudo nginx -t`
```

This README provides a comprehensive guide for users to understand and use your setup tools. You may want to add additional sections for:

- Specific requirements for different Ubuntu versions
- More detailed troubleshooting steps
- Security considerations
- Backup procedures
- Contributing guidelines
- License information

Let me know if you'd like me to expand on any section or add more specific information!