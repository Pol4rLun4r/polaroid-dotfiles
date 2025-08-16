#!/bin/bash

# script para restaurar configurações das extensões

# Flag de confirmação automática
AUTO_CONFIRM=false

# Lê a flag -y, se passada
while getopts ":y" opt; do
  case $opt in
    y)
      AUTO_CONFIRM=true
      ;;
  esac
done

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

# arquivo de backup
BACKUP_FILE="$CURRENT_DIR/extensions-settings.dconf"

if [ ! -f "$BACKUP_FILE" ]; then
    echo "❗ Arquivo de backup não existe"
else
    echo -e "\n+ Restaurando backup das configurações das extensões GNOME..."

    dconf load /org/gnome/shell/extensions/ < "$BACKUP_FILE"

    echo "+ Restauração das configurações de extensões concluída"
fi

STATE="$CURRENT_DIR/../state.txt"
echo "ext-restore" >> "$STATE"

if [ "$AUTO_CONFIRM" = true ]; then
    echo
    bash "$CURRENT_DIR/../../others/reload-message.sh"
    echo -e "\n🚪 Reinício automático da sessão em 10 segundos."
    sleep 10
    gnome-session-quit --logout --no-prompt
    exit 0
fi

echo -e "\n⚠️  É preciso reiniciar a sessão para que todas as configurações das extensões carregam, salve as tarefas atuais antes de prosseguir, note que ao pular essa etapa as configurações das extensões não serão aplicadas corretamente."
read -p "deseja reiniciar?(y/n):" CONFIRM

if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
    echo -e "\n🚪 Saindo da sessão em 5 segundos, após isso inicie o script novamente para continuar com as demais automações"
    sleep 5

    gnome-session-quit --logout --no-prompt
    exit 0
else
    clear

    tput bold;
    echo -e "⚠️  Reinicie a sessão em outro momento para finalizar as configurações das extensões"
    echo -e "aguarde...\n";
    tput sgr0

    sleep 3
fi