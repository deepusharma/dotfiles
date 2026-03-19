# Quick Reference

Top commands for every tool in the stack. Click any section header for the full reference.

---

## [Git + GitHub CLI](docs/git.md)

| Command | What it does |
|---|---|
| `lg` | Open lazygit (visual git UI) |
| `git status` | Show working tree status |
| `git add .` | Stage all changes |
| `git commit -m "msg"` | Commit with message |
| `git push` | Push to remote |
| `git pull` | Pull from remote |
| `git checkout -b branch` | Create and switch to new branch |
| `gh repo create` | Create a new GitHub repo |
| `gh pr create` | Open a pull request |
| `gh browse` | Open repo in browser |

---

## [Terminal](docs/terminal.md)

| Command / Key | What it does |
|---|---|
| `Ctrl+p` | Zellij pane mode |
| `Ctrl+t` | Zellij tab mode |
| `Alt+←→↑↓` | Move between panes |
| `space` | lazygit — stage file |
| `c` | lazygit — commit |
| `Ctrl+R` | fzf — fuzzy history search |
| `Ctrl+T` | fzf — fuzzy file search |
| `z dirname` | zoxide — jump to directory |
| `lt` | eza — tree view |
| `lg` | Open lazygit |

---

## [Python](docs/python.md)

| Command | What it does |
|---|---|
| `uv venv` | Create virtual environment |
| `source .venv/bin/activate` | Activate venv |
| `uv pip install pkg` | Install package |
| `uv python install 3.12` | Install Python version |
| `direnv allow` | Approve `.envrc` for auto-loading |
| `ipython` | Start enhanced Python REPL |

---

## [Node](docs/node.md)

| Command | What it does |
|---|---|
| `nvm install --lts` | Install latest LTS Node |
| `nvm use 20` | Switch to Node 20 |
| `nvm ls` | List installed versions |
| `npm install` | Install dependencies |
| `npm run dev` | Run dev script |
| `npm run build` | Build for production |

---

## [Editor — Antigravity](docs/editor.md)

| Shortcut | What it does |
|---|---|
| `Ctrl+Shift+P` | Command palette |
| `Ctrl+P` | Quick file open |
| `Ctrl+Shift+E` | File explorer |
| `Ctrl+Shift+G` | Source control |
| `Ctrl+Shift+X` | Extensions |
| `Ctrl+\`` | Toggle terminal |
| `Ctrl+B` | Toggle sidebar |
| `Ctrl+Shift+V` | Markdown preview |
| `Ctrl+/` | Toggle comment |
| `F12` | Go to definition |

---

## [Markdown](docs/markdown.md)

| Syntax | What it does |
|---|---|
| `# H1` `## H2` `### H3` | Headings |
| `**bold**` | Bold text |
| `*italic*` | Italic text |
| `` `code` `` | Inline code |
| `- item` | Bullet list |
| `1. item` | Numbered list |
| `[text](url)` | Link |
| `![alt](url)` | Image |
| `> text` | Blockquote |
| ` ```lang ` | Code block |

---

*Full references: [Git](docs/git.md) · [Terminal](docs/terminal.md) · [Python](docs/python.md) · [Node](docs/node.md) · [Editor](docs/editor.md) · [Markdown](docs/markdown.md)*
