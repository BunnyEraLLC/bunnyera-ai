/**
 * BunnyEra API Type Definitions
 */

// Standard API Response Wrapper
export interface ApiResponse<T = any> {
  code: number;
  message: string;
  data: T;
  meta?: {
    page?: number;
    limit?: number;
    total?: number;
    [key: string]: any;
  };
  timestamp: string;
}

// Error Response
export interface ApiError {
  code: number;
  message: string;
  error: string;
  details?: Array<{
    field: string;
    issue: string;
  }>;
  timestamp: string;
}

// Common Query Parameters
export interface PaginationQuery {
  page?: number;
  limit?: number;
  sortBy?: string;
  order?: 'asc' | 'desc';
}

// Auth Types
export interface LoginResponse {
  token: string;
  user: {
    id: number;
    username: string;
    email: string;
    role: string;
  };
}
