#!/bin/bash

# Ciano escuro - setaf 6
color_text=$(tput setaf 6)
# Verde claro — setaf 10
color_text_attention=$(tput setaf 10)
# Negrito
bold=$(tput bold)
# Reset
reset=$(tput sgr0)

# Verifica se o kgx está instalado
if ! command -v kgx &>/dev/null; then
  echo "+ Instalando GNOME Console..."
  sudo apt update
  sudo apt install -y gnome-console
fi

# Verifica se o kgx está disponível
if ! command -v kgx &>/dev/null; then
  echo "❌ GNOME Console (kgx) não encontrado após instalação."
  exit 1
fi

# Define o GNOME Console como terminal padrão
echo "+ Definindo GNOME Console como terminal padrão."
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kgx 50
sudo update-alternatives --set x-terminal-emulator /usr/bin/kgx

# Garante que o Ctrl+Alt+T abra o GNOME Console
echo "+${color_text} Alterando atalho ${bold}${color_text_attention}Ctrl+Alt+T${reset}${color_text} para GNOME Console.${reset}"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/ name "'Terminal'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/ command "'kgx'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/ binding "'<Control><Alt>t'"

echo -e "\n✅ GNOME Console está instalado e configurado como padrão!"
