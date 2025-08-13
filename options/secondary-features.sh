#!/bin/bash

function secondaryFeatures() {
    clear
    
    echo -e "⚙️  Quais configurações extras deseja fazer?\n"

    tput bold;
    echo -e "(1) Instalar GnomeTweaks (Customizar o básico do Gnome)\n"
    echo -e "(2) Instalar FastFetch (Ferramenta de informação de sistema)\n"
    echo -e "(3) Instalar NerdFont (Font para usar o ZSH)\n";
    tput sgr0
    echo -e "(b) Voltar para o Menu\n"
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/2/3/b/q]: " OPTIONS; tput sgr0    

    case $OPTIONS in 
        1) clear; bash "$SRC_BASE/gnome/install-gnome-tweaks.sh" ;;
        2) clear; bash "$SRC_BASE/others/install-fastfetch.sh" ;;
        3) clear; bash "$SRC_BASE/others/install-nerdfont.sh" ;;
        b) bash "$SRC_BASE/main.sh" ;;
        q) clear; exit 0 ;;
        *) secondaryFeatures ;;
    esac
}