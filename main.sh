#!/bin/bash

# Habilitar sudo
sudo -v

# Pasta padrão dos dotfiles
SRC_BASE=$(dirname $(realpath "$0"))

# menu principal do script
source "$SRC_BASE/options/init-dotfiles.sh"

# inicia o script principal
initDotFiles