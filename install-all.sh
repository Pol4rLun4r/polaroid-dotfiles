#!/bin/bash

# habilitá o sudo no inicio
sudo -v

# Flag de confirmação automática
AUTO_CONFIRM=""

# Lê as opções
while getopts ":y" opt; do
  [[ $opt == "y" ]] && AUTO_CONFIRM="-y"
done

# pasta padrão dos dotfiles
SRC_BASE=$(dirname $(realpath "$0"))

if [[ "$AUTO_CONFIRM" = "-y" ]]; then
  CONFIRM_INIT="y"
else
  read -p "📑 Começando a instalação das dotfiles, ao iniciar será pedido para reiniciar a sessão algumas vezes, deseja prosseguir? (y/n):" CONFIRM_INIT
  echo
fi

if [[ "$CONFIRM_INIT" =~ ^[yY]$ ]]; then

# baixas os wallpapers para o pc
bash "$SRC_BASE/wallpapers/apply-wallpapers.sh"

# baixa e instala as extensões no sistema
bash "$SRC_BASE/gnome/main.sh" $AUTO_CONFIRM

# Instala os apps no sistema
bash "$SRC_BASE/apps/main.sh" $AUTO_CONFIRM

# aplica o tema de ícones no sistema
bash "$SRC_BASE/icons/main.sh"

else
    echo "🔸 Instalação dos dotfiles cancelada"
    exit 0
fi

read -p "🔁 Deseja fazer logout para aplicar todas as mudanças? (y/n):" CONFIRM

if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
    echo "🚪 saindo em 3s segundos..."
    sleep 3

    gnome-session-quit --logout --no-prompt
fi