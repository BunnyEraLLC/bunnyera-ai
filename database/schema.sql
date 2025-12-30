-- BunnyEra Database Schema
-- Optimized for SQLite/PostgreSQL compatibility
-- Version: 1.0.0

-- Enable foreign keys (specifically for SQLite)
PRAGMA foreign_keys = ON;

-- ====================================================
-- Table: users
-- Description: Stores user account information
-- ====================================================
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY, -- Use INTEGER PRIMARY KEY AUTOINCREMENT for SQLite
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'user' CHECK (role IN ('admin', 'user', 'guest')),
    is_active BOOLEAN DEFAULT TRUE,
    last_login_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster lookup by email and username
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);

-- ====================================================
-- Table: agents
-- Description: AI Agents configuration and status
-- ====================================================
CREATE TABLE IF NOT EXISTS agents (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL, -- e.g., 'chat', 'task', 'vision'
    description TEXT,
    status VARCHAR(20) DEFAULT 'idle' CHECK (status IN ('idle', 'running', 'error', 'offline')),
    config JSONB, -- Stores agent-specific settings (use TEXT for SQLite)
    created_by INTEGER REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_agents_type ON agents(type);
CREATE INDEX idx_agents_status ON agents(status);

-- ====================================================
-- Table: matrix_accounts
-- Description: Linked Matrix protocol accounts
-- ====================================================
CREATE TABLE IF NOT EXISTS matrix_accounts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    matrix_user_id VARCHAR(255) NOT NULL, -- e.g., @user:matrix.org
    access_token TEXT, -- Encrypted storage recommended
    device_id VARCHAR(100),
    sync_token VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, matrix_user_id)
);

CREATE INDEX idx_matrix_user ON matrix_accounts(user_id);

-- ====================================================
-- Table: logs
-- Description: System and application logs
-- ====================================================
CREATE TABLE IF NOT EXISTS logs (
    id SERIAL PRIMARY KEY,
    level VARCHAR(10) NOT NULL CHECK (level IN ('info', 'warn', 'error', 'debug')),
    message TEXT NOT NULL,
    metadata JSONB, -- Additional context (use TEXT for SQLite)
    source VARCHAR(50), -- e.g., 'auth-service', 'payment-gateway'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_logs_level ON logs(level);
CREATE INDEX idx_logs_created_at ON logs(created_at);

-- ====================================================
-- Triggers (Optional - for updated_at automation)
-- Note: Syntax varies by DB. Below is PostgreSQL style.
-- For SQLite, use TRIGGER ... AFTER UPDATE ...
-- ====================================================
/*
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_users_modtime BEFORE UPDATE ON users FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_agents_modtime BEFORE UPDATE ON agents FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
*/
