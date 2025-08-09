#!/bin/bash

# Ciano escuro - setaf 6
color_text=$(tput setaf 6)
# Verde claro — setaf 10
color_polar_dot=$(tput setaf 10)
# Negrito
bold=$(tput bold)
# Reset
reset=$(tput sgr0)

echo "${color_text}dica, use o comando ${bold}${color_polar_dot}polar-dot${reset}${color_text} no terminal para iniciar o script de qualquer lugar!${reset}"
