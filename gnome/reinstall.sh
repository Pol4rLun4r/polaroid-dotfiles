#!/bin/bash

# arquivo de exemplo de todas as etapas completas
REQUIRED="$CURRENT_DIR/required.txt"

# arquivo que mostra em qual etapa está
STATE="$CURRENT_DIR/state.txt"

all_present=true

reinstall () {
    clear

    echo -e "⚠️  As Extensões já estão instaladas, deseja reinstalar para reparar algum bug?\n"

    tput bold;
    echo -e "(y) Sim, reinstalar extensões\n"
    echo -e "(n) Não, finalizar instalação\n";
    tput sgr0

    tput bold; read -p "Escolha [y/n]: " CONFIRM; tput sgr0

    if [[ "$CONFIRM" =~ ^[yY]$ ]]; then
        # apaga o arquivo state
        rm -r "$CURRENT_DIR/state.txt"
        # reinicia o instalador
        clear
        bash "$CURRENT_DIR/main.sh"
    fi
}

while read -r item;do
    if ! grep -qxF "$item" "$STATE"; then
        all_present=false
    fi
done < "$REQUIRED"

if $all_present; then
    reinstall
fi

clear