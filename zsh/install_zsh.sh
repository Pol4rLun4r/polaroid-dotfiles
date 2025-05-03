#!/bin/bash

CURRENT_DIR=$(dirname $(realpath "$0"))
DOTFILES_DIR="$CURRENT_DIR"

# da permissão para o script executar com sudo o tempo todo
sudo -v

# encerra o script em caso de erro
set -e

# mostra erro amigável se algo falhar
trap 'echo "🚨 Ocorreu um erro no script. Por favor, verifique os comandos acima.";' ERR

echo "🔧 atualizando repositórios..."
sudo apt update

echo "📦 Instalando pacotes..."
sudo apt install -y zsh git curl

echo "✅ Pacotes instalados com sucesso."

# muda o shell padrão para Zsh, se necessário
if [[ "$SHELL" != *zsh ]]; then
    echo "🐚 Trocando shell padrão para Zsh..."
    chsh -s "$(which zsh)"
fi

# Instalar o oh-my-zsh
export RUNZSH=no
export CHSH=no

echo "⚙️ Instalando oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instalar o Powerlevel10k
echo "⚡ Instalando o tema Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

echo "✅ Powerlevel10k instalado com sucesso!"

# substitui arquivos por links simbólicos
ln -sf "$DOTFILES_DIR/zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/p10k.zsh" ~/.p10k.zsh

echo -e "\n✅ Configurações aplicadas!"
echo "🎉 Instalação concluída com sucesso!"

echo -e "\n🔁 Para aplicar o Zsh como shell padrão, reinicie a sessão."
echo "Você também pode digitar 'zsh' agora para testar imediatamente."
