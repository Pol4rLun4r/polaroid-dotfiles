#!/bin/bash

function secondaryFeatures() {
    clear
    
    echo -e "⚙️  Quais configurações extras deseja fazer?\n"

    tput bold;
    echo -e "(1) Instalar GnomeTweaks\n"
    tput sgr0
    echo -e "(b) Voltar para o Menu\n"
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/2/3/4/b/q]: " OPTIONS; tput sgr0    

    case $OPTIONS in 
        1) clear; bash "$SRC_BASE/gnome/install-gnome-tweaks.sh" ;;
        b) bash "$SRC_BASE/main.sh" ;;
        q) clear; exit 0 ;;
        *) secondaryFeatures ;;
    esac
}