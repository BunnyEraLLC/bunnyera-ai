# BunnyEra Architecture Rules

## 1. Architectural Pattern
- **MVC (Model-View-Controller)** for the backend API.
- **Component-Based** architecture for the frontend (React).
- **Gateway Pattern** for AI Model aggregation.

## 2. Backend Layers
1.  **Routes**: Define endpoints and map them to controllers.
2.  **Middleware**: Cross-cutting concerns (Auth, Logging, Validation).
3.  **Controllers**: Handle request/response logic.
4.  **Services**: Contain business logic (reusable).
5.  **Models**: Data access layer (Database interaction).
6.  **Utils/Helpers**: Pure functions and shared utilities.

## 3. Frontend Structure
1.  **Pages**: Top-level route components.
2.  **Components**: Reusable UI elements (Atoms, Molecules, Organisms).
3.  **Hooks**: Custom React hooks for logic reuse.
4.  **Context/Store**: Global state management.
5.  **Services/API**: API client wrappers.

## 4. Principles
- **DRY (Don't Repeat Yourself)**: Extract common logic.
- **KISS (Keep It Simple, Stupid)**: Avoid over-engineering.
- **Separation of Concerns**: Each module should have one responsibility.
- **Dependency Injection**: Use DI where possible to improve testability.
