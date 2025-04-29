#!/bin/bash

# Script para baixar e instalar o tema de ícones Gruvbox-Plus-Dark

# Diretório dos ícones do sistema
DEST="$HOME/.local/share/icons"
mkdir -p "$DEST"

# Local temporário para manipular o .zip
TEMP_DIR=$(mktemp -d)
TEMP="$TEMP_DIR/icons.zip"

# api do git que trás o arquivo mais recente
API_URL="https://api.github.com/repos/SylEleuth/gruvbox-plus-icon-pack/releases/latest"

# pequena "função" para pegar o download direto do repositório (sempre o mais recente)
ICON_URL=$(wget -qO- "$API_URL" \
| grep browser_download_url \
| grep -m 1 '.zip' \
| cut -d '"' -f 4)

if [ ! -d "$HOME/.local/share/icons/Gruvbox-Plus-Dark" ]; then 
    # Faz download do pacote de ícones
    echo "⬇️ Baixando tema..."
    wget --quiet --show-progress --progress=bar:force:noscroll -O "$TEMP" "$ICON_URL"
    echo "✅ Download completo"


    # descompacta o pacote de ícones baixados e o direciona ao diretório
    echo "🗃️ descompactando pacote..."

    if unzip -qo "$TEMP" "Gruvbox-Plus-Dark/*" -d "$DEST"; then
        echo "✅ Descompactado com sucesso"
    else
        echo "❌ Erro ao descompactar"
        exit 1
    fi

    # apaga o arquivo temporário
    rm -r "$TEMP_DIR"
fi

echo "🖌️ aplicando ícones..."

# aplica o pacote de ícones no ubuntu 
gsettings set org.gnome.desktop.interface icon-theme "Gruvbox-Plus-Dark"

# aplica o tema escuro para o ubuntu
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'


# restauração dos ícones personalizados
source ~/.dotfiles/icons/personalized-icons.sh

# Corrige ícones personalizados para outros usuários
bash "$HOME/.dotfiles/icons/fix-icons.sh"

echo "🎉 Tema de ícones aplicado com sucesso!"
