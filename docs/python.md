# 🐍 Python

[← Quick Reference](../QUICK-REF.md)

## 📦 uv — environment + packages

<table><tr><td width="33%">

### Python versions

| Command | What it does |
|---|---|
| `uv python install 3.12` | Install 3.12 |
| `uv python install 3.11` | Install 3.11 |
| `uv python list` | List versions |
| `uv python pin 3.12` | Pin for project |

### Virtual environments

| Command | What it does |
|---|---|
| `uv venv` | Create `.venv` |
| `uv venv --python 3.12` | With version |
| `source .venv/bin/activate` | Activate (Mac) |
| `.venv\Scripts\activate` | Activate (Win) |
| `deactivate` | Deactivate |

</td><td width="33%">

### Packages

| Command | What it does |
|---|---|
| `uv pip install pkg` | Install |
| `uv pip install -r requirements.txt` | From file |
| `uv pip install -e .` | Editable mode |
| `uv pip uninstall pkg` | Remove |
| `uv pip list` | List installed |
| `uv pip freeze` | Pin versions |
| `uv pip compile requirements.in` | Compile deps |

</td><td width="33%">

### Running

| Command | What it does |
|---|---|
| `uv run script.py` | Run in venv |
| `uv run pytest` | Run pytest |
| `uv run uvicorn main:app` | Run server |
| `uv run -- python -m module` | Run module |

### New project setup

```bash
mkdir myproject && cd myproject
uv venv
source .venv/bin/activate
uv pip install crewai langgraph
echo 'source .venv/bin/activate' > .envrc
direnv allow
git init
```

</td></tr></table>

---

## 🔧 direnv + ipython

<table><tr><td width="50%">

### direnv — auto env vars

| Command | What it does |
|---|---|
| `direnv allow` | Approve `.envrc` |
| `direnv deny` | Revoke |
| `direnv reload` | Reload after edit |
| `direnv status` | Show status |

**Typical `.envrc`:**
```bash
source .venv/bin/activate
export AWS_PROFILE=myproject
export ENVIRONMENT=development
export API_URL=http://localhost:8000
export OPENAI_API_KEY=sk-...
```

</td><td width="50%">

### ipython — enhanced REPL

| Command | What it does |
|---|---|
| `ipython` | Start REPL |
| `%run script.py` | Run file |
| `%timeit func()` | Time function |
| `%paste` | Paste + run |
| `%history` | Command history |
| `?object` | Show docs |
| `??object` | Show source |
| `%load_ext autoreload` | Auto-reload |
| `%autoreload 2` | Enable |
| `Ctrl+D` | Exit |

</td></tr></table>

---

## 🧪 pytest

<table><tr><td width="50%">

| Command | What it does |
|---|---|
| `uv run pytest` | Run all tests |
| `uv run pytest -v` | Verbose |
| `uv run pytest tests/test_file.py` | Run file |
| `uv run pytest -k "test_name"` | By name |
| `uv run pytest -x` | Stop on fail |
| `uv run pytest --pdb` | Debug on fail |

</td><td width="50%">

### Common agentic packages

| Package | What it does |
|---|---|
| `crewai` | Multi-agent framework |
| `langgraph` | Graph-based agents |
| `langchain` | LLM framework |
| `anthropic` | Claude API |
| `openai` | OpenAI API |
| `fastapi` | API framework |
| `uvicorn` | ASGI server |
| `pydantic` | Data validation |

</td></tr></table>
