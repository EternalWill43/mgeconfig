#!/bin/bash

# Exit on any error
set -e

echo "🚀 Setting up Ubuntu VPS for TF2 Docker server..."

# System updates
echo "📦 Updating system packages..."
sudo apt update
sudo apt upgrade -y

sudo apt install tmux -y

# Create TF2 data directory
echo "📁 Creating TF2 data directory..."
mkdir -p tf2-data/tf/maps
mkdir -p tf2-data/tf/addons/sourcemod/scripting/include
chown -R 1000:1000 ./tf2-data

wget -P ./tf2-data/tf/maps/ https://fastdl.serveme.tf/maps/mge_training_v8_beta4b.bsp

# Add i386 architecture for TF2 dependencies
echo "🏗️ Adding i386 architecture and installing 32-bit libraries..."
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install -y libc6:i386 lib32stdc++6

sudo apt install unzip

# Install Docker
echo "🐳 Installing Docker..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to docker group (so you don't need sudo for docker commands)
echo "👤 Adding user to docker group..."
sudo usermod -aG docker $USER

# Install lazydocker (not lazygit - fix the comment)
echo "🔧 Installing lazydocker..."
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Add ~/.local/bin to PATH
echo "📝 Updating PATH..."
NEW_PATH="$HOME/.local/bin"
BASHRC="$HOME/.bashrc"

if ! grep -q "export PATH=.*$HOME/.local/bin" "$BASHRC" 2>/dev/null; then
    echo "Adding $NEW_PATH to PATH in $BASHRC"
    echo "" >> "$BASHRC"
    echo "# Add local bin to PATH" >> "$BASHRC"
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$BASHRC"
    echo "✅ Path added to $BASHRC"
else
    echo "✅ Path already exists in $BASHRC"
fi

# Source bashrc
source "$HOME/.bashrc"

# Verify installations
echo "🔍 Verifying installations..."
docker --version || echo "❌ Docker installation failed"
lazydocker --version || echo "❌ Lazydocker installation failed"

echo "✅ Setup complete!"
echo ""
echo "⚠️  IMPORTANT: Log out and back in (or run 'newgrp docker') to use Docker without sudo"
echo "🎮 Your VPS is now ready for TF2 server deployment!"