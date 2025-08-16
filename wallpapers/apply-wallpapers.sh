# Diretório atual
CURRENT_DIR=$(dirname $(realpath "$0"))

# pasta onde ficara os wallpapers
DEST="$CURRENT_DIR/images"

if [ -d "$DEST" ]; then
    tput bold; echo "* A pasta images já existe, pulando etapa dos wallpapers"; tput sgr0
else
    mkdir -p "$DEST"

    # wallpapers compactados
    ARCHIVE="$CURRENT_DIR/wallpapers.tar.xz"

    # descompactação dos wallpapers
    echo "⬇️ Descompactando wallpapers..."

    tar -xJvf "$ARCHIVE" --strip-components=1 -C "$DEST"

    echo "✅ Extração concluída"
fi