#!/bin/bash

# script que instala as extensões

# solicita senha do sudo para manter a sessão ativa
sudo -v

# Flag de confirmação automática
AUTO_CONFIRM=""

# Flag de confirmação
CONFIRM_INSTALL=false

# Lê as opções
while getopts ":y" opt; do
  [[ $opt == "y" ]] && AUTO_CONFIRM="-y" && CONFIRM_INSTALL=true
done

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

# arquivo que informa o script qual etapa ele deve seguir, fazer download ou instalar
STATE="$CURRENT_DIR/state.txt"

# função para verificar e executar etapa se necessário
run_if_not_done() {
  local step_name=$1
  local script_path=$2
  if [ ! -f "$STATE" ] || ! grep -q "$step_name" "$STATE"; then
    bash "$script_path" $AUTO_CONFIRM
  fi
}

# executa etapas conforme necessário
run_if_not_done "downloaded" "$CURRENT_DIR/download-install/download-extensions.sh"
run_if_not_done "installed" "$CURRENT_DIR/download-install/install-extensions.sh"
run_if_not_done "fix-screen" "$CURRENT_DIR/fix-screen-lock/fix-gnome-screen-lock.sh"
run_if_not_done "ext-restore" "$CURRENT_DIR/backup-restore/extensions-restore.sh"

if [[ "$CONFIRM_INSTALL" == false ]]; then
  source "$CURRENT_DIR/reinstall.sh"
fi

if [[ "$CONFIRM_INSTALL" == true ]]; then
  tput bold; echo -e "\n🎉 Todas as extensões processadas!\n"; tput sgr0
else
  tput bold; echo "🎉 Todas as extensões processadas!"; tput sgr0
fi