#!/bin/bash

# Script principal de instalação de todos os demais instaladores deste diretório

sudo -v # Autoriza o sudo no início

# Flag de confirmação automática
AUTO_CONFIRM=false

# Lê a flag -y, se passada
while getopts ":y" opt; do
  [[ $opt == "y" ]] && AUTO_CONFIRM=true
done

# Diretório atual
CURRENT_DIR="$(dirname "$(realpath "$0")")"

install_scripts() {
    local AUTO_FLAG=$1

    # Instala os Apps Flatpak
    if [[ "$AUTO_FLAG" == "-y" ]]; then
        bash "$CURRENT_DIR/install-flatpaks.sh" -y
    else
        bash "$CURRENT_DIR/install-flatpaks.sh"
    fi

    # Instala os Apps Snap
    bash "$CURRENT_DIR/install-snaps.sh"
}

if [[ "$AUTO_CONFIRM" == true ]]; then
    install_scripts "-y"
else 
    read -p "⬇️  Deseja fazer o download dos aplicativos? Isso pode levar um tempo (y/n): " CONFIRM
    echo

    if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
        install_scripts
    else
        echo "📌 Download dos aplicativos pulado"
    fi
fi
