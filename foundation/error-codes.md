# BunnyEra Error Codes

## 1. System Codes (1000 - 1999)
| Code | Name                | Description             |
| ---- | ------------------- | ----------------------- |
| 1000 | SUCCESS             | Operation successful    |
| 1001 | SYSTEM_ERROR        | Internal server error   |
| 1002 | SERVICE_UNAVAILABLE | Service is down or busy |
| 1003 | TIMEOUT             | Request timed out       |

## 2. User/Auth Codes (2000 - 2999)
| Code | Name                | Description                |
| ---- | ------------------- | -------------------------- |
| 2000 | UNAUTHORIZED        | Authentication required    |
| 2001 | FORBIDDEN           | Insufficient permissions   |
| 2002 | INVALID_CREDENTIALS | Wrong username or password |
| 2003 | TOKEN_EXPIRED       | JWT token has expired      |
| 2004 | USER_NOT_FOUND      | User does not exist        |

## 3. Validation Codes (3000 - 3999)
| Code | Name             | Description                            |
| ---- | ---------------- | -------------------------------------- |
| 3000 | VALIDATION_ERROR | General validation failure             |
| 3001 | MISSING_FIELD    | Required field is missing              |
| 3002 | INVALID_FORMAT   | Field format is incorrect (e.g. email) |
| 3003 | DUPLICATE_ENTRY  | Resource already exists                |

## 4. AI Service Codes (4000 - 4999)
| Code | Name              | Description                 |
| ---- | ----------------- | --------------------------- |
| 4000 | AI_SERVICE_ERROR  | General AI provider error   |
| 4001 | QUOTA_EXCEEDED    | API usage limit reached     |
| 4002 | MODEL_NOT_FOUND   | Requested model unavailable |
| 4003 | GENERATION_FAILED | Failed to generate content  |
