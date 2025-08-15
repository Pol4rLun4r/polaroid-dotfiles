#!/bin/bash

# pasta das opções
CHOICES="$SRC_BASE/options"

# Opções
source "$CHOICES/main-features.sh" # mainFeatures
source "$CHOICES/secondary-features.sh" # secondaryFeatures
source "$CHOICES/revert.sh" # revertScript
source "$CHOICES/dev.sh" # devMode
source "$CHOICES/shortcuts.sh" # shortcuts

function initDotFiles() {
    clear

    # texto de dica
    bash "$SRC_BASE/others/style-text-polar_dot.sh"
    echo

    echo -e "📍 O que deseja fazer?\n"

    tput bold;  
    echo -e "(1) Instalações Principais: Extensões, Wallpapers, Apps e Icons.\n"
    echo -e "(2) Configurações e instalações secundárias.\n"
    echo -e "(3) Reverter Instalações Principais\n"
    echo -e "(4) Atalhos pro Terminal com ZSH\n";
    tput sgr0
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/2/3/4/q]: " OPTIONS; tput sgr0

    case $OPTIONS in 
        1) mainFeatures ;;
        2) secondaryFeatures ;;
        3) revertScript ;;
        4) shortcuts ;;
        dev) devMode ;; # opção oculta, para desenvolvimento.
        q) clear; exit 0 ;;
        *) initDotFiles ;;
    esac
}