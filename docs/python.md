# Python

[← Back to Quick Reference](../QUICK-REF.md)

---

## uv — environment + package manager

### Python versions

| Command | What it does |
|---|---|
| `uv python install 3.12` | Install Python 3.12 |
| `uv python install 3.11` | Install Python 3.11 |
| `uv python list` | List available versions |
| `uv python pin 3.12` | Pin version for current project |

### Virtual environments

| Command | What it does |
|---|---|
| `uv venv` | Create `.venv` in current directory |
| `uv venv --python 3.12` | Create venv with specific Python |
| `source .venv/bin/activate` | Activate venv (Mac/Linux) |
| `.venv\Scripts\activate` | Activate venv (Windows) |
| `deactivate` | Deactivate venv |

### Packages

| Command | What it does |
|---|---|
| `uv pip install <pkg>` | Install a package |
| `uv pip install -r requirements.txt` | Install from requirements file |
| `uv pip install -e .` | Install in editable mode |
| `uv pip uninstall <pkg>` | Uninstall a package |
| `uv pip list` | List installed packages |
| `uv pip freeze` | Output pinned requirements |
| `uv pip compile requirements.in` | Pin dependencies |

### Running scripts

| Command | What it does |
|---|---|
| `uv run script.py` | Run script in project venv |
| `uv run pytest` | Run pytest in project venv |
| `uv run -- python -m module` | Run a module |

---

## Typical project setup

```bash
mkdir myproject && cd myproject
uv venv
source .venv/bin/activate
uv pip install crewai langgraph
echo 'source .venv/bin/activate' > .envrc
direnv allow
git init
```

---

## direnv — per-project environment

| Command | What it does |
|---|---|
| `direnv allow` | Approve `.envrc` in current directory |
| `direnv deny` | Revoke approval |
| `direnv reload` | Reload after editing `.envrc` |
| `direnv status` | Show current status |

### Typical `.envrc` file

```bash
# Activate venv automatically
source .venv/bin/activate

# Project-specific env vars
export AWS_PROFILE=myproject
export ENVIRONMENT=development
export API_URL=http://localhost:8000
export OPENAI_API_KEY=sk-...
```

---

## ipython — enhanced REPL

| Command | What it does |
|---|---|
| `ipython` | Start REPL |
| `%run script.py` | Run a Python file |
| `%timeit func()` | Time a function |
| `%paste` | Paste and run clipboard code |
| `%history` | Show command history |
| `?object` | Show documentation |
| `??object` | Show source code |
| `%load_ext autoreload` | Auto-reload modules |
| `%autoreload 2` | Enable autoreload |
| `Ctrl+D` | Exit |

---

## pytest — testing

| Command | What it does |
|---|---|
| `uv run pytest` | Run all tests |
| `uv run pytest -v` | Verbose output |
| `uv run pytest tests/test_file.py` | Run specific file |
| `uv run pytest -k "test_name"` | Run tests matching name |
| `uv run pytest -x` | Stop on first failure |
| `uv run pytest --pdb` | Drop into debugger on failure |

---

## Common agentic app packages

| Package | What it does |
|---|---|
| `crewai` | Multi-agent framework |
| `langgraph` | Graph-based agent workflows |
| `langchain` | LLM application framework |
| `anthropic` | Claude API client |
| `openai` | OpenAI API client |
| `fastapi` | API framework |
| `uvicorn` | ASGI server for FastAPI |
| `python-dotenv` | Load `.env` files |
| `pydantic` | Data validation |
