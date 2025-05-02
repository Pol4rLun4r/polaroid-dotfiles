#!/bin/bash

# script para fazer backup das configurações das extensões

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

# arquivo de backup
BACKUP_FILE="$CURRENT_DIR/extensions-settings.dconf"
[ -f "$BACKUP_FILE" ] && touch "$BACKUP_FILE"

echo "🔄 Fazendo backup das configurações das extensões GNOME..."

dconf dump /org/gnome/shell/extensions/ > "$BACKUP_FILE"

echo "✅ Configurações de extensões salvas em: $BACKUP_FILE"