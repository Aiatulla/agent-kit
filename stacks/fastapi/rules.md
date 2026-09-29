## FastAPI stack rules

Written for FastAPI 0.14x, Pydantic 2, SQLAlchemy 2.x (async), Alembic, PostgreSQL.
Mechanical rules (type hints, bare or blind `except`, mutable defaults, relative imports, hardcoded secrets, complexity) are enforced by `lint/ruff.toml`.

### Layers

- Request flow is router, then service, then repository, then database; never skip or merge a layer.
- Routers handle HTTP only: validate input, call a service, return the response.
  No business logic, no database access, no auth logic (use `Depends()`).
- Services hold business logic only: no FastAPI imports, no `Request`/`Response`, no direct session use; repositories are injected.
- Repositories hold database queries only: no business logic, no HTTP concepts; they return ORM objects or primitives.
- Routers never import repositories.
- One module per resource in each layer (`routers/`, `services/`, `repositories/`, `schemas/`, `models/`).

### Endpoints

- Every endpoint declares `response_model`, `status_code`, `summary`, and `tags`.
- Every endpoint is `async def`.
- Dependency injection for the database session, current user, and permissions.
- Errors raise `HTTPException` with a specific status code and detail; never an error payload with 200.
- Request bodies are Pydantic schemas, never `dict` or raw JSON.

### Schemas (Pydantic 2)

- Per resource: `<Name>Create`, `<Name>Read`, `<Name>Update`, `<Name>List`.
- Read schemas set `model_config = ConfigDict(from_attributes=True)`.
- Read schemas never expose password hashes, secrets, internal flags, or system fields.
- Every field uses `Field(..., description=...)` so the OpenAPI docs are complete.
- Complex validation lives in `@field_validator` / `@model_validator`, not inline.

### Models and queries (SQLAlchemy 2)

- 2.x style only: `select()` with `session.execute()` / `session.scalars()`; never `session.query()`.
- Columns use `Mapped[...]` and `mapped_column()`.
- Sessions are `AsyncSession`; never a sync session in async code.
- Writes end with an explicit `await session.commit()`; no autocommit.
- Load relationships with `selectinload()` or `joinedload()` to avoid N+1 queries.
- Every model inherits the project's `Base` with `id`, `created_at`, `updated_at`, and sets `__tablename__`.
- Relationships are declared on both sides with `back_populates`.
- Index every foreign key and every frequently filtered column.

### Migrations (Alembic)

- Every model change gets a migration: `alembic revision --autogenerate -m "<snake_case_description>"`, reviewed before it is applied.
- Never change the schema by hand, and never edit a migration that has been applied anywhere shared.
- Migrations must downgrade cleanly; there is exactly one head.

### Python

- A function longer than about 20 lines is doing more than one thing: split it.
- Public service and repository methods have docstrings.
- No magic numbers or strings: use constants or enums.

### Security and config

- Never log passwords, tokens, or personal data.
- Hash passwords with bcrypt or argon2.
- Protected endpoints validate the token through a dependency (for example `Depends(get_current_user)`).
- Ownership checks use the current user, never a client-provided ID alone.
- CORS lists explicit origins; never `allow_origins=["*"]` in production.
- All configuration comes from one `pydantic-settings` `BaseSettings` class; `.env` for local development, every variable documented.
