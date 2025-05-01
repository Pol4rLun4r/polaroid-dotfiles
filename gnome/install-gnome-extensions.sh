#!/bin/bash

# script para baixar e instalar extensões do GNOME

# solicita senha do sudo para manter a sessão ativa
sudo -v

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

# caminho do arquivo com UUIDs das extensões
LIST="$CURRENT_DIR/extensions-enabled.txt"

# Obtém versão major do GNOME Shell (ex: 44, 45)
SHELL_VERSION=$(gnome-shell --version | cut -d ' ' -f 3 | cut -d '.' -f 1)

# Verifica se o arquivo existe
if [ ! -f "$LIST" ]; then
    echo "❌ Arquivo extensions-enabled.txt não encontrado!"
    exit 1
fi

# cria pasta temporária para downloads
mkdir -p /tmp/ext

echo -e "📋 Instalando extensões do arquivo extensions-enabled.txt...\n"
echo -e "🔍 Procurando extensões...\n"

while read -r uuid; do
    # busca info da extensão
    info=$(curl -s "https://extensions.gnome.org/extension-info/?uuid=$uuid&shell_version=$SHELL_VERSION" | jq -r '.download_url')

    if [ "$info" == "null" ] || [ -z "$info" ]; then
        echo "❌ Extensão '$uuid' não encontrada ou incompatível com GNOME $SHELL_VERSION."
        continue
    fi

    # Baixa a extensão
    name_file=$(echo "$uuid" | cut -d '@' -f 1)
    TEMP_FILE="/tmp/ext/$name_file.zip"
    download_url="https://extensions.gnome.org/$info"

    # verifica se a extensão já existe
    if [ -f "$TEMP_FILE" ]; then
        echo "💾 A seguinte extensão já foi baixada: $name_file"
        continue
    else
        curl -sL \
        -H "User-Agent: Mozilla/5.0" \
        -H "Referer: https://extensions.gnome.org/" \
        "$download_url" \
        -o "$TEMP_FILE"

        # verifica se teve sucesso ao baixar
        if [ -f "$TEMP_FILE" ]; then
            echo "✅ Sucesso ao baixar: $name_file"
        else
            echo "❗ Falha ao baixar: $name_file"
            continue
        fi

        # extrai a arquivo da extensão
        EXT_DIR="$HOME/.local/share/gnome-shell/extensions/$uuid"
        mkdir -p "$EXT_DIR"

        if ! unzip -qo "$TEMP_FILE" -d "$EXT_DIR"; then
            echo "❌ Falha ao extrair o arquivo: $TEMP_FILE"
            continue
        fi

        rm -f "$TEMP_FILE"
    fi
done < "$LIST"

# {

#     if [ ! -d "$EXT_DIR" ]; then
#         echo "❗ Falha ao extrair: $name_file"
#         continue
#     fi

#     if gnome-extensions enable "$uuid" 2> /dev/null; then
#         echo "✅ $uuid ativada com sucesso!"
#     else
#         echo "❌ Falha ao ativar a extensão '$uuid'."
#     fi
# }


echo -e "\n✅ Todas as extensões processadas!"
echo "💽 Talvez seja necessário reiniciar a sessão para que todas as extensões funcionem corretamente."