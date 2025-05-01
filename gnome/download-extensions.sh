#!/bin/bash

# Script que faz o download, extrai e compila a extensões

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

# caminho do arquivo com UUIDs das extensões
LIST="$CURRENT_DIR/extensions-list.txt"

# Obtém versão major do GNOME Shell (ex: 44, 45)
SHELL_VERSION=$(gnome-shell --version | cut -d ' ' -f 3 | cut -d '.' -f 1)

# Verifica se o arquivo existe
if [ ! -f "$LIST" ]; then
    echo "❌ Arquivo extensions-list.txt não encontrado!"
    exit 1
fi

# cria um arquivo que lista as extensões que tiveram exito ao serem baixadas
EXTRACTED_EXT="$CURRENT_DIR/extracted-extensions.txt"

# cria ou zera o arquivo    
> "$EXTRACTED_EXT"

# cria pasta temporária para downloads
mkdir -p /tmp/ext

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

    # diretório onde fica a extensão
    EXT_DIR="$HOME/.local/share/gnome-shell/extensions/$uuid"
    mkdir -p "$EXT_DIR"

    # verifica se a extensão já existe
     if [ -d "$EXT_DIR" ]; then
        echo "📦 Extensão já baixada: $name_file"
        echo "$uuid" >> "$EXTRACTED_EXT"
        continue
    fi

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
    if ! unzip -qo "$TEMP_FILE" -d "$EXT_DIR"; then
        echo "❌ Falha ao extrair o arquivo: $TEMP_FILE"
        continue
    fi

    rm -f "$TEMP_FILE"    

    # registra a extensão que teve sucesso ao extrair
    echo "$uuid" >> "$EXTRACTED_EXT"

done < "$LIST"

# compilar esquemas GSettings, se houver
compile-extension() {
    local UUID=$1 # uuid da extensão
    local EXTENSION_DIR="$HOME/.local/share/gnome-shell/extensions/$UUID" # diretório da extensão
    local SCHEMA_DIR="$EXTENSION_DIR/schemas"

    if [ -d "$SCHEMA_DIR" ]; then
        glib-compile-schemas "$SCHEMA_DIR"
    fi
}

while read -r uuid; do
    compile-extension "$uuid"
done < "$EXTRACTED_EXT"

# arquivo que informa o script qual etapa ele deve seguir, fazer download ou instalar
STATE="$CURRENT_DIR/state.txt"
echo "downloaded" > "$STATE"

echo -e "✅ Processo de download e compilação finalizado!\n"

echo "⚠️  É preciso reiniciar a sessão para que todas as extensões funcionem corretamente, salve as tarefas atuais antes de prosseguir"
read -p "deseja reiniciar? note que ao pular essa etapa as extensões não serão instaladas (y/n):" CONFIRM

if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
    echo -e "\n🚪 Saindo da sessão em 10 segundos, após isso inicie o script novamente para concluir a instalação"
    sleep 10

    exit 0
    # gnome-session-quit --logout --no-prompt
else
    echo -e "\n⚠️  Reinicie a sessão em outro momento para finalizar a instalação das extensões\n"
    sleep 5
    echo "<=============================================>"
fi