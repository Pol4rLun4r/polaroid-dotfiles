#!/bin/bash

# Script principal de instalação de todos os demais instaladores deste diretório

# Pasta padrão dos dotfiles
SRC_BASE=$(dirname $(dirname $(realpath "$0")))

# Opções
source "$SRC_BASE/options/main-facilities.sh"

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

    tput bold; echo -e "\n✅ Download e Instalações feitas."; tput sgr0
}

if [[ "$AUTO_CONFIRM" == true ]]; then
    install_scripts "-y"
else 

    echo -e "⬇️  Deseja fazer o download dos aplicativos? Isso pode levar um tempo.\n"
    
    tput bold;
    echo -e "(y) Sim, fazer o Download\n"
    echo -e "(n) Não, voltar para o menu anterior\n";
    tput sgr0

    tput bold; read -p "Escolha [y/n]: " CONFIRM; tput sgr0

    if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
        clear
        tput bold; echo -e "🚀 Instalando Apps\n"; tput sgr0 
        install_scripts
    else
        mainFacilities
    fi
fi