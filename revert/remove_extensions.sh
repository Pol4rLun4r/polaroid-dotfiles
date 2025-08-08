#!/bin/bash

# Script para apagar as Extensões

# arquivo da lista de extensões
LIST="$(dirname $(realpath "$0"))/gnome/download-install/extensions-list.txt"

removeFunctionExtensions() {
    clear

    if [ ! -f $LIST ]; then 
        echo "! A lista de extensões não existe"
        exit 1
    fi

    # desativar extensões
    while read -r ext; do
        gnome-extensions disable "$ext"
    done < $LIST

    # apagar arquivos das extensões
    while read -r ext; do
        rm -rf "$HOME/.local/share/gnome-shell/extensions/$ext"
    done < $LIST

}

removeExtensions() {
    clear 

    echo -e "⚠️  Tem certeza que deseja remover as Extensões?\n"

    tput bold;
    echo -e "(y) Sim, remover Extensões\n"
    echo -e "(n) Não, voltar para o menu anterior\n";
    tput sgr0

    tput bold; read -p "Escolha [y/n]: " CONFIRM; tput sgr0

    if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
        removeFunctionExtensions
        echo "+ Extensões apagadas"
    else 
        initDotFiles
    fi

}