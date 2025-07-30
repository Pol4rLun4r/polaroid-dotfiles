#!/bin/bash

# Pasta padrão dos dotfiles
SRC_BASE=$(dirname $(dirname $(realpath "$0")))

function choices() {
    clear

    echo -e "🔧 O que deseja configurar primeiro?\n"

    tput bold;
    echo -e "(1) Baixar wallpapers\n"
    echo -e "(2) Instalar Extensões\n"
    echo -e "(3) Instalar Programas\n"
    echo -e "(4) Baixar e Aplicar Tema e Ícones\n";
    tput sgr0
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/2/3/4/q]: " STEP1; tput sgr0

    case $STEP1 in 
        1)
        clear
        echo "Baixando Wallpapers"
        ;;

        2)
        clear
        echo "Baixando Extensões"
        ;;

        3)
        clear
        echo "Baixando Programas"
        ;;

        4)
        clear
        echo "Baixando tema de ícones"
        ;;

        q)
        clear
        exit 0
        ;;

        *) 
        choices
        ;;
    esac
}

choices