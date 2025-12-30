/**
 * BunnyEra Database Model Types
 */

// User Model
export interface User {
  id: number;
  username: string;
  email: string;
  password_hash: string;
  role: 'admin' | 'user' | 'guest';
  is_active: boolean;
  last_login_at?: Date;
  created_at: Date;
  updated_at: Date;
}

// Agent Model
export interface Agent {
  id: number;
  name: string;
  type: 'chat' | 'task' | 'vision' | 'coding';
  description?: string;
  status: 'idle' | 'running' | 'error' | 'offline';
  config: Record<string, any>; // JSON configuration
  created_by: number; // User ID
  created_at: Date;
  updated_at: Date;
}

// Log Model
export interface Log {
  id: number;
  level: 'info' | 'warn' | 'error' | 'debug';
  message: string;
  metadata?: Record<string, any>;
  source?: string;
  created_at: Date;
}

// Matrix Account Model
export interface MatrixAccount {
  id: number;
  user_id: number;
  matrix_user_id: string; // @user:matrix.org
  access_token?: string;
  device_id?: string;
  sync_token?: string;
  created_at: Date;
  updated_at: Date;
}
