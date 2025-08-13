#!/bin/bash

# Script para baixar e instalar o tema de ícones Gruvbox-Plus-Dark

# Pasta padrão dos dotfiles
SRC_BASE=$(dirname $(dirname $(realpath "$0")))

# Opções
source "$SRC_BASE/options/main-features.sh"

# Flag de confirmação automática
AUTO_CONFIRM=false

# Lê as opções
while getopts ":y" opt; do
  [[ $opt == "y" ]] && AUTO_CONFIRM=true
done

download() {
    # Diretório atual
    CURRENT_DIR="$(dirname "$(realpath "$0")")"

    tput bold; echo -e "🚀 Aplicando ícones\n"; tput sgr0

    # download do icon-pack
    bash "$CURRENT_DIR/download-iconpack.sh"

    # aplica o pacote de ícones no ubuntu 
    gsettings set org.gnome.desktop.interface icon-theme "Gruvbox-Plus-Dark"

    # aplica o tema escuro para o ubuntu
    if gsettings list-keys org.gnome.desktop.interface | grep -q color-scheme; then
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    else
        gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
    fi

    # restauração dos ícones personalizados
    bash "$CURRENT_DIR/personalized-icons.sh"

    # Corrige ícones personalizados para outros usuários
    bash "$CURRENT_DIR/fix-icons.sh"

    tput bold; echo -e "\n🎉 Tema de ícones aplicado com sucesso!"; tput sgr0
}

# automação da flag -y
if [ "$AUTO_CONFIRM" = true ]; then
    download
else
    echo -e "⬇️  Deseja fazer o download e aplicar os ícones?\n"

    tput bold;
    echo -e "(y) Sim, fazer o Download\n"
    echo -e "(n) Não, voltar para o menu anterior\n";
    tput sgr0

    tput bold; read -p "Escolha [y/n]:" CONFIRM; tput sgr0

    if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
        clear; download
    else 
        mainFeatures
    fi
fi