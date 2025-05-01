# Script principal de instalação de todos os demais instaladores deste diretório

sudo -v #autoriza o sudo no inicio da linha

read -p "⬇️ deseja fazer o download dos aplicativos? isso pode levar um tempo (y/n):" CONFIRM

if [[ "$CONFIRM" =~ ^[yY]$ ]]; then

    CURRENT_DIR=$(dirname $(realpath "$0"))

    # Instala os Apps Snap
    bash "$CURRENT_DIR/install-snaps.sh"

    # Instala os Apps Flatpak
    bash "$CURRENT_DIR/install-flatpaks.sh"
else
    echo "📌 download dos aplicativos pulado"
fi