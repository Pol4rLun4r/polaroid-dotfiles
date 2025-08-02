#!/bin/bash

# Script para reverter as alterações principais das dotfiles

# Apagar wallpapers
source "$SRC_BASE/revert/remove_theme.sh" # removeTheme

function revertScript() {
    clear 

    echo -e "🗑️  O que deseja reverter?\n"

    tput bold;
    echo -e "(1) Apagar Tema Gruvbox (ícones e cores)\n";
    tput sgr0

    echo -e "(b) Voltar\n"
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/b/q]: " OPTIONS; tput sgr0

    case $OPTIONS in 
        1) removeTheme;;
        b) initDotFiles ;;
        q) clear; exit 0 ;;
        *) revertScript;;
    esac
}