#!/bin/bash

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

ICONS_LIST="$(dirname "$0")/icons.list"
SYMBOLIC_LINK_SCRIPT="$CURRENT_DIR/change-icon/symbolic-icon.sh"

while read -r ORIGINAL_NAME APPLICATION_NAME ICON_TYPE; do

    # Ignora linhas em branco ou que começam com "#"
    [[ -z "$ORIGINAL_NAME" || "$ORIGINAL_NAME" == \#* ]] && continue

    bash "$SYMBOLIC_LINK_SCRIPT" "$ORIGINAL_NAME" "$APPLICATION_NAME"

done < "$ICONS_LIST"

gtk-update-icon-cache