#!/bin/bash

#############################################################
# L4D2 Parachute Files Installer - Linux Version
#
# Baixa e instala arquivos de paraquedas do FastDL
# diretamente no cliente sem usar AddFileToDownloadsTable
#############################################################

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# URL base do FastDL
FASTDL_URL="https://dod-dawn-of-the-dead.github.io/l4d2-fastdl/l4d2_fastdl"

# Detectar diretório do L4D2
detect_l4d2_dir() {
    local steam_paths=(
        "$HOME/.local/share/Steam/steamapps/common/Left 4 Dead 2"
        "$HOME/.steam/steam/steamapps/common/Left 4 Dead 2"
        "$HOME/Steam/steamapps/common/Left 4 Dead 2"
    )

    for path in "${steam_paths[@]}"; do
        if [ -d "$path/left4dead2" ]; then
            echo "$path/left4dead2"
            return 0
        fi
    done

    return 1
}

# Função para mostrar barra de progresso
show_progress() {
    local current=$1
    local total=$2
    local filename=$3
    local percent=$((current * 100 / total))
    local filled=$((percent / 2))
    local empty=$((50 - filled))

    printf "\r${CYAN}[${NC}"
    printf "%${filled}s" | tr ' ' '█'
    printf "%${empty}s" | tr ' ' '░'
    printf "${CYAN}]${NC} ${YELLOW}%3d%%${NC} ${BLUE}(%d/%d)${NC} %s" "$percent" "$current" "$total" "$filename"
}

# Banner
clear
echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}L4D2 Parachute Files Installer${NC} ${CYAN}v1.0${NC}                  ${CYAN}║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Detectar diretório do L4D2
echo -e "${BLUE}🔍 Detectando instalação do Left 4 Dead 2...${NC}"
L4D2_DIR=$(detect_l4d2_dir)

if [ -z "$L4D2_DIR" ]; then
    echo -e "${RED}❌ Left 4 Dead 2 não encontrado!${NC}"
    echo -e "${YELLOW}Por favor, instale o jogo via Steam primeiro.${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Encontrado:${NC} $L4D2_DIR"
echo ""

# Criar diretórios necessários
echo -e "${BLUE}📁 Criando diretórios...${NC}"
mkdir -p "$L4D2_DIR/models/parachute/zombie/gargoyle_wings"
mkdir -p "$L4D2_DIR/materials/models/parachute/zombie/gargoyle_wings"
mkdir -p "$L4D2_DIR/sound/parachute"
echo -e "${GREEN}✓ Diretórios criados${NC}"
echo ""

# Lista de arquivos para baixar (SEM .bz2 - versões descomprimidas)
declare -a FILES=(
    # Sons
    "sound/parachute/erriewind.wav"

    # Modelos - Gargoyle
    "models/parachute/gargoyle.mdl"
    "models/parachute/gargoyle.vvd"
    "models/parachute/gargoyle.dx80.vtx"
    "models/parachute/gargoyle.dx90.vtx"
    "models/parachute/gargoyle.sw.vtx"

    # Materiais - Gargoyle
    "materials/models/parachute/gargoyle.vmt"
    "materials/models/parachute/gargoyle.vtf"
    "materials/models/parachute/pack.vmt"
    "materials/models/parachute/pack.vtf"

    # Modelos - Blue Parachute
    "models/parachute/parachute_blue.mdl"
    "models/parachute/parachute_blue.vvd"
    "models/parachute/parachute_blue.dx80.vtx"
    "models/parachute/parachute_blue.dx90.vtx"
    "models/parachute/parachute_blue.sw.vtx"
    "models/parachute/parachute_blue.xbox.vtx"

    # Materiais - Blue
    "materials/models/parachute/parachute_blue.vmt"
    "materials/models/parachute/parachute_blue.vtf"

    # Modelos - Ice v2
    "models/parachute/parachute_ice_v2.mdl"
    "models/parachute/parachute_ice_v2.vvd"
    "models/parachute/parachute_ice_v2.dx80.vtx"
    "models/parachute/parachute_ice_v2.dx90.vtx"
    "models/parachute/parachute_ice_v2.sw.vtx"
    "models/parachute/parachute_ice_v2.xbox.vtx"

    # Materiais - Ice v2
    "materials/models/parachute/parachute_ice_v2.vmt"
    "materials/models/parachute/parachute_ice_v2.vtf"

    # Modelos - Carbon
    "models/parachute/parachute_carbon.mdl"
    "models/parachute/parachute_carbon.vvd"
    "models/parachute/parachute_carbon.dx80.vtx"
    "models/parachute/parachute_carbon.dx90.vtx"
    "models/parachute/parachute_carbon.sw.vtx"
    "models/parachute/parachute_carbon.xbox.vtx"

    # Materiais - Carbon
    "materials/models/parachute/parachute_carbon.vmt"
    "materials/models/parachute/parachute_carbon.vtf"
    "materials/models/parachute/pack_carbon.vmt"
    "materials/models/parachute/pack_carbon.vtf"

    # Modelos - Green v2
    "models/parachute/parachute_green_v2.mdl"
    "models/parachute/parachute_green_v2.vvd"
    "models/parachute/parachute_green_v2.dx80.vtx"
    "models/parachute/parachute_green_v2.dx90.vtx"
    "models/parachute/parachute_green_v2.sw.vtx"
    "models/parachute/parachute_green_v2.xbox.vtx"

    # Materiais - Green v2
    "materials/models/parachute/parachute_green_v2.vmt"
    "materials/models/parachute/parachute_green_v2.vtf"

    # Modelos - Gargoyle Wings (Zombie)
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.mdl"
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.vvd"
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.dx80.vtx"
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.dx90.vtx"
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.sw.vtx"

    # Materiais - Gargoyle Wings
    "materials/models/parachute/zombie/gargoyle_wings/gargoyle.vmt"
    "materials/models/parachute/zombie/gargoyle_wings/gargoyle.vtf"
    "materials/models/parachute/zombie/gargoyle_wings/pack.vmt"
    "materials/models/parachute/zombie/gargoyle_wings/pack.vtf"
)

TOTAL_FILES=${#FILES[@]}
CURRENT=0
FAILED=0

echo -e "${BLUE}📥 Baixando arquivos de paraquedas...${NC}"
echo ""

# Baixar cada arquivo
for file in "${FILES[@]}"; do
    ((CURRENT++))
    filename=$(basename "$file")
    show_progress $CURRENT $TOTAL_FILES "$filename"

    # URL completa do arquivo
    FILE_URL="$FASTDL_URL/$file"

    # Caminho de destino
    DEST_FILE="$L4D2_DIR/$file"

    # Criar diretório se necessário
    DEST_DIR=$(dirname "$DEST_FILE")
    mkdir -p "$DEST_DIR"

    # Baixar arquivo
    if curl -sf "$FILE_URL" -o "$DEST_FILE" 2>/dev/null; then
        :  # Sucesso
    else
        ((FAILED++))
    fi
done

echo ""
echo ""

# Resultado
if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✅ Instalação concluída com sucesso!${NC}"
    echo -e "${GREEN}   Arquivos instalados: $TOTAL_FILES${NC}"
else
    echo -e "${YELLOW}⚠️  Instalação concluída com avisos${NC}"
    echo -e "${GREEN}   Arquivos instalados: $((TOTAL_FILES - FAILED))${NC}"
    echo -e "${RED}   Falhas: $FAILED${NC}"
fi

echo ""
echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC} ${BOLD}Modelos de paraquedas disponíveis:${NC}                         ${CYAN}║${NC}"
echo -e "${CYAN}╠════════════════════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} Blue Parachute (Padrão)                               ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} Gargoyle                                              ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} Ice Parachute v2 (VIP)                                ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} Carbon Parachute                                      ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} Green Parachute v2                                    ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} Gargoyle Wings (Zombie style)                         ${CYAN}║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}📝 Instruções:${NC}"
echo -e "   1. ${BOLD}Reinicie o Left 4 Dead 2${NC} (se estiver aberto)"
echo -e "   2. Conecte ao servidor"
echo -e "   3. Digite ${CYAN}/sm_parachute${NC} para escolher o modelo"
echo -e "   4. Pressione ${CYAN}E${NC} no ar para abrir o paraquedas"
echo ""
echo -e "${GREEN}Pronto para jogar! 🚀${NC}"
echo ""
