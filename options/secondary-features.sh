#!/bin/bash

# Negrito
bold=$(tput bold)
# Reset
reset=$(tput sgr0)

#Opções
source "$CHOICES/terminals.sh" # terminals
source "$CHOICES/zsh.sh" # zshOptions

function secondaryFeatures() {
    clear
    
    echo -e "⚙️  Quais configurações extras deseja fazer?\n"

    echo -e "${bold}(1) Instalar Gnome Tweaks ${reset}(Customizar o básico do Gnome)\n"
    echo -e "${bold}(2) Instalar FastFetch ${reset}(Ferramenta de informação de sistema)\n"
    echo -e "${bold}(3) Instalar ZSH ${reset}(Customizar Terminal)\n"
    echo -e "${bold}(4) Terminais ${reset}(Terminais Alternativos)\n"
    echo -e "${bold}(5) Alterar ícones de Apps ${reset}\n"

    echo -e "(b) Voltar para o Menu\n"
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [1/2/3/4/b/q]: " OPTIONS; tput sgr0    

    case $OPTIONS in 
        1) clear; bash "$SRC_BASE/gnome/install-gnome-tweaks.sh" ;;
        2) clear; bash "$SRC_BASE/others/install-fastfetch.sh" ;;
        3) zshOptions ;;
        4) terminals ;;
        5) clear; bash "$SRC_BASE/icons/change-icon/main.sh" ;;
        b) bash "$SRC_BASE/main.sh" ;;
        q) clear; exit 0 ;;
        *) secondaryFeatures ;;
    esac
}