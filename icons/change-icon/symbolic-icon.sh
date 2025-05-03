#!/bin/bash

# script para "renomear" ícones da pasta "Gruvbox-plus-dark"
# e criar um link simbólico no meu dotfiles para manter controle versionado

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

# Nome do ícone original (sem extensão)
ORIG=$1

# Novo nome do ícone (sem extensão)
APP_NAME=$2

# Diretório onde será salvo o ícone com o nome personalizado
BACKUP_DIR="$CURRENT_DIR/../images"

# Caminho base do tema
THEME_PATH="$HOME/.local/share/icons/Gruvbox-Plus-Dark/apps/48"

# Garante que o diretório de backup já exista
mkdir -p "$BACKUP_DIR"

# Verifica se o diretório do tema já existe
if [ ! -d "$THEME_PATH" ]; then
    echo "❗ Diretório do tema não existe!"
    echo "👉 Baixe e coloque em: ~/.local/share/icons/"
    exit 1
fi

# fonte do ícone original
SRC_ICON="$THEME_PATH/$ORIG.svg"

# Verifica se o ícone original já existe
if [ ! -f "$SRC_ICON" ]; then
    echo "❌ ícone original não encontrado: $SRC_ICON"

    # limpar ícones parcialmente criados
    sed -i "/^$ORIGINAL_NAME/d" "$ICON_LIST"    

    echo "🗑️ Ícone removido da lista"

    exit 1
fi

# fonte do link simbólico na pasta de backup
SRC_LINK="$BACKUP_DIR/$APP_NAME.svg"

# Cria ou atualiza o link simbólico
ln -sf "$SRC_ICON" "$SRC_LINK"
echo "🔗 Novo ícone: $APP_NAME, criado"