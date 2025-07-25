#!/bin/bash

# Habilitar sudo
sudo -v 

# Pasta padrão dos dotfiles
SRC_BASE=$(dirname $(realpath "$0"))

echo -e "📑 Abrindo polaroid-dotfiles\n"

echo "📍 O que deseja fazer?"
echo "1) Instalações Principais: Extensões, Wallpapers, Apps e Icons"
echo "2) Configurações e instalações secundárias"
read STEP1