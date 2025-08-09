#!/bin/bash

# modo de desenvolvedor oculto

function devMode() {
    clear

    tput bold;
    echo -e "+ DEV MODE\n";
    tput sgr0

    echo -e "💾 O que deseja configurar primeiro?\n"

    tput bold;
    echo -e "(1) Fazer Backup das configurações das extensões\n";
    tput sgr0
    echo -e "(b) Voltar para o Menu\n"
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/b/q]: " OPTIONS; tput sgr0
    
    case $OPTIONS in 
        1) clear; bash "$SRC_BASE/gnome/backup-restore/extensions-backup.sh" ;;
        b) bash "$SRC_BASE/main.sh" ;;
        q) clear; exit 0 ;;
        *) devMode ;;
    esac
}