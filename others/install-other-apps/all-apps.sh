#!/bin/bash

# habilitá o sudo no inicio
sudo -v

clear

set -e

echo "Atualizando repositórios..."
sudo apt update
flatpak update -y

echo "Instalando Snap apps..."

sudo snap install chatgpt-desktop

echo "Instalando Flatpak apps..."

flatpak install -y org.videolan.VLC
flatpak install -y tech.dongdongbh.mindwtr
flatpak install -y org.telegram.desktop 

echo "Instalando APT apps..."

sudo apt install -y synaptic

tput bold; echo -e "\n✅ Download e Instalações feitas."; tput sgr0

exit 0