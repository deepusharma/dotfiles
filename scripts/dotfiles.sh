#!/usr/bin/env bash
# scripts/dotfiles.sh — one entry point for managing this dotfiles setup.
#
# Usage:
#   ./scripts/dotfiles.sh            # help (default)
#   ./scripts/dotfiles.sh install    # full bootstrap — runs scripts/install.sh
#   ./scripts/dotfiles.sh sync       # git pull + brew update, then re-apply (idempotent)
#   ./scripts/dotfiles.sh audit      # report drift — changes nothing

set -u

GREEN='\033[0;32m'; BLUE='\033[0;34m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
log()  { echo -e "${BLUE}-->${NC} $1"; }
ok()   { echo -e "${GREEN}ok${NC}  $1"; }
info() { echo -e "    $1"; }
warn() { echo -e "${YELLOW}!${NC}   $1"; ISSUES=$((ISSUES + 1)); }
bad()  { echo -e "${RED}x${NC}   $1"; ISSUES=$((ISSUES + 1)); }

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ISSUES=0

OS="unknown"
[[ "$OSTYPE" == "darwin"* ]]    && OS="mac"
[[ "$OSTYPE" == "linux-gnu"* ]] && OS="linux"

# ── manifest helpers ──────────────────────────────────────────────────────────
# Manifest format: plain line = required, '?' prefix = optional, '#' = comment.
manifest_required() { grep -v '^[#?]' "$1" | grep -v '^$' | tr '[:upper:]' '[:lower:]' | sort -u; }
manifest_known()    { grep -v '^#'    "$1" | grep -v '^$' | sed 's/^?//' | tr '[:upper:]' '[:lower:]' | sort -u; }

# Expected symlinks as "dest|src" lines — keep in sync with scripts/install.sh
expected_links() {
  cat <<EOF
$HOME/.zshrc|$DOTFILES/configs/zsh/.zshrc
$HOME/.config/starship.toml|$DOTFILES/configs/starship/starship.toml
$HOME/.config/zellij/config.kdl|$DOTFILES/configs/zellij/config.kdl
$HOME/.config/zellij/layouts/dev.kdl|$DOTFILES/configs/zellij/layouts/dev.kdl
$HOME/.gitconfig|$DOTFILES/configs/git/.gitconfig
$HOME/.antigravity/skills|$DOTFILES/configs/antigravity/skills
EOF
  if [[ "$OS" == "mac" ]]; then
    cat <<EOF
$HOME/.config/ghostty/config|$DOTFILES/configs/ghostty/config
$HOME/Library/Application Support/Code/User/settings.json|$DOTFILES/configs/vscode/settings.json
$HOME/Library/Application Support/Antigravity IDE/User/settings.json|$DOTFILES/configs/antigravity/settings.json
$HOME/Library/Application Support/Cursor/User/settings.json|$DOTFILES/configs/cursor/settings.json
$HOME/Library/Application Support/Kiro/User/settings.json|$DOTFILES/configs/kiro/settings.json
$HOME/Library/Application Support/Windsurf/User/settings.json|$DOTFILES/configs/windsurf/settings.json
$HOME/Library/Application Support/Devin/User/settings.json|$DOTFILES/configs/windsurf/settings.json
EOF
  elif [[ "$OS" == "linux" ]]; then
    local win_user win_appdata
    win_user=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
    win_appdata="/mnt/c/Users/$win_user/AppData/Roaming"
    cat <<EOF
$win_appdata/Code/User/settings.json|$DOTFILES/configs/vscode/settings.json
$win_appdata/Antigravity IDE/User/settings.json|$DOTFILES/configs/antigravity/settings.json
$win_appdata/Cursor/User/settings.json|$DOTFILES/configs/cursor/settings.json
$win_appdata/Kiro/User/settings.json|$DOTFILES/configs/kiro/settings.json
$win_appdata/Windsurf/User/settings.json|$DOTFILES/configs/windsurf/settings.json
$win_appdata/Devin/User/settings.json|$DOTFILES/configs/windsurf/settings.json
EOF
  fi
}

# ── audit sections ────────────────────────────────────────────────────────────
audit_symlinks() {
  log "Symlinks"
  local dest src actual
  while IFS='|' read -r dest src; do
    [[ -z "$dest" ]] && continue
    if [[ ! -e "$dest" && ! -L "$dest" ]]; then
      bad "missing: $dest"
    elif [[ ! -L "$dest" ]]; then
      warn "exists but is NOT a symlink: $dest"
    else
      actual="$(readlink "$dest")"
      if [[ "$actual" == "$src" ]]; then
        ok "$dest"
      else
        warn "$dest points to $actual (expected $src)"
      fi
    fi
  done < <(expected_links)
}

audit_brew() {
  log "Homebrew packages (Brewfile)"
  if ! command -v brew &>/dev/null; then
    bad "brew not installed"
    return
  fi
  if brew bundle check --file="$DOTFILES/Brewfile" &>/dev/null; then
    ok "Brewfile satisfied"
  else
    warn "Brewfile drift — run: brew bundle --file=$DOTFILES/Brewfile"
    brew bundle check --verbose --file="$DOTFILES/Brewfile" 2>/dev/null | grep '→' | sed 's/^/      /' || true
  fi
  local outdated
  outdated="$(brew outdated --quiet 2>/dev/null | wc -l | tr -d ' ')"
  if [[ "$outdated" -eq 0 ]]; then
    ok "no outdated packages"
  else
    warn "$outdated outdated package(s) — run: brew upgrade  (list: brew outdated)"
  fi
}

audit_clis() {
  log "CLI tools (configs/cli-tools.txt)"
  local manifest="$DOTFILES/configs/cli-tools.txt" line name optional
  if [[ ! -f "$manifest" ]]; then
    warn "manifest not found: $manifest"
    return
  fi
  while read -r line; do
    [[ -z "$line" || "$line" == \#* ]] && continue
    optional=0; name="$line"
    [[ "$line" == \?* ]] && { optional=1; name="${line#\?}"; }
    if command -v "$name" >/dev/null 2>&1; then
      ok "$name"
    elif [[ "$optional" -eq 1 ]]; then
      info "-   $name (optional, not installed)"
    else
      warn "required CLI missing: $name"
    fi
  done < "$manifest"
}

# One IDE's extensions vs its manifest (if the IDE has a CLI shim on PATH).
audit_ide_extensions() {
  local cli="$1" manifest="$2"
  if ! command -v "$cli" >/dev/null 2>&1; then
    info "-   $cli: CLI shim not on PATH — extensions not auditable (install the shim from the IDE)"
    return
  fi
  local installed count required known missing unmanaged
  installed="$("$cli" --list-extensions 2>/dev/null | tr '[:upper:]' '[:lower:]' | sort -u)"
  count="$(echo "$installed" | grep -c . || true)"
  if [[ ! -f "$manifest" ]]; then
    warn "$cli: $count extensions installed but no manifest — baseline with: $cli --list-extensions | sort > $manifest"
    return
  fi
  required="$(manifest_required "$manifest")"
  known="$(manifest_known "$manifest")"
  missing="$(comm -23 <(echo "$required") <(echo "$installed"))"
  unmanaged="$(comm -23 <(echo "$installed") <(echo "$known"))"
  if [[ -n "$missing" ]]; then
    while read -r ext; do
      warn "$cli: required extension missing: $ext  ($cli --install-extension $ext)"
    done <<< "$missing"
  else
    ok "$cli: all required extensions installed"
  fi
  if [[ -n "$unmanaged" ]]; then
    while read -r ext; do
      warn "$cli: installed but not in manifest: $ext  (add to $(basename "$manifest") or uninstall)"
    done <<< "$unmanaged"
  else
    ok "$cli: no unmanaged extensions"
  fi
}

audit_ides() {
  log "IDE extensions (manifests in configs/<ide>/extensions.txt)"
  audit_ide_extensions code        "$DOTFILES/configs/vscode/extensions.txt"
  audit_ide_extensions antigravity "$DOTFILES/configs/antigravity/extensions.txt"
  audit_ide_extensions cursor      "$DOTFILES/configs/cursor/extensions.txt"
  audit_ide_extensions windsurf    "$DOTFILES/configs/windsurf/extensions.txt"
  audit_ide_extensions kiro        "$DOTFILES/configs/kiro/extensions.txt"
}

audit_agents() {
  log "AI agent harnesses"
  # Claude Code — user-level instructions + plugins
  if [[ -f "$HOME/.claude/CLAUDE.md" ]]; then
    ok "~/.claude/CLAUDE.md (user-level instructions) present"
  else
    warn "~/.claude/CLAUDE.md missing — user-level Claude instructions are NOT loaded in any project"
  fi
  if [[ -f "$HOME/.claude/settings.json" ]]; then
    ok "~/.claude/settings.json present"
  else
    warn "~/.claude/settings.json missing"
  fi
  local plugreg="$HOME/.claude/plugins/installed_plugins.json"
  if [[ -f "$plugreg" ]] && command -v python3 >/dev/null 2>&1; then
    local plugins
    plugins="$(python3 -c "import json; print('\n'.join(sorted(json.load(open('$plugreg'))['plugins'])))" 2>/dev/null || true)"
    if [[ -n "$plugins" ]]; then
      ok "Claude plugins: $(echo "$plugins" | grep -c .) installed"
      echo "$plugins" | sed 's/^/      /'
    fi
  fi
  # Other harness instruction homes — informational presence checks
  [[ -f "$HOME/.codex/AGENTS.md" ]]   && ok "~/.codex/AGENTS.md present"    || info "-   ~/.codex/AGENTS.md not present (Codex user instructions)"
  [[ -d "$HOME/.kiro/steering" ]]     && ok "~/.kiro/steering present ($(ls "$HOME/.kiro/steering" 2>/dev/null | wc -l | tr -d ' ') file(s))" || info "-   ~/.kiro/steering not present"
  [[ -d "$HOME/.antigravity/skills" ]] && ok "Antigravity skills linked (~/.antigravity/skills)" || warn "Antigravity skills not linked"
}

audit_secrets() {
  log "Secrets + local config"
  if [[ -f "$HOME/.secrets" ]]; then
    ok "~/.secrets exists"
  else
    warn "~/.secrets missing — run install, or: cp $DOTFILES/configs/zsh/.secrets.example ~/.secrets && chmod 600 ~/.secrets"
  fi
  if [[ -f "$HOME/.gitconfig.local" ]]; then
    ok "~/.gitconfig.local exists"
  else
    warn "~/.gitconfig.local missing — copy configs/git/.gitconfig.local.example"
  fi
}

audit_repo() {
  log "Repo state"
  local changes
  changes="$(git -C "$DOTFILES" status --porcelain 2>/dev/null)"
  if [[ -z "$changes" ]]; then
    ok "working tree clean"
  else
    warn "uncommitted changes:"
    echo "$changes" | sed 's/^/      /'
  fi
}

# ── commands ──────────────────────────────────────────────────────────────────
cmd_audit() {
  echo ""
  echo -e "${BLUE}dotfiles audit — $(date '+%Y-%m-%d %H:%M')${NC}"
  echo "─────────────────────────────────────────────"
  audit_symlinks;   echo ""
  audit_brew;       echo ""
  audit_clis;       echo ""
  audit_ides;       echo ""
  audit_agents;     echo ""
  audit_secrets;    echo ""
  audit_repo
  echo "─────────────────────────────────────────────"
  if [[ "$ISSUES" -eq 0 ]]; then
    echo -e "${GREEN}All checks passed.${NC}"
  else
    echo -e "${YELLOW}$ISSUES issue(s) found.${NC}"
    exit 1
  fi
}

cmd_install() {
  exec "$DOTFILES/scripts/install.sh" run
}

cmd_sync() {
  log "Pulling latest..."
  git -C "$DOTFILES" pull --ff-only
  if command -v brew &>/dev/null; then
    log "Refreshing Homebrew metadata (brew update)..."
    brew update --quiet || warn "brew update failed (offline?)"
  fi
  log "Re-applying setup (install.sh is idempotent)..."
  "$DOTFILES/scripts/install.sh" run
}

cmd_sync_editors() {
  "$DOTFILES/scripts/sync-editor-settings.sh"
}

cmd_help() {
  cat <<EOF
dotfiles.sh — manage this dotfiles setup

Usage: ./scripts/dotfiles.sh <command>

Commands:
  help          Show this help (default)
  install       Full bootstrap on a new machine (runs scripts/install.sh)
  sync          git pull + brew update, then re-apply everything (idempotent)
  sync-editors  Regenerate every VS Code-family editor's settings.json from
                configs/editors/common.json + configs/<editor>/overrides.json.
                Run after editing either file.
  audit         Report drift without changing anything:
                  - symlinks present and pointing into this repo
                  - Brewfile vs installed packages, outdated packages
                  - AI/dev CLIs vs configs/cli-tools.txt
                  - per-IDE extensions vs configs/<ide>/extensions.txt
                  - agent harnesses: ~/.claude instructions + plugins, Codex, Kiro
                  - ~/.secrets and ~/.gitconfig.local present
                  - uncommitted repo changes

See also: scripts/check-updates.sh (outdated packages; cron-friendly)
EOF
}

case "${1:-help}" in
  install)      cmd_install ;;
  sync)         cmd_sync ;;
  sync-editors) cmd_sync_editors ;;
  audit)        cmd_audit ;;
  help|-h|--help|*) cmd_help ;;
esac
