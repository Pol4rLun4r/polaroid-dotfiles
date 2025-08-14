#!/bin/bash

CURRENT_DIR=$(dirname $(realpath "$0"))
DOTFILES_DIR="$CURRENT_DIR"

# Negrito
bold=$(tput bold)
# Reset
reset=$(tput sgr0)
# Verde claro — setaf 10
color_text=$(tput setaf 10)

# encerra o script em caso de erro
set -e

# mostra erro amigável se algo falhar
trap 'echo "🚨 Ocorreu um erro no script. Por favor, verifique os comandos acima.";' ERR

echo "+ atualizando repositórios..."
sudo apt update

echo -e "\n+ Instalando pacotes..."
sudo apt install -y zsh git curl

echo "+ Pacotes instalados com sucesso."

# muda o shell padrão para Zsh, se necessário
if [[ "$SHELL" != *zsh ]]; then
    echo "🐚 Trocando shell padrão para Zsh..."
    chsh -s "$(which zsh)"
fi

# Instalar o oh-my-zsh
export RUNZSH=no
export CHSH=no

echo -e "\n+ Instalando oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instalar o Powerlevel10k
echo "+ Instalando o tema Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

echo -e "\n+ Powerlevel10k instalado com sucesso!"

# substitui arquivos por links simbólicos
ln -sf "$DOTFILES_DIR/zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/p10k.zsh" ~/.p10k.zsh

echo -e "\n+ Configurações aplicadas!"

echo -e "\n${bold}🎉 Instalação concluída com sucesso!"

echo -e "\nPara aplicar o ZSH como shell padrão, reinicie a sessão."
echo "Você também pode digitar '${color_text}zsh${reset}${bold}' agora para testar imediatamente.${reset}"