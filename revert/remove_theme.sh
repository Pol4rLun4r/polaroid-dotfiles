#!/bin/bash

#script que remove o tema Gruvbox (ícones e cores)

# Diretório dos ícones do sistema
DEST="$HOME/.local/share/icons/Gruvbox-Plus-Dark"

# local onde ficam os .desktop do sistema
SYS_DOT_ICONS="$HOME/.local/share/applications"

# .desktop dos ícones
DOT_ICONS="$SRC_BASE/icons/applications"

removeFunction () {
    clear

    if [ ! -d $DEST ]; then
        echo "! Diretório do tema não existe"
        exit 1
    fi

    # apaga apenas os ícones personalizados
    for dotIcon in "$DOT_ICONS/"*; do
        iconName=$(basename "$dotIcon")

        path_icon="$SYS_DOT_ICONS/$iconName"

       [ -f "$path_icon" ] && rm -r "$path_icon"
    done 

    # apaga a pasta do tema
    rm -r "$DEST"
}

removeTheme () {
    clear

    echo  "⚠️  Tem certeza que deseja remover o Tema e seus Ícones?"
    echo -e "É altamente recomendado que reinicie o Computador caso prossiga com essa ação para evitar bugs.\n"

    tput bold;
    echo -e "(y) Sim, o remover Tema e Ícones\n"
    echo -e "(n) Não, voltar para o menu anterior\n";
    tput sgr0

    tput bold; read -p "Escolha [y/n]: " CONFIRM; tput sgr0

    if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
        removeFunction
        echo "+ Tema e Ícones apagados"
    else 
        initDotFiles
    fi

}