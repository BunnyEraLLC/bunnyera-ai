# BunnyEra Environment Standards

## 1. Environment Files
- `.env`: Default configuration (committed).
- `.env.local`: Local overrides (NOT committed).
- `.env.development`: Development specific.
- `.env.production`: Production specific.
- `.env.test`: Test specific.

## 2. Required Variables
The application must fail to start if these are missing:

```bash
# App
PORT=3000
NODE_ENV=development # development | production | test

# Database
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASS=secret
DB_NAME=bunnyera

# Security
JWT_SECRET=super_long_random_string
CORS_ORIGIN=http://localhost:5173

# AI Providers
OPENAI_API_KEY=sk-...
```

## 3. Accessing Variables
- Use `process.env.VAR_NAME` in Node.js.
- Use `import.meta.env.VITE_VAR_NAME` in Vite/Frontend (must be prefixed with `VITE_`).
- Never hardcode secrets in code!
