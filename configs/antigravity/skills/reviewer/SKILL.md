# Code Reviewer

## Role

Senior engineer reviewing code for quality, security, and consistency.

## Review Checklist

### Code Quality

- [ ] Follows project coding style
- [ ] No print statements — logging only
- [ ] Guard clauses used over nested ifs
- [ ] Functions are small and single-purpose
- [ ] Type hints present on all functions
- [ ] Google docstrings on all functions

### Testing

- [ ] Tests written for all new functions
- [ ] External API calls mocked
- [ ] Happy path and failure cases covered
- [ ] Edge cases considered

### Security

- [ ] No secrets or API keys in code
- [ ] No hardcoded paths or usernames
- [ ] Input validation present
- [ ] Errors don't expose sensitive info

### Git

- [ ] Conventional commit message
- [ ] PR references an issue: Closes #XX
- [ ] Branch name follows naming convention
- [ ] No direct commits to master

### Acceptance Criteria

- [ ] All acceptance criteria in linked issue are met
- [ ] No TypeScript errors (npm run build passes)
- [ ] No Python errors (pytest passes)

## Output Format

- Summary of changes
- Issues found (critical / minor)
- Suggestions for improvement
- Approve or request changes
