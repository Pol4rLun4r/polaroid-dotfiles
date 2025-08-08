#!/bin/bash

# Script para apagar os wallpapers

# Diretório dos wallpapers
DEST_WALLPAPER="$(dirname $(realpath "$0"))/wallpapers/images"

removeFunctionWallpaper() {
    clear

    if [ ! -d $DEST_WALLPAPER ]; then
        echo -e "\n! Diretório de wallpapers não existe"
        exit 1
    fi

    # apaga a pasta de wallpapers
    rm -r "$DEST_WALLPAPER"

    sleep 1

    gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/ubuntu-wallpaper-d.png'
    gsettings set org.gnome.desktop.background picture-uri-dark 'file:///usr/share/backgrounds/ubuntu-wallpaper-d.png'
}

removeWallpapers() {
    clear 

    echo -e "⚠️  Tem certeza que deseja remover os Wallpapers?\n"

    tput bold;
    echo -e "(y) Sim, remover Wallpapers\n"
    echo -e "(n) Não, voltar para o menu anterior\n";
    tput sgr0

    tput bold; read -p "Escolha [y/n]: " CONFIRM; tput sgr0

    if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
        removeFunctionWallpaper
        echo "+ Wallpapers apagados"
    else 
        initDotFiles
    fi

}