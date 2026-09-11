#!/bin/bash

# Instala dependências necessárias para as extensões GNOME.

# solicita senha do sudo para manter a sessão ativa
sudo -v

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

echo -e "\n📦 Instalando dependências das extensões GNOME...\n"
if ! sudo apt install gir1.2-gtop-2.0 libgtop2-dev -y; then
    echo "❌ Não foi possível instalar as dependências das extensões GNOME."
    exit 1
fi

# Registra a conclusão da etapa apenas após a instalação bem-sucedida.
STATE="$CURRENT_DIR/state.txt"
echo "dependencies" >> "$STATE"
