#!/bin/bash

# script para criar lista de ícones personalizados
 
# Caminho do arquivo icons.list
ICON_DIR="$HOME/.dotfiles/icons"
ICON_LIST="$ICON_DIR/icons.list"

# Cria o diretório, se não existir
mkdir -p "$ICON_DIR"

# Entrada interativa
echo "📦 Escolha o tipo de ícone:"
echo "1) Flatpak"
echo "2) Snap"

read -p "👉 Digite o número da opção (1 ou 2): " ICON_TYPE_CHOICE

case "$ICON_TYPE_CHOICE" in
    1)
        ICON_TYPE="flatpak"
        ;;
    2)
        ICON_TYPE="snap"
        ;;
    *)
        echo "❌ Opção inválida. Cancelando..."
        exit 1
        ;;
esac

echo "✅ Tipo de ícone selecionado: $ICON_TYPE"

read -p "🔹 Nome original do ícone sem extensão (ex: chatgpt): " ORIGINAL_NAME
read -p "🔹 Nome do arquivo .desktop sem extensão (ex: chatgpt_desktop ou io.freetubeapp.FreeTube): " APPLICATION_NAME

# Verifica se algo foi preenchido
if [ -z "$ORIGINAL_NAME" ] || [ -z "$APPLICATION_NAME" ]; then
    echo "❌ Nome inválido. Ambos os campos são obrigatórios."
    exit 1
fi

# Função que adiciona o ícone á lista e cria um link simbólico
adicionar_icone() {
    bash "$HOME/.dotfiles/icons/change-icon/symbolic-icon.sh" "$ORIGINAL_NAME" "$APPLICATION_NAME"
 
    echo "$ORIGINAL_NAME $APPLICATION_NAME $ICON_TYPE" >> "$ICON_LIST"
    echo "✅ Ícone adicionado à lista: $ORIGINAL_NAME -> $APPLICATION_NAME ($ICON_TYPE)"
}

# Verifica se o APPLICATION_NAME já existe para o mesmo tipo
if [ -f "$ICON_LIST" ]; then
    EXISTING_LINE=$(grep -E "^[^ ]+ $APPLICATION_NAME $ICON_TYPE$" "$ICON_LIST")

    if [ -n "$EXISTING_LINE" ]; then
        EXISTING_ORIG=$(echo "$EXISTING_LINE" | cut -d' ' -f1)

        echo "🔁 O app '$APPLICATION_NAME' já está usando o ícone: '$EXISTING_ORIG'.svg"
        read -p "👉 Deseja substituir o ícone atual por '$ORIGINAL_NAME'.svg? (y/n): " CONFIRM

        if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
            # Remove a linha anterior
            sed -i "/^$EXISTING_ORIG $APPLICATION_NAME $ICON_TYPE$/d" "$ICON_LIST"

            # Remove ícone antigo
            OLD_ICON_PATH="$HOME/.dotfiles/icons/images/$APPLICATION_NAME.svg"
            
            if [ -f "$OLD_ICON_PATH" ]; then
                rm "$OLD_ICON_PATH"
                echo "🗑️ Ícone antigo removido: $OLD_ICON_PATH"
            fi

            # Adiciona novo ícone
            adicionar_icone
            exit 0
        else
            echo "❌ Cancelado. Nenhuma alteração feita."
            exit 0
        fi
    fi
fi

# Verifica se o par exato já existe
if [ -f "$ICON_LIST" ] && grep -Fxq "$ORIGINAL_NAME $APPLICATION_NAME $ICON_TYPE" "$ICON_LIST"; then
    echo "⚠️ Esse par já existe na lista: $ORIGINAL_NAME $APPLICATION_NAME"
    exit 0
else 
    # Adiciona o novo icone
    adicionar_icone
fi
