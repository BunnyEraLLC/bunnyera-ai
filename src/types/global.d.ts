/**
 * BunnyEra Global Type Definitions
 */

declare global {
  namespace NodeJS {
    interface ProcessEnv {
      NODE_ENV: 'development' | 'production' | 'test';
      PORT: string;
      DB_HOST?: string;
      DB_USER?: string;
      DB_PASS?: string;
      DB_NAME?: string;
      JWT_SECRET: string;
      OPENAI_API_KEY?: string;
      AZURE_OPENAI_KEY?: string;
    }
  }

  // Extend Express Request to include User from Auth Middleware
  namespace Express {
    interface Request {
      user?: {
        id: number;
        username: string;
        role: 'admin' | 'user' | 'guest';
      };
      token?: string;
    }
  }
}

export {};
