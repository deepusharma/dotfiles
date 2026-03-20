# New Project Playbook

Step-by-step for starting any new project from scratch.
Covers git, GitHub, Python setup, and folder structure.

---

## 1. Create the folder

```bash
mkdir ~/projects/myproject && cd ~/projects/myproject
```

---

## 2. Initialise git

```bash
git init
git checkout -b main    # use main not master
```

---

## 3. Create the GitHub repo

### Under your personal account

```bash
gh repo create myproject --public --source=. --remote=origin --push
```

### Under an organisation

```bash
gh repo create org-name/myproject --public --source=. --remote=origin --push
```

### Useful gh commands

```bash
gh repo view                          # view current repo
gh repo view --web                    # open in browser
gh browse                             # open in browser
gh repo list deepusharma              # list your repos
gh repo list dsharma-lab              # list org repos
```

---

## 4. Set up Python environment

```bash
uv init --name myproject              # generates pyproject.toml
uv venv                               # creates .venv
source .venv/bin/activate             # activate
```

Edit `pyproject.toml`:

```toml
[project]
name = "myproject"
version = "0.1.0"
description = "Your description"
readme = "README.md"
requires-python = ">=3.12"
dependencies = []

[tool.ruff]
select = ["T20"]
```

Install the project and dev dependencies:

```bash
uv pip install -e .
uv pip install -e ".[dev]"
```

---

## 5. Create folder structure

### Python CLI tool

```none
myproject/
├── src/
│   ├── __init__.py
│   ├── cli.py
│   └── core.py
├── tests/
│   └── __init__.py
├── docs/
├── db/
│   ├── schema.sql
│   └── seed.sql
├── .env
├── .env.example
├── .gitignore
├── README.md
└── pyproject.toml
```

```bash
mkdir -p src tests docs db
touch src/__init__.py src/cli.py
touch tests/__init__.py
touch .env .env.example .gitignore README.md
touch db/schema.sql db/seed.sql
```

### FastAPI service

```
myproject/
├── app/
│   ├── __init__.py
│   ├── main.py
│   ├── routes/
│   ├── models/
│   └── services/
├── tests/
├── docs/
├── db/
├── .env
├── .env.example
├── .gitignore
├── README.md
└── pyproject.toml
```

---

## 6. Create .gitignore

```
# Python
.env
.venv/
__pycache__/
*.pyc
*.pyo
*.egg-info/
dist/
build/
.pytest_cache/

# Editor
.vscode/
*.code-workspace

# OS
.DS_Store
Thumbs.db

# Project specific — add as needed
*.session.sql
*.mongodb.js
```

---

## 7. Create .env.example

Document all required environment variables:

```
# AI APIs
GROQ_API_KEY=your_key_here
ANTHROPIC_API_KEY=your_key_here
OPENAI_API_KEY=your_key_here

# Database
DATABASE_URL=postgresql://user:password@host/dbname
MONGODB_URI=mongodb+srv://user:password@cluster/dbname
```

---

## 8. Set up databases (online, free tier)

### Neon — PostgreSQL

1. Sign up at https://neon.tech with GitHub
2. Create project — name it `dev-sandbox`
3. Copy connection string: `postgresql://user:password@ep-xxx.aws.neon.tech/neondb`
4. Connect in Antigravity: `Ctrl+Shift+P` → `SQLTools: Add New Connection` → PostgreSQL
   - Enable SSL — required for Neon
5. Create schema in `db/schema.sql`, run via SQLTools

### MongoDB Atlas

1. Sign up at https://mongodb.com/atlas
2. Create free cluster (M0) — AWS Mumbai for India
3. Connect → Drivers → copy connection string:
   `mongodb+srv://user:password@cluster.mongodb.net/`
4. Network Access → Add IP → Allow Access from Anywhere (dev only)
5. Connect in Antigravity via MongoDB for VS Code extension

### SQLite (no setup needed)

Just a file — good for simple CLI tools and prototypes:

```python
import sqlite3
conn = sqlite3.connect("myproject.db")
```

---

## 9. Set up AI APIs

### Groq (free tier — recommended for development)

1. Sign up at https://console.groq.com
2. API Keys → Create new key
3. Add to `.env`:

   ```env
   GROQ_API_KEY=your_key_here
   ```

4. Install client:
   ```bash
   uv pip install groq
   ```
5. Available models: `llama-3.3-70b-versatile`, `mixtral-8x7b-32768`

### Anthropic Claude

1. Sign up at https://console.anthropic.com
2. API Keys → Create key
3. Add to `.env`:
   ```
   ANTHROPIC_API_KEY=your_key_here
   ```
4. Install client:
   ```bash
   uv pip install anthropic
   ```

### OpenAI

1. Sign up at https://platform.openai.com
2. API Keys → Create key
3. Add to `.env`:
   ```
   OPENAI_API_KEY=your_key_here
   ```
4. Install client:
   ```bash
   uv pip install openai
   ```

---

## 10. Personal config files (not in repo)

Some tools need a config in home directory:

### gitpulse

```bash
nano ~/.gitpulse.toml
```

```toml
[repos]
myproject = "/mnt/d/GitProjects/public/myproject"
```

---

## 11. VS Code settings

No action needed — settings are managed via dotfiles and symlinked automatically
by `install.sh`.

To verify the symlink is in place:

```bash
# WSL/Windows
ls -la "/mnt/c/Users/$USER/AppData/Roaming/Code/User/settings.json"

# Mac
ls -la "$HOME/Library/Application Support/Code/User/settings.json"
```

To update settings, edit `configs/vscode/settings.json` in dotfiles repo and push.

---

## 12. Feature branch workflow

```bash
# Start new feature
git checkout -b feature/my-feature

# Work, commit
git add .
git commit -m "feat: add my feature"

# Push and create PR
# Note: use -u on first push of a new branch — sets up tracking
git push -u origin feature/my-feature
gh pr create

# Merge the PR
gh pr merge --squash

# After merge, clean up
git checkout main
git pull
git branch -d feature/my-feature

```

---

## 13. Commit message conventions

Use conventional commits format:

| Prefix      | When to use                 |
| ----------- | --------------------------- |
| `feat:`     | New feature                 |
| `fix:`      | Bug fix                     |
| `docs:`     | Documentation only          |
| `refactor:` | Code change, no feature/fix |
| `test:`     | Adding tests                |
| `chore:`    | Build, config, tooling      |
| `style:`    | Formatting, no logic change |

Examples:

```yaml
feat: add get_commits function
fix: handle missing config file
docs: add module docstrings
chore: add ruff linting config
refactor: replace print with logger
```

---

## 14. First commit checklist

Before first push, verify:

- [ ] `.gitignore` is in place
- [ ] `.env` is NOT tracked (`git status` shouldn't show it)
- [ ] `README.md` exists with basic description
- [ ] `pyproject.toml` has correct name and version
- [ ] No secrets or personal paths in committed files

```bash
git status          # check what's being tracked
git diff --staged   # review what you're committing
```
