# Script principal de instalação de todos os demais instaladores deste diretório
sudo echo "" #autoriza o sudo no inicio da linha

DIR="$HOME/.dotfiles/apps"

# Corrige possível erro das pastas do flatpak
bash "$DIR/fix-flatpak-path.sh"

# Instala os Apps Snap
bash "$DIR/install-snaps.sh"

# Instala os Apps Flatpak
bash "$DIR/install-flatpaks.sh"