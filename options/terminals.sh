#!/bin/bash

# Negrito
bold=$(tput bold)
# Reset
reset=$(tput sgr0)

function terminals() {
    clear 

    echo -e "💻 Terminais/Consoles\n"

    echo -e "${bold}(1) Instalar Gnome Console ${reset}(Terminal Alternativo)\n"
    echo -e "${bold}(2) Instalar Gnome Terminal ${reset}(Terminal Padrão)\n";

    echo -e "(b) Voltar para o Menu\n"
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/2/b/q]: " OPTIONS; tput sgr0 

    case $OPTIONS in 
        1) clear; bash "$SRC_BASE/others/set-gnome-console.sh" ;;
        2) clear; bash "$SRC_BASE/others/set-gnome-terminal.sh" ;;
        b) bash "$SRC_BASE/main.sh" ;;
        q) clear; exit 0 ;;
        *) terminals ;;
    esac
}