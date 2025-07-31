#!/bin/bash

# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

STATE="$CURRENT_DIR/../state.txt"
echo "fix-screen" >> "$STATE"

echo -e "\n+ Aplicando correções para bloqueio de tela no GNOME..."

# Evitar suspensão automática (AC = energia ligada)
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

# Evitar suspensão automática (Bateria = laptops, mas deixa configurado também)
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

# Definir tempo para desligar a tela como 0 (nunca) – se quiser, pode ajustar manualmente depois
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0

# Configurar bloqueio automático, mas sem apagar tela
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend true
gsettings set org.gnome.desktop.screensaver idle-activation-enabled true

echo "+ Correções aplicadas!"