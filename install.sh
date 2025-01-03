#!/bin/bash

echo "Welcome to the SoloDactyl Panel Installer!"

echo "Please select an option:"
echo "1 - Install SoloDactyl and Docker"
echo "2 - Uninstall SoloDactyl and Docker"
read -p "Enter your choice: " choice

if [[ $choice -eq 1 ]]; then
    # Install Docker
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com | sudo bash
    sudo usermod -aG docker $USER
    sudo systemctl enable docker --now

    # Run Wings installation
    ./install.sh
    cd ..

    echo "Setting up SoloDactyl Panel..."
    # Install Node.js and dependencies
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    sudo apt update
    sudo apt install -y nodejs git

    # Clone SoloDactyl repository
    git clone https://github.com/Solodactyl/solodactyl-panel.git
    cd solodactyl-panel

    # Install dependencies and set up the panel
    npm install
    npm run seed
    npm run createUser

    # Run the panel
    node .

    echo "Installation completed! SoloDactyl Panel is running."


    echo "Installing Docker from Solodactyl Wings repository..."
    # Install Docker from Solodactyl Wings repository
    git clone https://github.com/Solodactyl/solodactyl-wings.git
    cd solodactyl-wings
    npm install

elif [[ $choice -eq 2 ]]; then
    echo "Uninstalling SoloDactyl Panel and Docker..."
    # Remove SoloDactyl panel files
    sudo rm -rf solodactyl-panel
    sudo rm -rf solodactyl-wings

    # Uninstall Docker
    sudo apt-get remove -y docker.io
    sudo rm -rf /var/lib/docker
    sudo rm -rf /etc/docker

    echo "Uninstallation completed."
else
    echo "Invalid choice. Exiting."
fi
