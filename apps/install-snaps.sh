#!/bin/bash
sudo echo "" #autoriza o sudo no inicio da linha

# Verifica se o snap está instalado
if ! command -v snap &> /dev/null; then
    echo "📦 Snap não encontrado. Instalando..."
    sudo apt update && sudo apt install -y snapd
else
    echo -e "✅ Snap já está instalado.\n"
fi

# Verifica se o arquivo de apps existe
LISTA="$HOME/.dotfiles/apps/snaps.list"
if [ ! -f "$LISTA" ]; then
    echo "❌ Arquivo $LISTA não encontrado!"
    exit 1
fi

# Instala os snaps da lista
echo "🚀 Instalando Snaps listados em $LISTA..."
while read -r app; do
    [ -z "$app" ] && continue #Ignora se a linha estiver vazia

    # Divide o nome e a flag (se existir)
    APP_NAME=$(echo "$app" | cut -d ',' -f 1 | xargs)
    FLAG=$(echo "$app" | cut -d ','  -f 2 | xargs)

    if snap list | grep -q "^$APP_NAME "; then
        echo "🔁 $APP_NAME já está instalado. Pulando..."
        continue
    fi

    echo "🔹 Instalando: $APP_NAME"

    #verifica se existe alguma flag na lista
    if [ -z "$FLAG" ]; then 
        sudo snap install "$APP_NAME"
    else
        sudo snap install "$APP_NAME" "$FLAG"
    fi

done < "$LISTA"

echo "✅ Instalação dos snaps finalizada."
