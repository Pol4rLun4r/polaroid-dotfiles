#!/bin/bash

# Habilitar sudo
sudo -v

# Pasta padrão dos dotfiles
SRC_BASE=$(dirname $(realpath "$0"))

# pasta das opções
CHOICES="$SRC_BASE/init"

function initDotFiles() {
    clear

    echo -e "📍 O que deseja fazer?\n"

    tput bold;  
    echo -e "(1) Instalações Principais: Extensões, Wallpapers, Apps e Icons.\n"
    echo -e "(2) Configurações e instalações secundárias.\n";
    tput sgr0
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/2/q]: " STEP1; tput sgr0

    case $STEP1 in 
        1)
        clear
        bash "$CHOICES/option1.sh"
        ;;

        2)
        clear
        echo "Instalando... others"
        ;;

        q)
        clear
        exit 0
        ;;

        *) 
        initDotFiles
        ;;
    esac
}

initDotFiles