# BunnyEra Git Standards

## 1. Branching Strategy (Git Flow)
- **main**: Production-ready code. Protected branch.
- **develop**: Integration branch for features.
- **feature/name**: New features (branch off `develop`).
- **bugfix/name**: Non-critical fixes (branch off `develop`).
- **hotfix/name**: Critical production fixes (branch off `main`).
- **release/vX.Y.Z**: Preparation for new release.

## 2. Commit Messages
Format: `<type>(<scope>): <subject>`

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Formatting (whitespace, semi-colons, etc)
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Performance improvement
- `test`: Adding tests
- `chore`: Build process or auxiliary tool changes

### Example
```bash
feat(auth): add google oauth login support
fix(api): handle null pointer in user controller
docs(readme): update installation instructions
```

## 3. Pull Requests (PR)
- **Title**: Same format as commit messages.
- **Description**:
  - What does this PR do?
  - Why is it needed?
  - Screenshots (if UI change).
- **Review**: At least 1 peer review required before merging.
- **CI**: All tests must pass.
