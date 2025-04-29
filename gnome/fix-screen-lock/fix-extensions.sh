#!/bin/bash

# corrige as extensões após desbloquear a tela

# Diretório base
DIR="$HOME/.dotfiles/gnome/fix-screen-lock"

# arquivo do service
mkdir -p ~/.config/systemd/user
FILE="$HOME/.config/systemd/user/reload-extensions.service"
touch "$FILE"

# arquivo de referencia para criar o service
BASE_FILE="$DIR/base_service_file.txt"

# copiar o conteúdo do arquivo base para o arquivo do serviço
cat "$BASE_FILE" > "$FILE" 

# substituir o caminho do script dentro do arquivo de serviço
sed -i "s|/home/user/.dotfiles/gnome/fix-screen-lock/reload-extensions-busctl.sh|$DIR/reload-extensions-busctl.sh|g" "$FILE"

# recarregar o systemd e iniciar o serviço
systemctl --user daemon-reload
systemctl --user enable reload-extensions.service   # habilita o serviço para iniciar automaticamente
systemctl --user start reload-extensions.service