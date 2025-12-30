# BunnyEra Security Policy

## 1. Authentication & Authorization
- Use **JWT** (JSON Web Tokens) for stateless authentication.
- Tokens must have an expiration time (e.g., 1 hour for access, 7 days for refresh).
- Passwords must be hashed using **bcrypt** or **Argon2** before storage. NEVER store plain text passwords.

## 2. Data Protection
- **HTTPS**: All traffic must be encrypted via TLS/SSL in production.
- **Sanitization**: All user input must be sanitized to prevent XSS (Cross-Site Scripting).
- **SQL Injection**: Use parameterized queries or ORM (Sequelize/Prisma) methods. Do not concatenate strings for SQL.

## 3. API Security
- **Rate Limiting**: Implement rate limiting to prevent DDoS and abuse.
- **CORS**: Restrict `Access-Control-Allow-Origin` to trusted domains only.
- **Headers**: Use Helmet.js to set secure HTTP headers (HSTS, No-Sniff, X-Frame-Options).

## 4. Dependency Management
- Regularly audit dependencies using `npm audit`.
- Update critical security patches immediately.
- Do not use abandoned packages.

## 5. Logging
- Do NOT log sensitive information (passwords, tokens, PII).
- Log failed login attempts for security monitoring.
