#!/bin/bash

# Ciano escuro - setaf 6
color_text=$(tput setaf 6)
# Verde claro — setaf 10
color_text_highlights=$(tput setaf 10)
# Negrito
bold=$(tput bold)
# Reset
reset=$(tput sgr0)

function shortcuts() {
    clear
    
    echo -e "📋 Abaixo está a lista de atalhos presentes no terminal usando ZSH e alguns atalhos globais\n"
    
    echo "- Atalhos do ZSH no Terminal:"
    echo "+ ${bold}${color_text_highlights}c${reset} - usa o comando: ${bold}${color_text}clear${reset}"
    echo "+ ${bold}${color_text_highlights}update${reset} - usa o comando: ${bold}${color_text}apt update + apt upgrade -y${reset}"
    echo "+ ${bold}${color_text_highlights}dots${reset} - acessa: ${bold}${color_text}~/polaroid-dotfiles${reset}"
    echo "+ ${bold}${color_text_highlights}desktop${reset} - acessa: ${bold}${color_text}~/Desktop${reset}"

    echo

    echo "- Atalhos globais:"
    echo "+ ${bold}${color_text_highlights}polar-dot${reset} - inicia o polaroid-dotfiles"
    echo "+ ${bold}${color_text_highlights}dot-install${reset} - instala todas as funcionalidades principais"

    echo

    echo "(${bold}q${reset}) Para sair"
    echo -e "(${bold}b${reset}) Para voltar ao Menu\n"

    read OPTIONS    

    case $OPTIONS in 
        b) bash "$SRC_BASE/main.sh" ;;
        q) clear; exit 0 ;;
        *) shortcuts ;;
    esac
}