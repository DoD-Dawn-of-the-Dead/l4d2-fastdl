# 🪂 L4D2 Parachute Files Installer

Scripts para instalar arquivos de paraquedas automaticamente no cliente L4D2 sem usar `AddFileToDownloadsTable` (que causa crashes).

## 📋 O que faz

- ✅ Detecta automaticamente o diretório do L4D2
- ✅ Baixa todos os arquivos do FastDL (modelos, materiais, sons)
- ✅ Instala nos diretórios corretos
- ✅ Mostra barra de progresso bonita
- ✅ Não causa crashes no jogo
- ✅ **Baixa 8 modelos de paraquedas:**
  - Blue Parachute (Padrão)
  - Gargoyle
  - Ice Parachute v2 (VIP)
  - Carbon Parachute
  - Green Parachute v2
  - Gargoyle Wings (Zombie style)
  - Phoenix Wings
  - Dragon Wings

## 🐧 Linux

### Como usar:

```bash
cd client-installer
./install-parachutes-linux.sh
```

### Requisitos:
- `curl` instalado
- Left 4 Dead 2 instalado via Steam

## 🪟 Windows

### Como usar:

1. **Clique com botão direito** em `install-parachutes-windows.ps1`
2. Selecione **"Executar com PowerShell"**

**OU via PowerShell:**

```powershell
cd client-installer
.\install-parachutes-windows.ps1
```

## 📦 Arquivos instalados

**Total: 53 arquivos (~2.5 MB)**

- 34 modelos (.mdl, .vvd, .vtx)
- 18 materiais (.vmt, .vtf)
- 1 som (.wav)

## 🎮 Como usar no jogo

1. Execute o script de instalação
2. **Reinicie o L4D2** (se estiver aberto)
3. Conecte ao servidor
4. Digite `/sm_parachute` no chat
5. Escolha seu modelo favorito
6. Pressione **E** no ar para abrir o paraquedas

---

**Versão:** 1.0 | **Data:** 2025-12-04
