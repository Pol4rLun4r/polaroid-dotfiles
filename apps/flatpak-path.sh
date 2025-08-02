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
    clear

    echo "+ Adicionando suporte ao Flatpak" >> "$PROFILE"
    echo "$LINE" >> "$PROFILE"
    echo -e "+ Variável XDG_DATA_DIRS adicionada ao $PROFILE\n"

    tput bold;
    echo "🚪 Fazendo logout para aplicar mudanças, após isso entre e inicie o script novamente"
    echo "saindo em 10 segundos...";
    tput sgr0

    sleep 10

    gnome-session-quit --logout --no-prompt
}

# Adiciona a linha se ainda não estiver presente
if ! grep -q "XDG_DATA_DIRS=" "$PROFILE"; then
    if [ "$AUTO_CONFIRM" = true ]; then
        fix_dir
    else
        echo -e "⚠️  Antes de prosseguir com a instalação dos apps flatpaks, precisamos configurar algumas coisas e será preciso reiniciar a sessão.\n"

        tput bold;
        echo -e "(y) Sim, prosseguir\n"
        echo -e "(n) Não, cancelar instalação dos flatpaks\n";
        tput sgr0

        tput bold; read -p "deseja prosseguir? [y/n]:" CONFIRM; tput sgr0

        clear
        if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
            fix_dir
        else
            echo -e "❗ Processo de instalação dos flatpaks cancelada\n"
            exit 0
        fi
    fi
else
    echo "+ A variável XDG_DATA_DIRS já está configurada no $PROFILE"
fi
