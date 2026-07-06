#!/usr/bin/env bash
# scripts/agents-welcome.sh
# Text-based welcome banner listing AI coding agents you've tested, their
# surface (VS Code / CLI / App) and what each is best at.
# Sourced from .zshrc so it prints on every new interactive shell.
# Source of truth for status: obsidian-personal vault, 05-System/AI-Verification-Test.md
#
# Alignment note: emoji glyphs render at inconsistent widths across terminals/
# fonts, which breaks column alignment with printf. This uses single-width
# ASCII symbols + ANSI color instead, with padding computed manually so
# color escape codes (which are invisible but count as characters) never
# throw off the columns.

BLUE=$'\033[0;34m'
DIM=$'\033[2m'
GREEN=$'\033[0;32m'
RED=$'\033[0;31m'
YELLOW=$'\033[0;33m'
CYAN=$'\033[0;36m'
GRAY=$'\033[2m'
NC=$'\033[0m'

# Legend: check=pass  x=fail  !=partial  star=best  >>=skipped  -=not applicable/not tested
PASS="${GREEN}✓${NC}"
FAIL="${RED}✗${NC}"
PARTIAL="${YELLOW}!${NC}"
BEST_ICON="${CYAN}★${NC}"
SKIP="${GRAY}»${NC}"
NA="${GRAY}-${NC}"

AGENT_W=22
COL_W=8

# Prints one icon left-padded to COL_W visible columns (color codes excluded from width math).
field() {
  local icon="$1"
  printf '%s%*s' "$icon" $((COL_W - 1)) ""
}

row() {
  local agent="$1" vscode="$2" cli="$3" app="$4" best="$5"
  printf '%-*s%s%s%s%s\n' "$AGENT_W" "$agent" "$(field "$vscode")" "$(field "$cli")" "$(field "$app")" "$best"
}

echo ""
echo -e "${BLUE}AI Agents${NC} ${DIM}(update in dotfiles/scripts/agents-welcome.sh)${NC}"
echo "─────────────────────────────────────────────────────────────────────────"
printf '%-*s%-*s%-*s%-*s%s\n' "$AGENT_W" "AGENT" "$COL_W" "VSCODE" "$COL_W" "CLI" "$COL_W" "APP" "BEST AT"
echo "─────────────────────────────────────────────────────────────────────────"
row "Claude"              "$PARTIAL"  "$PASS" "$NA"   "Deep agentic coding, repo-wide tasks"
row "Codex (OpenAI)"      "$PASS"     "$PASS" "$NA"   "Sandboxed/scripted coding agent tasks"
row "Cursor"              "$NA"       "$NA"   "$PASS" "Inline AI-assisted coding in-IDE"
row "Windsurf/Devin"      "$NA"       "$NA"   "$PASS" "IDE + autonomous agent in one app"
row "Antigravity IDE"     "$NA"       "$NA"   "$PASS" "Agentic multi-file IDE coding"
row "Gemini Code Assist"  "$PASS"     "$NA"   "$NA"   "Coding + Google Cloud/Workspace"
row "Continue"            "$PASS"     "$NA"   "$NA"   "Customizable, provider-agnostic"
row "GitHub Copilot"      "$BEST_ICON" "$NA"  "$NA"   "Broadest ecosystem, general coding"
row "Mistral Vibe"        "$NA"       "$FAIL" "$NA"   "General chat (unreliable for agentic coding)"
row "Cline"               "$PASS"     "$NA"   "$NA"   "Autonomous multi-step file/terminal ops"
row "Pi (pi.dev)"         "$NA"       "$PASS" "$NA"   "General chat, routed coding backends"
row "Kimchi"              "$NA"       "$PASS" "$NA"   "General chat, open-model routing"
row "opencode"            "$NA"       "$PASS" "$NA"   "Terminal coding agent, BYO model"
row "CommandCode"         "$NA"       "$SKIP" "$NA"   "Untestable in current setup"
echo "─────────────────────────────────────────────────────────────────────────"
echo ""
