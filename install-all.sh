#!/bin/bash

# habilitá o sudo no inicio
sudo -v

# pasta padrão dos dotfiles
SRC_BASE=$(dirname $(realpath "$0"))

read -p "📑 Começando a instalação das dotfiles, ao iniciar será pedido para reiniciar a sessão algumas vezes, deseja prosseguir? (y/n):" CONFIRM_INIT
echo

if [[ "$CONFIRM_INIT" =~ ^[yY]$ ]]; then

# source "$SRC_BASE/wallpapers/apply-wallpapers.sh

# instala os apps no sistema
# bash "$SRC_BASE/apps/main.sh" 

# aplica o tema de ícones no sistema
# bash "$SRC_BASE/icons/main.sh"

# baixa e instala as extensões no sistema
# bash "$SRC_BASE/gnome/install-gnome-extensions.sh"

# corrige o erro da tela de bloqueio do gnome juntamente com as extensões
# bash "$SRC_BASE/gnome/fix-screen-lock/main.sh"

else
    echo "🔸 Instalação dos dotfiles cancelada"
    exit 0
fi

read -p "🔁 Deseja fazer logout para aplicar todas as mudanças? (y/n):" CONFIRM

if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
    echo "🔧 saindo em..."
    for i in $(seq 5 -1 1); do
        echo "⏳ $i"
        sleep 1
    done

    gnome-session-quit --logout --no-prompt
fi