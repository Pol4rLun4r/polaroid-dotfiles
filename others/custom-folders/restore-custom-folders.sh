#!/bin/bash

# script para restaurar pastas customizadas

# diretório atual
CURRENT_DIR=$(dirname "$(realpath "$0")")

BACKUP_FILE="$CURRENT_DIR"/custom-folders-backup.txt

while IFS='|' read -r folder icon; do
    if [ -d "$folder" ]; then
        gio set "$folder" metadata::custom-icon "file:///home/$USER/.local/$icon"
        echo "Ícone restaurado para: $folder"
    else
        echo "Pasta não encontrada: $folder"
    fi
done < "$BACKUP_FILE"