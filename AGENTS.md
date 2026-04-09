# AGENTS.md — AI Agent Instructions

This file provides context and rules for AI coding agents
(Antigravity, Gemini, Claude, etc.) working in this repository.
`CLAUDE.md` is a symlink to this file — both tools read the same content.

---

## What this repo is

A personal dotfiles repo — version-controlled shell configs, tool configs,
and an install script that bootstraps a new macOS or Windows (WSL2) machine
from zero to fully configured in one command.

**Primary owner:** Deepak Sharma (`deepu.sharma@gmail.com`)\
**GitHub handle:** `deepusharma`\
**Platforms:** macOS (primary), Windows WSL2 (secondary)

---

## Common commands

```bash
# Lint all Markdown files (run before committing)
markdownlint '**/*.md'

# Verify Brewfile is in sync with installed packages
brew bundle check --file=Brewfile

# Full maintenance check (outdated packages, Brewfile drift, uncommitted changes)
./scripts/check-updates.sh
```

There is no build step, test suite, or compilation. Changes to `configs/` take
effect immediately on next shell reload (`exec zsh`) or tool restart.

---

## Repo structure

```text
dotfiles/
├── AGENTS.md               # AI agent instructions (CLAUDE.md symlinks here)
├── README.md               # human-facing setup guide
├── CHEATSHEET.md           # full command reference for all tools
├── QUICK-REF.md            # condensed quick-reference card
├── Brewfile                # all Homebrew packages
├── install.sh              # bootstrap script — run once on a new machine
├── .markdownlint.json      # markdown linting rules
├── configs/
│   ├── alacritty/          # Alacritty terminal config (Windows/WSL2)
│   │   └── alacritty.toml
│   ├── ghostty/            # Ghostty terminal config (macOS)
│   │   └── config
│   ├── git/
│   │   ├── .gitconfig      # global git config (symlinked to ~/.gitconfig)
│   │   └── .gitconfig.local.example
│   ├── starship/
│   │   └── starship.toml   # prompt config (symlinked to ~/.config/starship.toml)
│   ├── vscode/
│   │   └── settings.json   # VS Code user settings
│   ├── zellij/             # Zellij multiplexer config + layouts
│   └── zsh/
│       └── .zshrc          # Zsh shell config (symlinked to ~/.zshrc)
├── docs/
│   └── dev-setup/          # setup guides: extensions, Python, Node, plugins
├── scripts/
│   └── check-updates.sh    # optional weekly update checker (cron-ready)
└── images/                 # diagrams used in README.md
```

---

## How the symlink system works

`install.sh` creates symlinks from where tools expect configs to where this
repo stores them. For example:

- `~/.gitconfig` → `~/dotfiles/configs/git/.gitconfig`
- `~/.config/starship.toml` → `~/dotfiles/configs/starship/starship.toml`
- `~/.zshrc` → `~/dotfiles/configs/zsh/.zshrc`

**Consequence for agents:** editing a file in `configs/` is the same as
editing the live config. There is no build or deploy step. Changes take
effect on next shell reload (`exec zsh`) or tool restart.

---

## Tech stack

| Layer | Tool |
| --- | --- |
| Terminal | Ghostty (macOS) / Alacritty (Windows) |
| Shell | Zsh + Oh My Zsh |
| Multiplexer | Zellij |
| Prompt | Starship |
| File listing | eza |
| Dir jump | zoxide |
| Fuzzy find | fzf |
| File pager | bat |
| Search | ripgrep |
| Git UI | lazygit + gh CLI |
| Git diff | delta |
| Python | uv + ipython |
| Node | nvm |
| Cloud CLIs | aws / gcloud / az |
| JSON / HTTP | jq + httpie |
| Editor | VS Code |

---

## Key conventions

- **Commit messages** follow Conventional Commits:
  `feat:`, `fix:`, `chore:`, `docs:`, `refactor:`
- **Config changes** go in `configs/<tool>/` — never edit home-dir dotfiles
- **New tools:** add to `Brewfile`, add config to `configs/`, add symlink to
  `install.sh`, update docs
- **Markdown** is linted — run `markdownlint '**/*.md'` before committing
- **No secrets** — no API keys, tokens, or passwords in this repo

---

## What agents should and shouldn't do

### ✅ Do

- Edit files in `configs/` when updating tool configurations
- Keep `README.md`, `CHEATSHEET.md`, and `QUICK-REF.md` in sync
- Update `Brewfile` when adding or removing tools
- Follow existing formatting and comment style within each file
- Use Conventional Commits format for commit messages

### ❌ Don't

- Add secrets, credentials, or personal tokens to any file
- Modify `install.sh` unless explicitly asked — regressions are hard to test
- Create new top-level directories without discussing first
- Break cross-platform compatibility — configs should work on both macOS and
  WSL2 unless clearly platform-specific (e.g., `ghostty/`, `alacritty/`)

---

## Platform notes

| File | macOS | Windows WSL2 |
| --- | --- | --- |
| `configs/ghostty/` | ✅ used | ❌ not used |
| `configs/alacritty/` | ❌ not used | ✅ manual copy |
| `configs/zsh/.zshrc` | ✅ | ✅ |
| `configs/starship/starship.toml` | ✅ | ✅ |
| `configs/vscode/settings.json` | ✅ | ✅ |
| `configs/git/.gitconfig` | ✅ | ✅ |
| `Brewfile` | ✅ Homebrew | ✅ Linuxbrew |
