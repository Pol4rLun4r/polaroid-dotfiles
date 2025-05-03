#!/bin/bash

sudo -v #autoriza o sudo no inicio da linha

# Flag de confirmação automática
AUTO_CONFIRM=false

# Lê a flag -y, se passada
while getopts ":y" opt; do
  [[ $opt == "y" ]] && AUTO_CONFIRM=true
done

# Caminho dos diretórios Flatpak
FLATPAK_DIRS="/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"

# Caminho dos diretórios padrão do sistema
DEFAULT_DIRS="/usr/local/share:/usr/share"

# Nova linha a ser adicionada
LINE="export XDG_DATA_DIRS=\"$FLATPAK_DIRS:$DEFAULT_DIRS\""

# Alvo: .profile (pode usar .bashrc ou .zprofile se preferir)
PROFILE="$HOME/.profile"

fix_dir() {
    echo -e "\n# Adicionando suporte ao Flatpak" >> "$PROFILE"
    echo "$LINE" >> "$PROFILE"
    echo "✅ Variável XDG_DATA_DIRS adicionada ao $PROFILE"

    echo "🔁 Fazendo logout para aplicar mudanças, após isso entre e inicie o script novamente"
    echo "🔧 saindo em 3 segundos..."
    sleep 3

    gnome-session-quit --logout --no-prompt
}

# Adiciona a linha se ainda não estiver presente
if ! grep -q "XDG_DATA_DIRS=" "$PROFILE"; then
    if [ "$AUTO_CONFIRM" = true ]; then
        fix_dir
    else
        read -p "Antes de prosseguir com a instalação dos apps flatpaks, precisamos configurar algumas coisas e será preciso reiniciar a sessão, deseja prosseguir? (y/n):" CONFIRM

        if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
            fix_dir
        else
            echo "❗ processo de instalação dos flatpaks cancelada"
            exit 0
        fi
    fi
else
    echo -e "✅ A variável XDG_DATA_DIRS já está configurada no $PROFILE\n"
fi
