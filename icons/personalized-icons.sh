#!/bin/bash

# script para restauração dos ícones personalizados

# Caminho dos .desktop modificados (nos dotfiles)
SRC_DOTFILES="$HOME/.dotfiles/icons/applications"

# Caminho dos .desktop do sistema
SRC_SYS="$HOME/.local/share/applications"

if [ ! -d "$SRC_DOTFILES" ]; then
    echo "❌ diretório não encontrado: $SRC_DOTFILES"
    exit 1
fi

# Garante que o diretório necessário exista
mkdir -p "$SRC_SYS"

# Itera sobre todos os arquivos .desktop no diretório dos dotfiles
for desktop_file in "$SRC_DOTFILES/"*.desktop; do
    # extrai apenas o nome do arquivo
    filename=$(basename "$desktop_file")

    # Cria ou atualiza o link simbólico no sistema
    ln -sf "$desktop_file" "$SRC_SYS/$filename"

    # Substitui o nome de usuário no caminho do Icon=
    sed -i "s|/home/[^/]*/\.dotfiles|/home/$USER/.dotfiles|" "$SRC_SYS/$filename"

    echo "🔗 Vinculado: $filename"
done

echo "✅ Todos os atalhos personalizados foram linkados e corrigidos com sucesso!"