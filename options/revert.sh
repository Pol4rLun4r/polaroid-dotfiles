#!/bin/bash

# Script para reverter as alterações principais das dotfiles

# Apagar wallpapers
source "$SRC_BASE/revert/remove_theme.sh" # removeTheme
source "$SRC_BASE/revert/remove_wallpapers.sh" # removeWallpapers
source "$SRC_BASE/revert/remove_extensions.sh" # removeExtensions

function revertScript() {
    clear 

    echo -e "🗑️  O que deseja reverter?\n"

    tput bold;
    echo -e "(1) Apagar Tema Gruvbox (ícones e cores)\n"
    echo -e "(2) Apagar Wallpapers Gruvbox\n"
    echo -e "(3) Apagar Extensões\n";
    tput sgr0

    echo -e "(b) Voltar\n"
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/2/3/b/q]: " OPTIONS; tput sgr0

    case $OPTIONS in 
        1) removeTheme ;;
        2) removeWallpapers ;;
        3) removeExtensions ;;
        b) initDotFiles ;;
        q) clear; exit 0 ;;
        *) revertScript ;;
    esac
}