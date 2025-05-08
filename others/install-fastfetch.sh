#!/bin/bash

# script para instalar o fastfetch

# ativa o sudo por padrão
sudo -v

echo -e "\n⬇️ Baixando fastfetch"

if [ ! command -v fastfetch ]; then
    echo -e "\n✅ fastfetch já está instalado"
    exit 0
fi

# adiciona o repositório do fastfetch
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch

# atualiza a lista de pacotes
sudo apt update

# instala o fastfetch
sudo apt install fastfetch

echo -e "\n✅ fastfetch instalado"