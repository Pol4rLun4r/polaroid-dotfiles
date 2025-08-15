#!/bin/bash

# script para criar lista de ícones personalizados
 
# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

# Caminho do arquivo icons.list
ICON_DIR="$CURRENT_DIR/.."
ICON_LIST="$CURRENT_DIR/../icons.list"

# Ciano escuro - setaf 6
color_text=$(tput setaf 6)
# Verde claro — setaf 10
color_text_highlights=$(tput setaf 10)
# Negrito
bold=$(tput bold)
# Reset
reset=$(tput sgr0)

# Cria o diretório, se não existir
mkdir -p "$ICON_DIR"

# Entrada interativa
echo -e "${color_text}Atualmente é apenas possível alterar ícones de Apps baixados via ${bold}${color_text_highlights}Snap ${reset}${color_text}ou ${bold}${color_text_highlights}Flatpak${reset}\n"

echo -e "📦 Escolha o tipo de ícone:\n"

tput bold;
echo -e "(1) Flatpak\n"
echo -e "(2) Snap\n";
tput sgr0

echo -e "(q) Sair e não fazer nada.\n"

tput bold; read -p "Escolha [1/2/q]: " ICON_TYPE_CHOICE; tput sgr0

case "$ICON_TYPE_CHOICE" in
    1) ICON_TYPE="flatpak" ;;
    2) ICON_TYPE="snap" ;;
    q) clear; exit 0 ;;
    *) echo "❌ Opção inválida. Cancelando..."; exit 1 ;;
esac

clear

echo -e "+ Tipo de ícone selecionado: $ICON_TYPE\n"

read -p "🔹 Nome original do ícone sem extensão (ex: chatgpt): " ORIGINAL_NAME
echo
read -p "🔹 Nome do arquivo .desktop sem extensão (ex: chatgpt_desktop ou io.freetubeapp.FreeTube): " APPLICATION_NAME

# Verifica se algo foi preenchido
if [ -z "$ORIGINAL_NAME" ] || [ -z "$APPLICATION_NAME" ]; then
    echo "❌ Nome inválido. Ambos os campos são obrigatórios."
    exit 1
fi

# Função que adiciona o ícone á lista e cria um link simbólico
adicionar_icone() {
    bash "$CURRENT_DIR/symbolic-icon.sh" "$ORIGINAL_NAME" "$APPLICATION_NAME"
 
    echo "$ORIGINAL_NAME $APPLICATION_NAME $ICON_TYPE" >> "$ICON_LIST"
    echo "+ Ícone adicionado à lista: $ORIGINAL_NAME -> $APPLICATION_NAME ($ICON_TYPE)"
}

# Verifica se o APPLICATION_NAME já existe para o mesmo tipo
if [ -f "$ICON_LIST" ]; then
    EXISTING_LINE=$(grep -E "^[^ ]+ $APPLICATION_NAME $ICON_TYPE$" "$ICON_LIST")

    if [ -n "$EXISTING_LINE" ]; then
        EXISTING_ORIG=$(echo "$EXISTING_LINE" | cut -d' ' -f1)

        clear

        echo -e "+ O app '$APPLICATION_NAME' já está usando o ícone: '$EXISTING_ORIG'.svg\n"
        read -p "🔹 Deseja substituir o ícone atual por '$ORIGINAL_NAME'.svg? (y/n): " CONFIRM
        echo
        
        if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
            # Remove a linha anterior
            sed -i "/^$EXISTING_ORIG $APPLICATION_NAME $ICON_TYPE$/d" "$ICON_LIST"

            # Remove ícone antigo
            OLD_ICON_PATH="$CURRENT_DIR/../images/$APPLICATION_NAME.svg"
            
            if [ -f "$OLD_ICON_PATH" ]; then
                rm "$OLD_ICON_PATH"
                echo "+ Ícone antigo removido: $OLD_ICON_PATH"
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
