#!/bin/bash

echo "Welcome to the SoloDactyl Panel Installer!"

echo "Please select an option:"
echo "1 - Install SoloDactyl Panel "
echo "2 - Uninstall SoloDactyl Panel "
read -p "Enter your choice: " choice

if [[ $choice -eq 1 ]]; then

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    sudo apt update
    sudo apt install -y nodejs git
    git clone https://github.com/Solodactyl/solodactyl-panel.git
    cd solodactyl-panel
    npm install
    npm run seed
    npm run createUser
    node .

    echo "Installation completed! SoloDactyl Panel is running."



elif [[ $choice -eq 2 ]]; then
    echo "Uninstalling SoloDactyl Panel ..."
    # Remove SoloDactyl panel files
    sudo rm -rf solodactyl-panel
    sudo rm -rf solodactyl-wings


    echo "Uninstallation completed."
else
    echo "Invalid choice. Exiting."
fi
