#############################################################
# L4D2 Parachute Files Installer - Windows Version
#
# Baixa e instala arquivos de paraquedas do FastDL
# diretamente no cliente sem usar AddFileToDownloadsTable
#
# USO: Execute com PowerShell como Administrador
#############################################################

# Garantir que o script pode executar
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# URL base do FastDL
$FASTDL_URL = "https://dod-dawn-of-the-dead.github.io/l4d2-fastdl/l4d2_fastdl"

# Função para detectar diretório do L4D2
function Find-L4D2Directory {
    $steamPaths = @(
        "$env:ProgramFiles\Steam\steamapps\common\Left 4 Dead 2",
        "${env:ProgramFiles(x86)}\Steam\steamapps\common\Left 4 Dead 2",
        "C:\Program Files\Steam\steamapps\common\Left 4 Dead 2",
        "C:\Program Files (x86)\Steam\steamapps\common\Left 4 Dead 2",
        "D:\Steam\steamapps\common\Left 4 Dead 2",
        "E:\Steam\steamapps\common\Left 4 Dead 2"
    )

    foreach ($path in $steamPaths) {
        if (Test-Path "$path\left4dead2") {
            return "$path\left4dead2"
        }
    }

    return $null
}

# Função para mostrar barra de progresso
function Show-Progress {
    param(
        [int]$Current,
        [int]$Total,
        [string]$FileName
    )

    $percent = [math]::Round(($Current / $Total) * 100)
    $filled = [math]::Floor($percent / 2)
    $empty = 50 - $filled

    $bar = "█" * $filled + "░" * $empty

    Write-Host -NoNewline "`r["
    Write-Host -NoNewline -ForegroundColor Cyan $bar
    Write-Host -NoNewline "] "
    Write-Host -NoNewline -ForegroundColor Yellow "$percent% "
    Write-Host -NoNewline -ForegroundColor Blue "($Current/$Total) "
    Write-Host -NoNewline $FileName
}

# Banner
Clear-Host
Write-Host ""
Write-Host -ForegroundColor Cyan "╔════════════════════════════════════════════════════════════╗"
Write-Host -ForegroundColor Cyan "║" -NoNewline
Write-Host "  L4D2 Parachute Files Installer " -NoNewline
Write-Host -ForegroundColor Cyan "v1.0                  ║"
Write-Host -ForegroundColor Cyan "╚════════════════════════════════════════════════════════════╝"
Write-Host ""

# Detectar diretório do L4D2
Write-Host -ForegroundColor Blue "🔍 Detectando instalação do Left 4 Dead 2..."
$L4D2_DIR = Find-L4D2Directory

if (-not $L4D2_DIR) {
    Write-Host -ForegroundColor Red "❌ Left 4 Dead 2 não encontrado!"
    Write-Host -ForegroundColor Yellow "Por favor, instale o jogo via Steam primeiro."
    Read-Host "Pressione ENTER para sair"
    exit 1
}

Write-Host -ForegroundColor Green "✓ Encontrado: " -NoNewline
Write-Host $L4D2_DIR
Write-Host ""

# Criar diretórios necessários
Write-Host -ForegroundColor Blue "📁 Criando diretórios..."
New-Item -ItemType Directory -Force -Path "$L4D2_DIR\models\parachute\zombie\gargoyle_wings" | Out-Null
New-Item -ItemType Directory -Force -Path "$L4D2_DIR\materials\models\parachute\zombie\gargoyle_wings" | Out-Null
New-Item -ItemType Directory -Force -Path "$L4D2_DIR\sound\parachute" | Out-Null
Write-Host -ForegroundColor Green "✓ Diretórios criados"
Write-Host ""

# Lista de arquivos para baixar
$FILES = @(
    # Sons
    "sound/parachute/erriewind.wav",

    # Modelos - Gargoyle
    "models/parachute/gargoyle.mdl",
    "models/parachute/gargoyle.vvd",
    "models/parachute/gargoyle.dx80.vtx",
    "models/parachute/gargoyle.dx90.vtx",
    "models/parachute/gargoyle.sw.vtx",

    # Materiais - Gargoyle
    "materials/models/parachute/gargoyle.vmt",
    "materials/models/parachute/gargoyle.vtf",
    "materials/models/parachute/pack.vmt",
    "materials/models/parachute/pack.vtf",

    # Modelos - Blue Parachute
    "models/parachute/parachute_blue.mdl",
    "models/parachute/parachute_blue.vvd",
    "models/parachute/parachute_blue.dx80.vtx",
    "models/parachute/parachute_blue.dx90.vtx",
    "models/parachute/parachute_blue.sw.vtx",
    "models/parachute/parachute_blue.xbox.vtx",

    # Materiais - Blue
    "materials/models/parachute/parachute_blue.vmt",
    "materials/models/parachute/parachute_blue.vtf",

    # Modelos - Ice v2
    "models/parachute/parachute_ice_v2.mdl",
    "models/parachute/parachute_ice_v2.vvd",
    "models/parachute/parachute_ice_v2.dx80.vtx",
    "models/parachute/parachute_ice_v2.dx90.vtx",
    "models/parachute/parachute_ice_v2.sw.vtx",
    "models/parachute/parachute_ice_v2.xbox.vtx",

    # Materiais - Ice v2
    "materials/models/parachute/parachute_ice_v2.vmt",
    "materials/models/parachute/parachute_ice_v2.vtf",

    # Modelos - Carbon
    "models/parachute/parachute_carbon.mdl",
    "models/parachute/parachute_carbon.vvd",
    "models/parachute/parachute_carbon.dx80.vtx",
    "models/parachute/parachute_carbon.dx90.vtx",
    "models/parachute/parachute_carbon.sw.vtx",
    "models/parachute/parachute_carbon.xbox.vtx",

    # Materiais - Carbon
    "materials/models/parachute/parachute_carbon.vmt",
    "materials/models/parachute/parachute_carbon.vtf",
    "materials/models/parachute/pack_carbon.vmt",
    "materials/models/parachute/pack_carbon.vtf",

    # Modelos - Green v2
    "models/parachute/parachute_green_v2.mdl",
    "models/parachute/parachute_green_v2.vvd",
    "models/parachute/parachute_green_v2.dx80.vtx",
    "models/parachute/parachute_green_v2.dx90.vtx",
    "models/parachute/parachute_green_v2.sw.vtx",
    "models/parachute/parachute_green_v2.xbox.vtx",

    # Materiais - Green v2
    "materials/models/parachute/parachute_green_v2.vmt",
    "materials/models/parachute/parachute_green_v2.vtf",

    # Modelos - Gargoyle Wings (Zombie)
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.mdl",
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.vvd",
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.dx80.vtx",
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.dx90.vtx",
    "models/parachute/zombie/gargoyle_wings/gargoyle_wings.sw.vtx",

    # Materiais - Gargoyle Wings
    "materials/models/parachute/zombie/gargoyle_wings/gargoyle.vmt",
    "materials/models/parachute/zombie/gargoyle_wings/gargoyle.vtf",
    "materials/models/parachute/zombie/gargoyle_wings/pack.vmt",
    "materials/models/parachute/zombie/gargoyle_wings/pack.vtf",

    # Modelos - Phoenix
    "models/parachute/phoenix.mdl",
    "models/parachute/phoenix.vvd",
    "models/parachute/phoenix.dx90.vtx",
    "materials/models/parachute/phoenix.vmt",
    "materials/models/parachute/phoenix.vtf",

    # Modelos - Dragon
    "models/parachute/dragon.mdl",
    "models/parachute/dragon.vvd",
    "models/parachute/dragon.dx90.vtx",
    "materials/models/parachute/dragon.vmt",
    "materials/models/parachute/dragon.vtf"
)

$TOTAL_FILES = $FILES.Count
$CURRENT = 0
$FAILED = 0

Write-Host -ForegroundColor Blue "📥 Baixando arquivos de paraquedas..."
Write-Host ""

# Baixar cada arquivo
foreach ($file in $FILES) {
    $CURRENT++
    $filename = Split-Path -Leaf $file
    Show-Progress -Current $CURRENT -Total $TOTAL_FILES -FileName $filename

    # URL completa do arquivo
    $FILE_URL = "$FASTDL_URL/$file"

    # Caminho de destino
    $DEST_FILE = "$L4D2_DIR\$($file -replace '/', '\')"

    # Criar diretório se necessário
    $DEST_DIR = Split-Path -Parent $DEST_FILE
    New-Item -ItemType Directory -Force -Path $DEST_DIR | Out-Null

    # Baixar arquivo
    try {
        Invoke-WebRequest -Uri $FILE_URL -OutFile $DEST_FILE -ErrorAction Stop | Out-Null
    } catch {
        $FAILED++
    }
}

Write-Host ""
Write-Host ""

# Resultado
if ($FAILED -eq 0) {
    Write-Host -ForegroundColor Green "✅ Instalação concluída com sucesso!"
    Write-Host -ForegroundColor Green "   Arquivos instalados: $TOTAL_FILES"
} else {
    Write-Host -ForegroundColor Yellow "⚠️  Instalação concluída com avisos"
    Write-Host -ForegroundColor Green "   Arquivos instalados: $($TOTAL_FILES - $FAILED)"
    Write-Host -ForegroundColor Red "   Falhas: $FAILED"
}

Write-Host ""
Write-Host -ForegroundColor Cyan "╔════════════════════════════════════════════════════════════╗"
Write-Host -ForegroundColor Cyan "║" -NoNewline
Write-Host " Modelos de paraquedas disponíveis:                         " -NoNewline
Write-Host -ForegroundColor Cyan "║"
Write-Host -ForegroundColor Cyan "╠════════════════════════════════════════════════════════════╣"
Write-Host -ForegroundColor Cyan "║" -NoNewline
Write-Host "  " -NoNewline
Write-Host -ForegroundColor Green "✓" -NoNewline
Write-Host " Blue Parachute (Padrão)                               " -NoNewline
Write-Host -ForegroundColor Cyan "║"
Write-Host -ForegroundColor Cyan "║" -NoNewline
Write-Host "  " -NoNewline
Write-Host -ForegroundColor Green "✓" -NoNewline
Write-Host " Gargoyle                                              " -NoNewline
Write-Host -ForegroundColor Cyan "║"
Write-Host -ForegroundColor Cyan "║" -NoNewline
Write-Host "  " -NoNewline
Write-Host -ForegroundColor Green "✓" -NoNewline
Write-Host " Ice Parachute v2 (VIP)                                " -NoNewline
Write-Host -ForegroundColor Cyan "║"
Write-Host -ForegroundColor Cyan "║" -NoNewline
Write-Host "  " -NoNewline
Write-Host -ForegroundColor Green "✓" -NoNewline
Write-Host " Carbon Parachute                                      " -NoNewline
Write-Host -ForegroundColor Cyan "║"
Write-Host -ForegroundColor Cyan "║" -NoNewline
Write-Host "  " -NoNewline
Write-Host -ForegroundColor Green "✓" -NoNewline
Write-Host " Green Parachute v2                                    " -NoNewline
Write-Host -ForegroundColor Cyan "║"
Write-Host -ForegroundColor Cyan "║" -NoNewline
Write-Host "  " -NoNewline
Write-Host -ForegroundColor Green "✓" -NoNewline
Write-Host " Gargoyle Wings (Zombie style)                         " -NoNewline
Write-Host -ForegroundColor Cyan "║"
Write-Host -ForegroundColor Cyan "║" -NoNewline
Write-Host "  " -NoNewline
Write-Host -ForegroundColor Green "✓" -NoNewline
Write-Host " Phoenix Wings                                         " -NoNewline
Write-Host -ForegroundColor Cyan "║"
Write-Host -ForegroundColor Cyan "║" -NoNewline
Write-Host "  " -NoNewline
Write-Host -ForegroundColor Green "✓" -NoNewline
Write-Host " Dragon Wings                                          " -NoNewline
Write-Host -ForegroundColor Cyan "║"
Write-Host -ForegroundColor Cyan "╚════════════════════════════════════════════════════════════╝"
Write-Host ""
Write-Host -ForegroundColor Yellow "📝 Instruções:"
Write-Host "   1. Reinicie o Left 4 Dead 2 (se estiver aberto)"
Write-Host "   2. Conecte ao servidor"
Write-Host "   3. Digite " -NoNewline
Write-Host -ForegroundColor Cyan "/sm_parachute" -NoNewline
Write-Host " para escolher o modelo"
Write-Host "   4. Pressione " -NoNewline
Write-Host -ForegroundColor Cyan "E" -NoNewline
Write-Host " no ar para abrir o paraquedas"
Write-Host ""
Write-Host -ForegroundColor Green "Pronto para jogar! 🚀"
Write-Host ""

Read-Host "Pressione ENTER para sair"
