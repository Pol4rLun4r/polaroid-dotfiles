#!/bin/bash

# Diretório onde se encontra a pasta "change-icon"
SRC_DIR="$HOME/.dotfiles/icons/change-icon"

# Executa o script que define os nomes e o tipo do ícone
source "$SRC_DIR/create-list-icons.sh"

# Verifica se a variável ICON_TYPE foi definida corretamente
if [ -z "$ICON_TYPE" ]; then
    echo "❌ Tipo de ícone não definido. Verifique o script create-list-icons.sh"
    exit 1
fi

case "$ICON_TYPE" in
    flatpak)
        bash "$SRC_DIR/flatpak-icon.sh" "$APPLICATION_NAME" "$ORIGINAL_NAME"
        ;;
    snap)
        bash "$SRC_DIR/snap-icon.sh" "$APPLICATION_NAME" "$ORIGINAL_NAME"
        ;;
    *)
        echo "❌ Tipo de ícone inválido: $ICON_TYPE"
        exit 1
        ;;
esac