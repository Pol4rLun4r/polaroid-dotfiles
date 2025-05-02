#!/bin/bash

# script que instala as extensões

# solicita senha do sudo para manter a sessão ativa
sudo -v

# Flag de confirmação automática
AUTO_CONFIRM=""

# Lê as opções
while getopts ":y" opt; do
  case $opt in
    y)
      AUTO_CONFIRM="-y"
      ;;
  esac
done

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

echo -e "📋 Instalando extensões do arquivo extensions-list.txt...\n"
echo -e "🔍 Procurando extensões...\n"

# arquivo que informa o script qual etapa ele deve seguir, fazer download ou instalar
STATE="$CURRENT_DIR/download-install/state.txt"

# verifica se já foi feito o download das extensões, se sim vai pra próxima etapa de instalar elas
if [ ! -f "$STATE" ] || ! grep -q "downloaded" "$STATE"; then
    bash "$CURRENT_DIR/download-install/download-extensions.sh" $AUTO_CONFIRM
else
    bash "$CURRENT_DIR/download-install/install-extensions.sh"
fi

# aplicar correção da tela de bloqueio
bash "$CURRENT_DIR/fix-screen-lock/fix-gnome-screen-lock.sh"

# restaura configurações das extensões
bash "$CURRENT_DIR/backup-restore/extensions-restore.sh" $AUTO_CONFIRM

echo -e "\n✅ Todas as extensões processadas!"