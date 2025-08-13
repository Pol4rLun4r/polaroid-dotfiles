#!/bin/bash

# Ciano escuro - setaf 6
color_text=$(tput setaf 6)
# Verde claro — setaf 10
color_text_attention=$(tput setaf 10)
# Negrito
bold=$(tput bold)
# Reset
reset=$(tput sgr0)

# Verifica se o gnome-terminal está instalado
if ! command -v gnome-terminal &>/dev/null; then
  echo "+ Instalando GNOME Terminal..."
  sudo apt update
  sudo apt install -y gnome-terminal
fi

# Define o GNOME Terminal como terminal padrão
echo "+ Definindo GNOME Terminal como terminal padrão."
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/gnome-terminal 100
sudo update-alternatives --set x-terminal-emulator /usr/bin/gnome-terminal

# Redefine o atalho Ctrl+Alt+T para abrir o GNOME Terminal
echo "+${color_text} Alterando atalho ${bold}${color_text_attention}Ctrl+Alt+T${reset}${color_text} para GNOME Terminal.${reset}"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/ name "'Terminal'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/ command "'gnome-terminal'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/ binding "'<Control><Alt>t'"

echo -e "\n✅ GNOME Terminal está configurado como padrão!"