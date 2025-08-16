#!/bin/bash

# script para fazer a instalação das extensões baixadas

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

# Lista das extensões extraídas
EXTRACTED_EXT="$CURRENT_DIR/extracted-extensions.txt"

# força a ativação das extensões
gsettings set org.gnome.shell disable-user-extensions false

while read -r uuid; do
    name_extension=$(echo "$uuid" | cut -d '@' -f 1)

    if gnome-extensions list --enabled | grep -Fxq "$uuid"; then
        echo "+ A extensão já está ativada: $uuid"
        continue
    fi
    
    if gnome-extensions enable "$uuid" 2>/dev/null; then
        echo "+ Extensão ativada com sucesso: $name_extension"
        sleep 3
    else
        echo "❌ Falha ao ativar a extensão ou ela não está instalada: $name_extension"
        sleep 3
    fi
done < "$EXTRACTED_EXT"

# arquivo que informa o script qual etapa ele deve seguir
STATE="$CURRENT_DIR/../state.txt"
echo "installed" >> "$STATE"