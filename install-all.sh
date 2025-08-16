#!/bin/bash

# habilitá o sudo no inicio
sudo -v

# Flag de confirmação automática
AUTO_CONFIRM="-y"

# pasta padrão dos dotfiles
SRC_BASE=$(dirname $(realpath "$0"))

# baixas os wallpapers para o pc
bash "$SRC_BASE/wallpapers/apply-wallpapers.sh"

# baixa e instala as extensões no sistema
bash "$SRC_BASE/gnome/main.sh" $AUTO_CONFIRM

# aplica o tema de ícones no sistema
bash "$SRC_BASE/icons/main.sh" $AUTO_CONFIRM

# Instala os apps no sistema
bash "$SRC_BASE/apps/main.sh" $AUTO_CONFIRM

exit 0