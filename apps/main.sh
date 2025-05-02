#!/bin/bash

# Script principal de instalação de todos os demais instaladores deste diretório

sudo -v #autoriza o sudo no inicio da linha

# Flag de confirmação automática
AUTO_CONFIRM=false

# Lê a flag -y, se passada
while getopts ":y" opt; do
  [[ $opt == "y" ]] && AUTO_CONFIRM=true
done

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

if [ "$AUTO_CONFIRM" = true ]; then
    # Instala os Apps Flatpak
    bash "$CURRENT_DIR/install-flatpaks.sh"

    # Instala os Apps Snap
    bash "$CURRENT_DIR/install-snaps.sh"
else 
    read -p "⬇️  deseja fazer o download dos aplicativos? isso pode levar um tempo (y/n):" CONFIRM
    echo

    if [[ "$CONFIRM" =~ ^[yY]$ ]]; then

        # Instala os Apps Flatpak
        bash "$CURRENT_DIR/install-flatpaks.sh"

        # Instala os Apps Snap
        bash "$CURRENT_DIR/install-snaps.sh"

    else
        echo "📌 download dos aplicativos pulado"
    fi
fi