#!/bin/bash

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

# Corrige possível erro das pastas do flatpak
bash "$CURRENT_DIR/flatpak-path.sh"

# Verifica se o Flatpak está instalado
if ! command -v flatpak &> /dev/null; then
    echo "+ Flatpak não encontrado. Instalando..."
    sudo apt update && sudo apt install -y flatpak
else
    echo "+ Flatpak já está instalado."
fi

# Verifica se o repositório Flathub já foi adicionado
if ! flatpak remotes | grep -q flathub; then
    echo "+ Adicionando o repositório Flathub..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
else
    echo -e "+ Flathub já está configurado.\n"
fi

LISTA="$CURRENT_DIR/flatpaks.list"
if [ ! -f "$LISTA" ]; then
    echo "❌ Arquivo $LISTA não encontrado!"
    exit 1
fi

echo "- Instalando Flatpaks"

while read -r app; do
    [ -z "$app" ] && continue  #Ignora se a linha estiver vazia

    if flatpak list --app | grep -q "$app"; then
        echo "+ $app já está instalado."
        continue
    fi

    echo "🔹 Instalando: $app"
    flatpak install -y flathub "$app"

done < "$LISTA"

tput bold; echo -e "\n* Instalação dos flatpaks finalizada."; tput sgr0