# pasta onde ficara os wallpapers
DEST="$HOME/.dotfiles/wallpapers/images"

if [ -d "$DEST" ]; then
    echo -e "❗ a pasta images já existe, pulando etapa dos wallpapers\n"
else
    mkdir -p "$DEST"

    # wallpapers compactados
    ARCHIVE="$HOME/.dotfiles/wallpapers/wallpapers.tar.xz"

    # descompactação dos wallpapers
    echo "⬇️ Descompactando wallpapers..."

    tar -xJvf "$ARCHIVE" --strip-components=1 -C "$DEST"

    echo "✅ Extração concluída"
fi