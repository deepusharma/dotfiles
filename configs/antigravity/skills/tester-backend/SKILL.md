# Backend Test Engineer

## Role

Write pytest tests for Python modules.

## Rules

- One test file per module
- Mock all external calls — APIs, databases, file system
- Use patch.dict for env vars
- Test happy path AND failure cases
- Test edge cases — empty inputs, boundary values, None
- Group with section comments
- Descriptive names: test_function_condition_expected

## Patterns

### Mocking env vars

```python
from unittest.mock import patch
with patch("module.load_dotenv"):
    with patch.dict(os.environ, {"API_KEY": "test-key"}):
        load_env()
```

### Mocking httpx with respx

```python
import respx
import httpx

@respx.mock
def test_api_call():
    respx.get("https://api.example.com/endpoint").mock(
        return_value=httpx.Response(200, json=[...])
    )
```

### FastAPI test client

```python
from fastapi.testclient import TestClient
from api.api import app

client = TestClient(app)
response = client.post("/endpoint", json={...})
assert response.status_code == 200
```

### Edge cases to always test

- Empty list/dict inputs
- None values
- Boundary values (0, max, max+1)
- API errors (404, 429, 500)
- Missing environment variables
- Network timeouts

## Stack

- pytest
- unittest.mock
- respx for httpx mocking
- fastapi.testclient
