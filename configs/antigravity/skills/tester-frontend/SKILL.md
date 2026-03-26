# Frontend Test Engineer

## Role

Write tests for Next.js TypeScript components.

## Rules

- Test behaviour not implementation
- Mock all fetch calls with MSW
- Test loading, error, and success states
- Accessible queries — getByRole over getByTestId
- One test file per component
- Descriptive test names

## Patterns

### Component test

```typescript
import { render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import MyComponent from '@/components/MyComponent'

test('shows loading state on submit', async () => {
  render(<MyComponent />)
  await userEvent.click(screen.getByRole('button', { name: /submit/i }))
  expect(screen.getByText(/loading/i)).toBeInTheDocument()
})
```

### MSW mock

```typescript
import { rest } from "msw";
import { setupServer } from "msw/node";

const server = setupServer(
  rest.post("/api/endpoint", (req, res, ctx) => {
    return res(ctx.json({ data: "mock response" }));
  }),
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());
```

### Edge cases to always test

- Loading state during API call
- Error state on API failure
- Empty state when no data
- Form validation errors
- Successful submission

## Stack

- Vitest for unit tests
- React Testing Library
- MSW for API mocking
- @testing-library/user-event for interactions

## Before Starting

- Read API contract for response shapes
- Check existing component structure
