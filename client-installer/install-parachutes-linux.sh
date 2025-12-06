#!/bin/bash

#############################################################
# L4D2 Parachute Files Installer - Linux Version
#
# Multi-language installer for L4D2 parachute files
# Supported: English, Português, Español
#############################################################

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# URL base do FastDL
FASTDL_URL="https://dod-dawn-of-the-dead.github.io/l4d2-fastdl/l4d2_fastdl"

# ===== SISTEMA DE TRADUÇÃO =====

# Detectar idioma do sistema
detect_language() {
    local lang="${LANG:0:2}"
    case "$lang" in
        pt) echo "pt" ;;
        es) echo "es" ;;
        en) echo "en" ;;
        *) echo "en" ;;  # Fallback para inglês
    esac
}

# Função de tradução
t() {
    local key="$1"
    case "$LANGUAGE" in
        pt)
            case "$key" in
                "title") echo "Instalador de Arquivos de Paraquedas - L4D2" ;;
                "version") echo "v1.0" ;;
                "detecting") echo "🔍 Detectando instalação do Left 4 Dead 2..." ;;
                "found") echo "✓ Encontrado:" ;;
                "not_found") echo "❌ Left 4 Dead 2 não encontrado!" ;;
                "install_steam") echo "Por favor, instale o jogo via Steam primeiro." ;;
                "creating_dirs") echo "📁 Criando diretórios..." ;;
                "dirs_created") echo "✓ Diretórios criados" ;;
                "downloading") echo "📥 Baixando" ;;
                "files") echo "arquivos..." ;;
                "success_install") echo "✅ Instalação concluída com sucesso!" ;;
                "warning_install") echo "⚠️  Instalação concluída com avisos" ;;
                "installed") echo "Arquivos instalados:" ;;
                "success_count") echo "Sucesso:" ;;
                "failed_count") echo "Falhas:" ;;
                "models_available") echo "Modelos de paraquedas disponíveis:" ;;
                "model_blue") echo "Blue Parachute (Padrão)" ;;
                "model_gargoyle") echo "Gargoyle" ;;
                "model_ice") echo "Ice Parachute v2 (VIP)" ;;
                "model_carbon") echo "Carbon Parachute" ;;
                "model_green") echo "Green Parachute v2" ;;
                "model_wings") echo "Gargoyle Wings (Zombie style)" ;;
                "model_phoenix") echo "Phoenix Wings" ;;
                "model_dragon") echo "Dragon Wings" ;;
                "instructions") echo "📝 Instruções:" ;;
                "step1") echo "1. ${BOLD}Reinicie o Left 4 Dead 2${NC} (se estiver aberto)" ;;
                "step2") echo "2. Conecte ao servidor" ;;
                "step3") echo "3. Digite ${CYAN}/sm_parachute${NC} para escolher o modelo" ;;
                "step4") echo "4. Pressione ${CYAN}E${NC} no ar para abrir o paraquedas" ;;
                "ready") echo "Pronto para jogar! 🚀" ;;
                "select_lang") echo "Selecione o idioma / Select language / Seleccione el idioma:" ;;
                "lang_portuguese") echo "Português" ;;
                "lang_english") echo "English" ;;
                "lang_spanish") echo "Español" ;;
            esac
            ;;
        es)
            case "$key" in
                "title") echo "Instalador de Archivos de Paracaídas - L4D2" ;;
                "version") echo "v1.0" ;;
                "detecting") echo "🔍 Detectando instalación de Left 4 Dead 2..." ;;
                "found") echo "✓ Encontrado:" ;;
                "not_found") echo "❌ ¡Left 4 Dead 2 no encontrado!" ;;
                "install_steam") echo "Por favor, instale el juego vía Steam primero." ;;
                "creating_dirs") echo "📁 Creando directorios..." ;;
                "dirs_created") echo "✓ Directorios creados" ;;
                "downloading") echo "📥 Descargando" ;;
                "files") echo "archivos..." ;;
                "success_install") echo "✅ ¡Instalación completada con éxito!" ;;
                "warning_install") echo "⚠️  Instalación completada con advertencias" ;;
                "installed") echo "Archivos instalados:" ;;
                "success_count") echo "Éxito:" ;;
                "failed_count") echo "Fallos:" ;;
                "models_available") echo "Modelos de paracaídas disponibles:" ;;
                "model_blue") echo "Paracaídas Azul (Predeterminado)" ;;
                "model_gargoyle") echo "Gárgola" ;;
                "model_ice") echo "Paracaídas Hielo v2 (VIP)" ;;
                "model_carbon") echo "Paracaídas Carbono" ;;
                "model_green") echo "Paracaídas Verde v2" ;;
                "model_wings") echo "Alas de Gárgola (estilo Zombie)" ;;
                "model_phoenix") echo "Alas de Fénix" ;;
                "model_dragon") echo "Alas de Dragón" ;;
                "instructions") echo "📝 Instrucciones:" ;;
                "step1") echo "1. ${BOLD}Reinicie Left 4 Dead 2${NC} (si está abierto)" ;;
                "step2") echo "2. Conéctese al servidor" ;;
                "step3") echo "3. Escriba ${CYAN}/sm_parachute${NC} para elegir el modelo" ;;
                "step4") echo "4. Presione ${CYAN}E${NC} en el aire para abrir el paracaídas" ;;
                "ready") echo "¡Listo para jugar! 🚀" ;;
                "select_lang") echo "Selecione o idioma / Select language / Seleccione el idioma:" ;;
                "lang_portuguese") echo "Português" ;;
                "lang_english") echo "English" ;;
                "lang_spanish") echo "Español" ;;
            esac
            ;;
        en)
            case "$key" in
                "title") echo "L4D2 Parachute Files Installer" ;;
                "version") echo "v1.0" ;;
                "detecting") echo "🔍 Detecting Left 4 Dead 2 installation..." ;;
                "found") echo "✓ Found:" ;;
                "not_found") echo "❌ Left 4 Dead 2 not found!" ;;
                "install_steam") echo "Please install the game via Steam first." ;;
                "creating_dirs") echo "📁 Creating directories..." ;;
                "dirs_created") echo "✓ Directories created" ;;
                "downloading") echo "📥 Downloading" ;;
                "files") echo "files..." ;;
                "success_install") echo "✅ Installation completed successfully!" ;;
                "warning_install") echo "⚠️  Installation completed with warnings" ;;
                "installed") echo "Files installed:" ;;
                "success_count") echo "Success:" ;;
                "failed_count") echo "Failed:" ;;
                "models_available") echo "Available parachute models:" ;;
                "model_blue") echo "Blue Parachute (Default)" ;;
                "model_gargoyle") echo "Gargoyle" ;;
                "model_ice") echo "Ice Parachute v2 (VIP)" ;;
                "model_carbon") echo "Carbon Parachute" ;;
                "model_green") echo "Green Parachute v2" ;;
                "model_wings") echo "Gargoyle Wings (Zombie style)" ;;
                "model_phoenix") echo "Phoenix Wings" ;;
                "model_dragon") echo "Dragon Wings" ;;
                "instructions") echo "📝 Instructions:" ;;
                "step1") echo "1. ${BOLD}Restart Left 4 Dead 2${NC} (if open)" ;;
                "step2") echo "2. Connect to the server" ;;
                "step3") echo "3. Type ${CYAN}/sm_parachute${NC} to choose model" ;;
                "step4") echo "4. Press ${CYAN}E${NC} while in the air to open parachute" ;;
                "ready") echo "Ready to play! 🚀" ;;
                "select_lang") echo "Selecione o idioma / Select language / Seleccione el idioma:" ;;
                "lang_portuguese") echo "Português" ;;
                "lang_english") echo "English" ;;
                "lang_spanish") echo "Español" ;;
            esac
            ;;
    esac
}

# Menu de seleção de idioma
select_language() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}  ${BOLD}L4D2 Parachute Installer${NC} - ${CYAN}Language Selection${NC}        ${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "$(t "select_lang")"
    echo ""
    echo -e "  ${CYAN}1)${NC} 🇧🇷 $(t "lang_portuguese")"
    echo -e "  ${CYAN}2)${NC} 🇺🇸 $(t "lang_english")"
    echo -e "  ${CYAN}3)${NC} 🇪🇸 $(t "lang_spanish")"
    echo ""
    echo -n -e "${YELLOW}→ ${NC}"
    read -r choice

    case "$choice" in
        1) LANGUAGE="pt" ;;
        2) LANGUAGE="en" ;;
        3) LANGUAGE="es" ;;
        *) LANGUAGE=$(detect_language) ;;
    esac
}

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

# ===== INÍCIO DO INSTALADOR =====

# Selecionar idioma
LANGUAGE=$(detect_language)
select_language

# Banner
clear
echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}$(t "title")${NC} $(t "version")                  ${CYAN}║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Detectar diretório do L4D2
echo -e "${BLUE}$(t "detecting")${NC}"
L4D2_DIR=$(detect_l4d2_dir)

if [ -z "$L4D2_DIR" ]; then
    echo -e "${RED}$(t "not_found")${NC}"
    echo -e "${YELLOW}$(t "install_steam")${NC}"
    exit 1
fi

echo -e "${GREEN}$(t "found")${NC} $L4D2_DIR"
echo ""

# Criar diretórios necessários
echo -e "${BLUE}$(t "creating_dirs")${NC}"
mkdir -p "$L4D2_DIR/models/parachute/zombie/gargoyle_wings"
mkdir -p "$L4D2_DIR/materials/models/parachute/zombie/gargoyle_wings"
mkdir -p "$L4D2_DIR/sound/parachute"
echo -e "${GREEN}$(t "dirs_created")${NC}"
echo ""

# Lista de arquivos para baixar
declare -a FILES=(
    "sound/parachute/erriewind.wav"
    "models/parachute/gargoyle.mdl"
    "models/parachute/gargoyle.vvd"
    "models/parachute/gargoyle.dx80.vtx"
    "models/parachute/gargoyle.dx90.vtx"
    "models/parachute/gargoyle.sw.vtx"
    "materials/models/parachute/gargoyle.vmt"
    "materials/models/parachute/gargoyle.vtf"
    "materials/models/parachute/pack.vmt"
    "materials/models/parachute/pack.vtf"
    "models/parachute/parachute_blue.mdl"
    "models/parachute/parachute_blue.vvd"
    "models/parachute/parachute_blue.dx80.vtx"
    "models/parachute/parachute_blue.dx90.vtx"
    "models/parachute/parachute_blue.sw.vtx"
    "models/parachute/parachute_blue.xbox.vtx"
    "materials/models/parachute/parachute_blue.vmt"
    "materials/models/parachute/parachute_blue.vtf"
    "models/parachute/parachute_ice_v2.mdl"
    "models/parachute/parachute_ice_v2.vvd"
    "models/parachute/parachute_ice_v2.dx80.vtx"
    "models/parachute/parachute_ice_v2.dx90.vtx"
    "models/parachute/parachute_ice_v2.sw.vtx"
    "models/parachute/parachute_ice_v2.xbox.vtx"
    "materials/models/parachute/parachute_ice_v2.vmt"
    "materials/models/parachute/parachute_ice_v2.vtf"
    "models/parachute/parachute_carbon.mdl"
    "models/parachute/parachute_carbon.vvd"
    "models/parachute/parachute_carbon.dx80.vtx"
    "models/parachute/parachute_carbon.dx90.vtx"
    "models/parachute/parachute_carbon.sw.vtx"
    "models/parachute/parachute_carbon.xbox.vtx"
    "materials/models/parachute/parachute_carbon.vmt"
    "materials/models/parachute/parachute_carbon.vtf"
    "materials/models/parachute/pack_carbon.vmt"
    "materials/models/parachute/pack_carbon.vtf"
    "models/parachute/parachute_green_v2.mdl"
    "models/parachute/parachute_green_v2.vvd"
    "models/parachute/parachute_green_v2.dx80.vtx"
    "models/parachute/parachute_green_v2.dx90.vtx"
    "models/parachute/parachute_green_v2.sw.vtx"
    "models/parachute/parachute_green_v2.xbox.vtx"
    "materials/models/parachute/parachute_green_v2.vmt"
    "materials/models/parachute/parachute_green_v2.vtf"
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.mdl"
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.vvd"
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.dx80.vtx"
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.dx90.vtx"
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.sw.vtx"
    "materials/models/parachute/zombie/gargoyle_wings/gargoyle.vmt"
    "materials/models/parachute/zombie/gargoyle_wings/gargoyle.vtf"
    "materials/models/parachute/zombie/gargoyle_wings/pack.vmt"
    "materials/models/parachute/zombie/gargoyle_wings/pack.vtf"
    "models/parachute/phoenix.mdl"
    "models/parachute/phoenix.vvd"
    "models/parachute/phoenix.dx90.vtx"
    "materials/models/parachute/phoenix.vmt"
    "materials/models/parachute/phoenix.vtf"
    "models/parachute/dragon.mdl"
    "models/parachute/dragon.vvd"
    "models/parachute/dragon.dx90.vtx"
    "materials/models/parachute/dragon.vmt"
    "materials/models/parachute/dragon.vtf"
)

TOTAL_FILES=${#FILES[@]}
CURRENT=0
FAILED=0
SUCCESS=0

echo -e "${BLUE}$(t "downloading") $TOTAL_FILES $(t "files")${NC}"
echo ""

# Baixar cada arquivo
for file in "${FILES[@]}"; do
    ((CURRENT++))
    filename=$(basename "$file")

    printf "${CYAN}[%3d/%3d]${NC} ${YELLOW}%-40s${NC} " "$CURRENT" "$TOTAL_FILES" "$filename"

    FILE_URL="$FASTDL_URL/$file"
    DEST_FILE="$L4D2_DIR/$file"
    DEST_DIR=$(dirname "$DEST_FILE")
    mkdir -p "$DEST_DIR"

    if curl -sf --max-time 30 "$FILE_URL" -o "$DEST_FILE" 2>/dev/null; then
        echo -e "${GREEN}✓${NC}"
        ((SUCCESS++))
    else
        echo -e "${RED}✗${NC}"
        ((FAILED++))
    fi
done

echo ""

# Resultado
if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}$(t "success_install")${NC}"
    echo -e "${GREEN}   $(t "installed") $TOTAL_FILES${NC}"
else
    echo -e "${YELLOW}$(t "warning_install")${NC}"
    echo -e "${GREEN}   $(t "success_count") $SUCCESS${NC}"
    echo -e "${RED}   $(t "failed_count") $FAILED${NC}"
fi

echo ""
echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC} ${BOLD}$(t "models_available")${NC}                         ${CYAN}║${NC}"
echo -e "${CYAN}╠════════════════════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} $(t "model_blue")                               ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} $(t "model_gargoyle")                                              ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} $(t "model_ice")                                ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} $(t "model_carbon")                                      ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} $(t "model_green")                                    ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} $(t "model_wings")                         ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} $(t "model_phoenix")                                         ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  ${GREEN}✓${NC} $(t "model_dragon")                                          ${CYAN}║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}$(t "instructions")${NC}"
echo -e "   $(t "step1")"
echo -e "   $(t "step2")"
echo -e "   $(t "step3")"
echo -e "   $(t "step4")"
echo ""
echo -e "${GREEN}$(t "ready")${NC}"
echo ""
