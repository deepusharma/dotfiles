# Python Packages Reference

Packages installed across projects. Use this to replicate environments.

---

## Terminal / dotfiles setup (global tools)

```bash
brew install uv ipython ruff
```

---

## Per-project — install into venv

### Every Python project

```bash
uv venv
source .venv/bin/activate
uv pip install -e .
```

### gitpulse (CLI tool)

```bash
uv pip install \
  typer \
  groq \
  gitpython \
  rich \
  python-dotenv \
  ruff
```

`pyproject.toml` dependencies:
```toml
[project]
dependencies = [
    "typer",
    "groq",
    "gitpython",
    "rich",
    "python-dotenv",
]

[tool.ruff]
select = ["T20"]
```

### Agentic apps (CrewAI / LangGraph)

```bash
uv pip install \
  crewai \
  langgraph \
  langchain \
  anthropic \
  openai \
  fastapi \
  uvicorn \
  python-dotenv \
  pydantic
```

### FastAPI / web service

```bash
uv pip install \
  fastapi \
  uvicorn \
  pydantic \
  python-dotenv \
  sqlalchemy \
  psycopg2-binary
```

### Data / notebooks

```bash
uv pip install \
  pandas \
  numpy \
  matplotlib \
  jupyter \
  ipykernel
```

---

## UV_LINK_MODE fix (add to ~/.zshrc)

Silences the hardlink warning when project is on Windows filesystem:

```bash
export UV_LINK_MODE=copy
```

---

## Ruff configuration

Add to `pyproject.toml`:

```toml
[tool.ruff]
select = ["T20"]   # flag print statements
```

Run manually:
```bash
ruff check src/     # check
ruff check --fix src/  # auto-fix where possible
```
