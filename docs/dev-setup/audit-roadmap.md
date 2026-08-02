# Audit coverage — current + roadmap

What `./scripts/dotfiles.sh audit` covers today, and what it should grow to
cover. Update this file as items move up.

## Covered today

| Area | Check | Source of truth |
| --- | --- | --- |
| Symlinks | every expected link exists and points into this repo | list in `scripts/dotfiles.sh` (keep in sync with `scripts/install.sh`) |
| Packages | Brewfile satisfied + count of outdated formulas/casks | `Brewfile` |
| AI / dev CLIs | required CLIs on PATH (claude, codex, opencode, kimchi, copilot, pi, vibe, kiro, code); optional ones reported | `configs/cli-tools.txt` |
| VS Code extensions | required-missing + unmanaged-installed | `configs/vscode/extensions.txt` |
| Other IDE extensions | audited when the IDE's CLI shim is on PATH; prompts to create a baseline manifest | `configs/<ide>/extensions.txt` (create per IDE) |
| Claude Code | `~/.claude/CLAUDE.md` present (user-level instructions), `settings.json` present, installed plugins listed | `~/.claude/plugins/installed_plugins.json` |
| Other harnesses | `~/.codex/AGENTS.md`, `~/.kiro/steering`, Antigravity skills link | presence checks |
| Secrets | `~/.secrets` + `~/.gitconfig.local` exist | templates in `configs/` |
| Repo | uncommitted changes | `git status` |

## Not covered yet — roadmap

1. **Antigravity / Cursor / Windsurf extension baselines** — install each
   IDE's CLI shim (command palette → "install ... command in PATH"), then
   baseline: `<ide> --list-extensions | sort > configs/<ide>/extensions.txt`.
   Zed has no compatible extension CLI — needs its own approach.
2. **Common agent instructions wiring** — once the shared skills/instructions
   repo exists: symlink its AGENTS.md into `~/.claude/CLAUDE.md`,
   `~/.codex/AGENTS.md`, opencode config, Kiro steering; add those links to
   `expected_links()` so the audit enforces them.
3. **Claude plugins/skills as a manifest** — today the audit lists installed
   plugins; next step is a desired-state manifest (like extensions.txt) so
   missing/unmanaged plugins get flagged. Same for skills dirs and MCP
   servers (`claude mcp list`).
4. **npm globals + uv tools** — manifest for `npm ls -g` (e.g. vercel) and
   `uv tool list`; audit against them.
5. **Per-IDE settings drift** — VS Code settings.json is symlinked; verify
   whether Antigravity reads the same file or a diverging copy, and audit it.
6. **System level** — Mac App Store apps (`mas`), fonts present, cron job for
   check-updates installed, `gh auth status`, rbw unlocked/configured.
7. **WSL2 parity** — run the same audit on the Windows machine; anything
   macOS-only should degrade gracefully (it already skips mac-only links).
