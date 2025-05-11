#!/bin/bash

# Verifica se o kgx está instalado
if ! command -v kgx &>/dev/null; then
  echo "📦 Instalando GNOME Console..."
  sudo apt update
  sudo apt install -y gnome-console
fi

# Verifica se o kgx está disponível
if ! command -v kgx &>/dev/null; then
  echo "❌ GNOME Console (kgx) não encontrado após instalação."
  exit 1
fi

# Define o GNOME Console como terminal padrão
echo "⚙️  Definindo GNOME Console como terminal padrão..."
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kgx 50
sudo update-alternatives --set x-terminal-emulator /usr/bin/kgx

# Garante que o Ctrl+Alt+T abra o GNOME Console
echo "🎯 Alterando atalho Ctrl+Alt+T para GNOME Console..."
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/ name "'Terminal'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/ command "'kgx'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/ binding "'<Control><Alt>t'"

echo "✅ GNOME Console está instalado e configurado como padrão!"
