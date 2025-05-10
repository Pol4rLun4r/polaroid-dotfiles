#!/bin/bash

# diretório atual
CURRENT_DIR=$(dirname "$(realpath "$0")")

# lista de diretórios customizados
LIST="$CURRENT_DIR"/custom-folders-list.txt

# arquivo de backup
BACKUP_FILE="$CURRENT_DIR"/custom-folders-backup.txt
> "$BACKUP_FILE"

echo -e "\n💽 Criando backup de pastas personalizadas"

while IFS= read -r folder; do
    full_path="$HOME/$folder"
    icon=$(gio info "$full_path" | grep "metadata::custom-icon" | grep -o "share/.*")

    if [ -n "$icon" ]; then
        echo "$full_path|$icon" >> "$BACKUP_FILE"
    fi
done < "$LIST"

echo -e "\n✅ Backup de pastas customizadas criado"