#!/bin/bash

# script para "linkar" e aplicar os ícones personalizados ao sistema

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

# parâmetros recebidos
APP_NAME=$1 #APPLICATION_NAME
ORIG_NAME=$2 #ORIGINAL_NAME

# Caminho do .desktop original do Snap
SRC_SNAP="/var/lib/snapd/desktop/applications/${APP_NAME}_${APP_NAME}.desktop"

# Caminho onde será salvo o .desktop modificado (nos dotfiles)
SRC_BACKUP="$CURRENT_DIR/../applications/${APP_NAME}_${APP_NAME}.desktop"

# Caminho onde o .desktop será simbolicamente ligado ao sistema
SRC_SYS="$HOME/.local/share/applications/${APP_NAME}_${APP_NAME}.desktop"

# Caminho do icone personalizado
SRC_ICON="$CURRENT_DIR/../images/$APP_NAME.svg"

# Garante que os diretórios necessários existam
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$CURRENT_DIR/../applications"

# Verifica se o .desktop do Snap existe
if [ ! -f "$SRC_SNAP" ]; then
    echo "❗ .desktop não encontrado: $SRC_SNAP"

    # limpar ícones parcialmente criados
    rm "$CURRENT_DIR/../images/$APP_NAME.svg"
    sed -i "/^$ORIG_NAME/d" "$ICON_LIST"    

    echo "🗑️ Ícone removido da lista"

    exit 1
fi

# Verifica se o ícone personalizado existe
if [ ! -f "$SRC_ICON" ]; then
    echo "❌ ícone personalizado não encontrado: $SRC_ICON"
    exit 1
fi

# Copia o .desktop original do Snap para os dotfiles
cp "$SRC_SNAP" "$SRC_BACKUP"

# Substitui o campo Icon= pelo caminho do novo ícone
sed -i "s|^Icon=.*|Icon=$SRC_ICON|" "$SRC_BACKUP"

# Cria ou atualiza o link simbólico no sistema
ln -sf "$SRC_BACKUP" "$SRC_SYS"

echo "✅ Ícone atualizado com sucesso!"