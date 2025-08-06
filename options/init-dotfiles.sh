#!/bin/bash

# pasta das opções
CHOICES="$SRC_BASE/options"

# Opções
source "$CHOICES/main-facilities.sh" # mainFacilities
source "$CHOICES/revert.sh" # revertScript

function initDotFiles() {
    clear

    echo -e "📍 O que deseja fazer?\n"

    tput bold;  
    echo -e "(1) Instalações Principais: Extensões, Wallpapers, Apps e Icons.\n"
    # echo -e "(2) Configurações e instalações secundárias.\n" # desativado temporariamente até funcionalidades estarem prontas 
    echo -e "(2) Reverter Instalações Principais\n";
    tput sgr0
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/2/q]: " OPTIONS; tput sgr0

    case $OPTIONS in 
        1) mainFacilities ;;
        # 2) clear; echo "Instalando... others" ;;
        2) revertScript ;; 
        q) clear; exit 0 ;;
        *) initDotFiles ;;
    esac
}