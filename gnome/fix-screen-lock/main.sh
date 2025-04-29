#!/bin/bash

DIR=$(pwd)

# carrega o ajuste da tela de bloqueio
bash "$DIR/fix-gnome-screen-lock.sh"

# carrega o ajuste das extensões pós tela de bloqueio
bash "$DIR/fix-extensions.sh"