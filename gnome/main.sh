#!/bin/bash

# script que instala as extensões

# solicita senha do sudo para manter a sessão ativa
sudo -v

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

echo -e "📋 Instalando extensões do arquivo extensions-list.txt...\n"
echo -e "🔍 Procurando extensões...\n"

# arquivo que informa o script qual etapa ele deve seguir, fazer download ou instalar
STATE="$CURRENT_DIR/state.txt"

# verifica se já foi feito o download das extensões, se sim vai pra próxima etapa de instalar elas
if [ ! -f "$STATE" ] || ! grep -q "downloaded" "$STATE"; then
    bash "$CURRENT_DIR/download-extensions.sh"
else
    bash "$CURRENT_DIR/install-extensions.sh"
fi

# compile-extensions

echo -e "\n✅ Todas as extensões processadas!"