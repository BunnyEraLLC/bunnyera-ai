# 🐇 BunnyEra AI — Enterprise Multi‑Agent Intelligence Engine
### BunnyEra LLC · 2025

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](package.json)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()

> **BunnyEra AI** is the core intelligence engine of the BunnyEra ecosystem, featuring a modular architecture, multi-model gateway, and comprehensive automation workflows.

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

## 🚀 Getting Started

### 1. Installation

```bash
git clone https://github.com/bunnyera-global/bunnyera-ai.git
cd bunnyera-ai
npm install
```

### 2. Configuration

Copy the example environment file:

```bash
cp .env.example .env
```

Edit `.env` with your API keys (OpenRouter, OpenAI, etc.).

### 3. Running the App

```bash
# Development Mode (Concurrent: Gateway + Server + Electron)
npm run dev

# Server Only
npm run server

# Web UI Only
npm run web
```

---

## 📘 Documentation

- [Foundation Standards](foundation/)
- [API Specifications](foundation/api-spec.md)
- [Automation Scripts](scripts/)

---

## 🤝 Contribution

Please follow the [Git Flow](foundation/git-standards.md) and [Coding Standards](foundation/naming.md).

## 📄 License

MIT
