#!/bin/bash

echo "🔄 Usando D-Bus para recarregar extensões de forma segura..."

busctl call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.reloadExtensions()'

echo "✅ Extensões recarregadas via D-Bus!"