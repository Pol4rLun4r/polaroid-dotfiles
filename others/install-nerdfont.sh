#!/bin/bash

# script para instalar "hack nerd font" para ser usada posteriormente junto como o "oh-my-zsh"

sudo -v

# verifica se o unzip está presente no sistema
if ! command -v unzip &> /dev/null; then
    sudo apt install -y unzip
fi

# url de download da font
DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip"

# diretório temporário juntamente com o nome do arquivo
TMP_DIR=$(mktemp -d)
TMP_FILE="$TMP_DIR/hack.zip"

# diretório das fonts
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

echo -e "+ Baixando a font"

# baixa o arquivo
if ! wget -qO "$TMP_FILE" "$DOWNLOAD_URL"; then
    echo -e "\n❌ Falha ao baixar a font"
    exit 1
fi

# descompacta o arquivo para a pasta temporária
if ! unzip "$TMP_FILE" -d "$TMP_DIR" ;then
    echo -e "\n❌ Falha ao descompactar a font"
    exit 1
fi

# move os arquivos para o diretório de fonts do usuário
if ! mv "$TMP_DIR"/*.ttf "$FONT_DIR"; then
    echo -e "\n❌ Falha ao mover arquivos"
    exit 1
fi

# apaga o diretório temporário
rm -r "$TMP_DIR"

# atualiza cache de fonts
fc-cache -fv > /dev/null

echo -e "\n✅ Fonts baixadas e instaladas com sucesso"