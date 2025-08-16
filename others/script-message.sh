#!/bin/bash

# =====================[ CONFIGURAÇÃO GLOBAL ]=====================
MARGEM_ESQUERDA=2     # espaços antes do texto começar
LARGURA_TEXTO=70      # largura máxima que o texto pode ocupar

RESET=$(tput sgr0)
COLOR_TEXT=$(tput setaf 7)   # Cinza claro
COLOR_TEXT_HIGHLIGHTS=$(tput setaf 10) # Verde Claro
COLOR_TITLE=$(tput setaf 6)  # Ciano
BOLD=$(tput bold)

COLOR_TH=$COLOR_TEXT_HIGHLIGHTS # abreviação

# =====================[ FUNÇÕES REUTILIZÁVEIS ]====================

# Centraliza o texto dentro de uma largura fixa, com margem à esquerda
centralizar_texto() {
    local texto="$1"

    # Quebra texto no limite de largura
    local linhas=$(echo "$texto" | fold -s -w "$LARGURA_TEXTO")

    while IFS= read -r linha; do
        # Centraliza a linha dentro da largura definida
        local espacos=$(( (LARGURA_TEXTO - ${#linha}) / 2 ))
        printf "%*s%*s%s%s%s\n" \
            $MARGEM_ESQUERDA "" \
            $espacos "" \
            "$COLOR_TEXT" "$linha" "$RESET"
    done <<< "$linhas"
}

# Centraliza o texto com highlight dentro de uma largura fixa, com margem à esquerda
centralizar_texto_highlights() {
    local texto="$1"

    # Quebra texto no limite de largura
    local linhas=$(echo "$texto" | fold -s -w "$LARGURA_TEXTO")

    while IFS= read -r linha; do
        # Centraliza a linha dentro da largura definida
        local espacos=$(( (LARGURA_TEXTO - ${#linha}) / 2 ))
        printf "%*s%*s%s%s%s\n" \
            $MARGEM_ESQUERDA "" \
            $espacos "" \
            "$COLOR_TEXT_HIGHLIGHTS" "$linha" "$RESET"
    done <<< "$linhas"
}

centralizar_texto_highlights-2() {
    local texto="$1"

    # Quebra texto no limite de largura
    local linhas=$(echo "$texto" | fold -s -w "$LARGURA_TEXTO")

    while IFS= read -r linha; do
        # Centraliza a linha dentro da largura definida
        local espacos=$(( (LARGURA_TEXTO - ${#linha}) / 2 ))
        printf "%*s%*s%s%s%s\n" \
            $MARGEM_ESQUERDA "" \
            $espacos "" \
            "$COLOR_TITLE" "$linha" "$RESET"
    done <<< "$linhas"
}

# Centraliza título dentro da largura fixa, com margem à esquerda
centralizar_titulo() {
    local texto="$1"
    local espacos=$(( (LARGURA_TEXTO - ${#texto}) / 2 ))
    printf "%*s%*s%s%s%s\n" \
        $MARGEM_ESQUERDA "" \
        $espacos "" \
        "$COLOR_TITLE" "$texto" "$RESET"
}