# BunnyEra Dependency Management

## 1. Package Manager
- Use **npm** (v9+) as the primary package manager.
- `package-lock.json` MUST be committed to ensure reproducible builds.

## 2. Dependency Classification
- **dependencies**: Libraries required for the application to run (e.g., `express`, `react`).
- **devDependencies**: Tools for development, testing, and building (e.g., `jest`, `eslint`, `typescript`).

## 3. Version Pinning
- Avoid using `*` or `latest` for versions.
- Use Caret (`^`) for semantic versioning compatibility (e.g., `^1.2.3`).
- For critical infrastructure, consider exact version pinning (e.g., `1.2.3`).

## 4. Auditing
- Run `npm audit` before every major release.
- CI pipelines should fail if there are 'High' or 'Critical' vulnerabilities.

## 5. Adding New Dependencies
- Evaluate community support (GitHub stars, recent commits).
- Check bundle size impact (for frontend).
- Verify license compatibility (MIT/Apache preferred).
