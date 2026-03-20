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

Install in editable mode:

```bash
uv pip install -e .
```

---

## 5. Create folder structure

### Python CLI tool

```
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
# AI
GROQ_API_KEY=your_key_here
ANTHROPIC_API_KEY=your_key_here

# Database
DATABASE_URL=postgresql://user:password@host/dbname
MONGODB_URI=mongodb+srv://user:password@cluster/dbname
```

---

## 8. Personal config files (not in repo)

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

## 9. Feature branch workflow

```bash
# Start new feature
git checkout -b feature/my-feature

# Work, commit
git add .
git commit -m "feat: add my feature"

# Push and create PR
git push -u origin feature/my-feature
gh pr create

# After merge, clean up
git checkout main
git pull
git branch -d feature/my-feature
```

---

## 10. Commit message conventions

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

```
feat: add get_commits function
fix: handle missing config file
docs: add module docstrings
chore: add ruff linting config
refactor: replace print with logger
```

---

## 11. First commit checklist

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
