# BunnyEra API Specifications

## 1. Response Format
All API responses must follow the standard envelope structure:

```json
{
  "code": 200,          // HTTP Status Code equivalent
  "message": "Success", // Human-readable message
  "data": { ... },      // The actual payload (object or array)
  "meta": {             // Optional metadata (pagination, etc.)
    "page": 1,
    "limit": 10,
    "total": 100
  },
  "timestamp": "2023-10-27T10:00:00Z"
}
```

## 2. Error Response Format
```json
{
  "code": 400,
  "message": "Invalid input parameters",
  "error": "VALIDATION_ERROR", // Internal error code
  "details": [                 // Optional detailed errors
    { "field": "email", "issue": "Invalid format" }
  ],
  "timestamp": "2023-10-27T10:00:00Z"
}
```

## 3. HTTP Methods
- `GET`: Retrieve resources (Safe, Idempotent)
- `POST`: Create new resources (Not Idempotent)
- `PUT`: Full update of a resource (Idempotent)
- `PATCH`: Partial update of a resource (Not Idempotent)
- `DELETE`: Remove a resource (Idempotent)

## 4. Versioning
- URL Versioning: `/api/v1/resource`
- Breaking changes require a new version (v2).
- Non-breaking changes (adding fields) do not require a new version.

## 5. Authentication
- Header: `Authorization: Bearer <token>`
- All protected routes must validate the JWT token.
