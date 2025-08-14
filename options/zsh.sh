#!/bin/bash

# Negrito
bold=$(tput bold)
# Reset
reset=$(tput sgr0)

function zshOptions() {
    clear
    
    echo -e "🎨 O que deseja estilizar no terminal?\n"

    echo -e "${bold}(1) Instalar ZSH e OhMyZsh ${reset}(Estilizar o Terminal)\n"
    echo -e "${bold}(2) Instalar NerdFont ${reset}(Para usar com o ZSH)\n"

    echo -e "(b) Voltar para o Menu\n"
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/2/b/q]: " OPTIONS; tput sgr0    

    case $OPTIONS in 
        1) clear; bash "$SRC_BASE/zsh/install_zsh.sh" ;;
        2) clear; bash "$SRC_BASE/others/install-nerdfont.sh" ;;
        b) bash "$SRC_BASE/main.sh" ;;
        q) clear; exit 0 ;;
        *) zshOptions ;;
    esac
}