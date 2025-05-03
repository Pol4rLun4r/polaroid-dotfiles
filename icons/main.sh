#!/bin/bash

# Script para baixar e instalar o tema de ícones Gruvbox-Plus-Dark

# Flag de confirmação automática
AUTO_CONFIRM=false

# Lê as opções
while getopts ":y" opt; do
  [[ $opt == "y" ]] && AUTO_CONFIRM=true
done

download() {
    # Diretório atual
    CURRENT_DIR="$(dirname "$(realpath "$0")")"

    echo "🖌️ aplicando ícones..."

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

    echo "🎉 Tema de ícones aplicado com sucesso!"
}

# automação da flag -y
if [ "$AUTO_CONFIRM" = true ]; then
    download
else
    read -p "⬇️  deseja fazer o download e aplicar os ícones? (y/n):" CONFIRM
    echo

    if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
        download
    else 
        echo "📌 download dos ícones cancelado"
        echo "📌 aplicação do pacote de ícones pulada"
    fi
fi