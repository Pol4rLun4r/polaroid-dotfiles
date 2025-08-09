#!/bin/bash

# Habilitar sudo
sudo -v

# Pasta padrão dos dotfiles
SRC_BASE=$(dirname $(realpath "$0"))

# script para habilitar comando global caso ele não exista
if ! which polar-dot > /dev/null 2>&1; then
  sudo ln -s "$SRC_BASE/main.sh" "/usr/local/bin/polar-dot"
fi

# menu principal do script
source "$SRC_BASE/options/init-dotfiles.sh"

# inicia o script principal
initDotFiles