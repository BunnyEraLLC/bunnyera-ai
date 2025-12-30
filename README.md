# 🐰 BunnyEra AI

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](package.json)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()

> **BunnyEra AI** is an enterprise-grade AI SaaS platform featuring a modular architecture, multi-model gateway, and comprehensive automation workflows.

---

## 🏗️ Project Structure

The project follows a standard Node.js enterprise architecture:

```bash
bunnyera-ai/
├── foundation/          # 🏛️ Project Standards & Specifications (Naming, API, Security)
├── scripts/             # 🛠️ Automation Scripts (Deploy, Build, DB, Test)
├── gateway/             # 🚪 AI Model Gateway Service (OpenAI, Azure, Local)
├── controllers/         # 🎮 Business Logic Controllers
├── services/            # 🧠 Domain Services (Reusable Logic)
├── models/              # 📦 Database Models (Sequelize/SQLite)
├── routes/              # 🛣️ API Routes
├── middleware/          # 🛡️ Express Middleware (Auth, Logging)
├── logs/                # 📝 Application Logs
├── config/              # ⚙️ Configuration Files
├── tests/               # 🧪 Unit & Integration Tests
├── server.js            # 🚀 Application Entry Point
└── README.md            # 📘 Project Documentation
```

---

## 🏛️ Foundation Standards

We strictly follow the specifications defined in `foundation/`:

- **[Naming](foundation/naming.md)**: `camelCase` for JS, `PascalCase` for React.
- **[API Spec](foundation/api-spec.md)**: Standard REST envelope `{ code, data, message }`.
- **[Security](foundation/security.md)**: JWT Auth, BCrypt hashing, Helmet headers.
- **[Git Flow](foundation/git-standards.md)**: Feature branches -> Develop -> Main.
- **[Error Codes](foundation/error-codes.md)**: Standardized error handling (1000-5000).

---

## 🛠️ Scripts & Automation

All operational tasks are automated via `scripts/`:

| Script            | Description           | Usage                            |
| ----------------- | --------------------- | -------------------------------- |
| `deploy-prod.sh`  | Deploy to Production  | `./scripts/deploy-prod.sh`       |
| `deploy-dev.sh`   | Deploy to Development | `./scripts/deploy-dev.sh`        |
| `init-db.sh`      | Initialize Database   | `./scripts/init-db.sh`           |
| `backup-db.sh`    | Backup Database       | `./scripts/backup-db.sh`         |
| `restore-db.sh`   | Restore Database      | `./scripts/restore-db.sh <file>` |
| `health-check.sh` | Check Service Status  | `./scripts/health-check.sh`      |

---

## 🚀 Getting Started

### Prerequisites
- Node.js v18+
- Docker & Docker Compose
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-org/bunnyera-ai.git
   cd bunnyera-ai
   ```

2. **Install Dependencies**
   ```bash
   npm install
   ```

3. **Configure Environment**
   ```bash
   ./scripts/sync-env.sh
   # Edit .env file with your credentials
   ```

4. **Initialize Database**
   ```bash
   ./scripts/init-db.sh
   ```

### Running the App

- **Development Mode**
  ```bash
  npm run dev
  ```
- **Production Mode**
  ```bash
  npm run server
  ```

---

## 🌿 Git Flow

1. **Feature Development**:
   ```bash
   git checkout -b feat/new-login develop
   # ... work ...
   git commit -m "feat(auth): add login page"
   git push origin feat/new-login
   ```
2. **Pull Request**: Create PR to `develop`.
3. **Release**: Merge `develop` to `main` via Release PR.

---

## 🤝 Contribution

Please read [foundation/architecture-rules.md](foundation/architecture-rules.md) before contributing.
1. Fork the repo.
2. Create your feature branch.
3. Commit your changes.
4. Push to the branch.
5. Create a new Pull Request.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
