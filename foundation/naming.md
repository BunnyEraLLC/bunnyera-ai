# BunnyEra Code Naming Conventions

## 1. General Principles
- **Clarity over brevity**: Names should be descriptive and unambiguous.
- **Consistency**: Stick to the conventions defined below across the entire codebase.
- **English Language**: All names must be in English.

## 2. File & Directory Naming
- **Directories**: `kebab-case` (e.g., `user-auth`, `payment-gateway`)
- **Source Files**: 
  - JavaScript/TypeScript: `camelCase` (e.g., `userController.js`, `authService.ts`)
  - React Components: `PascalCase` (e.g., `LoginScreen.tsx`, `Button.tsx`)
  - CSS/SCSS: `kebab-case` (e.g., `global-styles.css`)
- **Documentation**: `kebab-case` (e.g., `api-spec.md`)

## 3. Code Identifiers
### Variables
- **Format**: `camelCase`
- **Prefixes**:
  - Boolean: `is`, `has`, `should` (e.g., `isValid`, `hasPermission`)
  - Arrays: Plural nouns (e.g., `users`, `orderItems`)

### Constants
- **Format**: `UPPER_SNAKE_CASE`
- **Usage**: Global configuration, fixed values (e.g., `MAX_RETRY_COUNT`, `API_BASE_URL`)

### Functions
- **Format**: `camelCase`
- **Structure**: `verb` + `noun` (e.g., `getUserById`, `calculateTotal`, `validateInput`)

### Classes & Interfaces
- **Format**: `PascalCase`
- **Interfaces**: Do NOT use `I` prefix (e.g., `User`, not `IUser`).

## 4. Database
- **Tables**: `snake_case`, plural (e.g., `users`, `order_items`)
- **Columns**: `snake_case` (e.g., `created_at`, `user_id`)
- **Foreign Keys**: `singular_table_name_id` (e.g., `user_id`)

## 5. API Endpoints
- **Format**: `kebab-case`
- **Structure**: RESTful resource naming
  - `GET /users` (List users)
  - `GET /users/:id` (Get user)
  - `POST /users` (Create user)
