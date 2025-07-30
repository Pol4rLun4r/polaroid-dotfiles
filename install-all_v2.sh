#!/bin/bash

# Habilitar sudo
sudo -v 

# Pasta padrão dos dotfiles
SRC_BASE=$(dirname $(realpath "$0"))

echo -e "📑 Abrindo polaroid-dotfiles\n"

function WhatToDo() {
    echo -e "📍 O que deseja fazer?\n"

    tput bold;  
    echo -e "(1) Instalações Principais: Extensões, Wallpapers, Apps e Icons.\n"
    echo -e "(2) Configurações e instalações secundárias.\n";
    tput sgr0
    echo -e "(q) Sair e não fazer nada.\n"
}

WhatToDo

tput bold; read -p "Choice [1/2/q]: " STEP1; tput sgr0

echo "${STEP1}"