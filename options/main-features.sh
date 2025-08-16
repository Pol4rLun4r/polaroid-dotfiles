#!/bin/bash

#options
source "$SRC_BASE/options/install-all.sh" # installAllMenu

function mainFeatures() {
    clear

    echo -e "🔧 O que deseja configurar primeiro?\n"

    tput bold;
    echo -e "(1) Baixar wallpapers\n"
    echo -e "(2) Instalar Extensões\n"
    echo -e "(3) Instalar Programas\n"
    echo -e "(4) Baixar e Aplicar Tema e Ícones\n"
    echo -e "(5) Instalar Todas as opções acima\n";
    tput sgr0
    echo -e "(b) Voltar para o Menu\n"
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/2/3/4/5/b/q]: " OPTIONS; tput sgr0
    
    case $OPTIONS in 
        1) clear; bash "$SRC_BASE/wallpapers/apply-wallpapers.sh" ;;
        2) clear; bash "$SRC_BASE/gnome/main.sh" ;;
        3) clear; bash "$SRC_BASE/apps/main.sh" ;;
        4) clear; bash "$SRC_BASE/icons/main.sh" ;;
        5) installAllMenu ;;
        b) bash "$SRC_BASE/main.sh" ;;
        q) clear; exit 0 ;;
        *) mainFeatures ;;
    esac
}