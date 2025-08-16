#!/bin/bash

# script de mensagens estilizadas
source "$SRC_BASE/others/script-message.sh"

function installAllMenu() {
    clear

    centralizar_titulo "🚀 Bem-vindo ao Instalador geral."
    echo
    centralizar_texto "Tenha em mente que ao iniciar esta instalação será feito logout da sessão algumas vezes para configurar certas partes dos scripts, isso ocorre devido a limitações do Ubuntu + Wayland."
    echo
    centralizar_texto "Dito isso, será preciso que você inicie o script novamente quando for pedido para concluir as demais instalações."
    echo
    centralizar_texto "As funcionalidades instaladas são: Wallpapers, Extensões Gnome, Tema/Ícones e, por fim, os Apps."
    echo

    bash "$SRC_BASE/others/reload-message.sh"

    echo -e "\nDeseja prosseguir com a instalação?\n"

    echo -e "${BOLD}(y) Prosseguir com a instalação.${RESET}\n"

    echo -e "(b) Voltar para o Menu.\n"
    echo -e "(q) Sair e não fazer nada.\n"

    tput bold; read -p "Escolha [y/b/q]: " OPTIONS; tput sgr0

    case $OPTIONS in 
        y) clear; bash "$SRC_BASE/install-all.sh" ;;
        b) bash "$SRC_BASE/main.sh" ;;
        q) clear; exit 0 ;;
        *) installAllMenu ;;
    esac
}