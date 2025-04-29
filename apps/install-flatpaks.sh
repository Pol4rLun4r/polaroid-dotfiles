#!/bin/bash

# Verifica se o Flatpak está instalado
if ! command -v flatpak &> /dev/null; then
    echo "📦 Flatpak não encontrado. Instalando..."
    sudo apt update && sudo apt install -y flatpak
else
    echo "✅ Flatpak já está instalado."
fi

# Verifica se o repositório Flathub já foi adicionado
if ! flatpak remotes | grep -q flathub; then
    echo "➕ Adicionando o repositório Flathub..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
else
    echo "✅ Flathub já está configurado."
fi

LISTA="$HOME/.dotfiles/apps/flatpaks.list"
if [ ! -f "$LISTA" ]; then
    echo "❌ Arquivo $LISTA não encontrado!"
    exit 1
fi

echo "🚀 Instalando Flatpaks listados em $LISTA..."

while read -r app; do
    [ -z "$app" ] && continue  #Ignora se a linha estiver vazia

    if flatpak list --app | grep -q "$app"; then
        echo "🔁 $app já está instalado. Pulando..."
        continue
    fi

    echo "🔹 Instalando: $app"
    flatpak install -y flathub "$app"

done < "$LISTA"

echo "✅ Instalação dos flatpaks finalizada."