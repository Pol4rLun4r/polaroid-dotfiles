#!/bin/bash

# habilitá o sudo por padrão
sudo echo ""

# pasta padrão dos dotfiles
SRC_BASE="$HOME/.dotfiles"

# source "$SRC_BASE/wallpapers/apply-wallpapers.sh

# instala os apps no sistema
bash "$SRC_BASE/apps/main.sh" 

# aplica o tema de ícones no sistema
bash "$SRC_BASE/icons/main.sh"

# baixa e instala as extensões no sistema
# bash "$SRC_BASE/gnome/install-gnome-extensions.sh"

# corrige o erro da tela de bloqueio do gnome juntamente com as extensões
bash "$SRC_BASE/gnome/fix-screen-lock/main.sh"

echo "🔁 Deseja fazer logout para aplicar todas as mudanças? (y/n):"
read CONFIRM 

if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
    echo "🔧 saindo em..."
    for i in $(seq 5 -1 1); do
        echo "⏳ $i"
        sleep 1
    done

    gnome-session-quit --logout --no-prompt
fi