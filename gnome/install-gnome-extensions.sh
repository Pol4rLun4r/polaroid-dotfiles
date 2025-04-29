#!/bin/bash

# script para baixar e instalar extensões gnomes

sudo echo ""

# lista com as extensões gnome
LIST="$HOME/.dotfiles/gnome/extensions-enabled.txt"

# versão do gnome-shell
SHELL_VERSION=$(gnome-shell --version | cut -d ' ' -f 3 | cut -d '.' -f 1)

# Verificar se o arquivo de extensões existe
if [ ! -f "$LIST" ]; then
    echo "❌ Arquivo extensions-enabled.txt não encontrado!"
    exit 1
fi

# Instalar extensões listadas
echo "📋 Instalando extensões do arquivo extensions-enabled.txt..."

echo "🔍 Procurando extensões..."

while read -r uuid; do
    # Buscar usando UUID + Shell Version
    info=$(curl -s "https://extensions.gnome.org/extension-info/?uuid=$uuid&shell_version=$SHELL_VERSION" | jq -r '.download_url')
    
    if [ "$info" == "null" ] || [ -z "$info" ]; then
        echo "❌ Extensão '$uuid' não encontrada ou incompatível com GNOME $SHELL_VERSION."
        continue
    fi


    # Baixar e instalar extensão pela url
    name_file=$(echo "$uuid" | cut -d '@' -f 1)
    TEMP_FILE="/tmp/ext/$name_file"

    download_url="https://extensions.gnome.org/$info"

    curl -sL \
    -H "User-Agent: Mozilla/5.0" \
    -H "Referer: https://extensions.gnome.org/" \
    "$download_url" \
    -o "$TEMP_FILE"

    if [ -f "$TEMP_FILE" ]; then
        echo "❗ Falha na tentativa de baixar: $name_file"
        continue
    fi

    EXT_DIR="$HOME/.local/share/gnome-sell/extensions/$uuid"
    mkdir -p "$EXT_DIR"
    unzip -qo "$TEMP_FILE" -d "$EXT_DIR"
    rm -r "$TEMP_FILE"

    if [ -f "$EXT_DIR" ]; then
        echo "❗ Falha ao extrair: $name_file"
        continue
    fi    

   if gnome-extensions enable "$uuid" 2> /dev/null; then
        echo "✅ Extensão ativada com sucesso!"
    else
        echo "❌ Falha ao ativar a extensão ou ela não está instalada."
    fi

done < "$LIST"

echo "✅ Todas as extensões instaladas e ativadas!"

echo "💽 Talvez seja necessário reiniciar a sessão para que todas as extensões funcionem com exito"


# Ativar extensões instaladas
# echo "🔧 Ativando extensões instaladas..."

# sleep 3

# while read -r uuid; do
#     if [ ! -z "$uuid" ]; then
#         echo "🔹 Ativando extensão: $uuid"
#         gnome-extensions enable "$uuid"
#     fi
# done < "$LIST"