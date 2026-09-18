#!/bin/bash

# habilitá o sudo no inicio
sudo -v

# Negrito
bold=$(tput bold)
# Reset
reset=$(tput sgr0)

#Opções de apps
# source "$SRC_BASE/others/zsh.sh" # vscode

function installOtherApps() {
    clear

    echo -e "🫧  Quais apps deseja instalar?\n"

    echo -e "${bold}(1) Instalar Simplenote ${reset}\n"
    echo -e "${bold}(2) Instalar todos acima ${reset}\n"

    echo -e "(b) Voltar para o Menu\n"
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/2/3/4/b/q]: " OPTIONS; tput sgr0    

    case $OPTIONS in 
        1) clear; snap install simplenote ;;
        2) bash "$SRC_BASE/others/install-other-apps/all-apps.sh" ;;
        b) bash "$SRC_BASE/main.sh" ;;
        q) clear; exit 0 ;;
        *) installOtherApps ;;
    esac
}