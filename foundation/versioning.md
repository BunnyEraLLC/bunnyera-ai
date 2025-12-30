# BunnyEra Versioning Policy

## 1. Semantic Versioning (SemVer)
We follow [SemVer 2.0.0](https://semver.org/): `MAJOR.MINOR.PATCH`

- **MAJOR**: Incompatible API changes.
- **MINOR**: Backward-compatible functionality (new features).
- **PATCH**: Backward-compatible bug fixes.

## 2. Release Tagging
- All releases must be tagged in Git: `v1.0.0`, `v1.0.1`, etc.
- Tags should be signed if possible.

## 3. Pre-releases
- Alpha: `v1.0.0-alpha.1` (Internal testing)
- Beta: `v1.0.0-beta.1` (Public testing)
- RC: `v1.0.0-rc.1` (Release Candidate)

## 4. Changelog
- A `CHANGELOG.md` file must be maintained.
- Update it for every release.
- Group changes by: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`.
