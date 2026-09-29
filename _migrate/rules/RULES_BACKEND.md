# RULES_BACKEND.md

# FastAPI / Python 3.11 / SQLAlchemy 2.0 / Pydantic v2 / PostgreSQL

## Architecture rules (CRITICAL — never violate)

1. Router → Service → Repository → Database. Never skip or merge layers.
2. Routers: HTTP protocol only. Call service. Return response. Nothing else.
3. Services: business logic only. No FastAPI imports. No DB sessions directly.
4. Repositories: DB queries only. No business logic. No HTTP concepts.
5. Never import a repository directly in a router (go through service).

## FastAPI rules

1. Every endpoint has: `response_model`, `status_code`, `summary`, `tags`.
2. All endpoints are `async def`.
3. Dependency injection for everything: DB session, auth, permissions.
4. Use `HTTPException` with specific status codes. Never return error strings with 200.
5. Request body validation via Pydantic schemas — never `dict` or raw JSON.
6. Router files: one per resource domain (e.g. `routers/products.py`).

## Pydantic v2 rules

1. Schema naming: `ProductCreate`, `ProductRead`, `ProductUpdate`, `ProductList`.
2. All Read schemas: `model_config = ConfigDict(from_attributes=True)`.
3. Never expose: hashed passwords, internal state flags, system fields in Read schemas.
4. Use `Field(...)` with `description=` on all fields for OpenAPI documentation.
5. Use validators (`@field_validator`) for complex validation, not inline logic.

## SQLAlchemy 2.0 rules

1. Use `select()` statement style. Never `session.query()` (1.x style).
2. Use `Mapped[type]` and `mapped_column()` for all column definitions.
3. All sessions are async (`AsyncSession`). No sync sessions in async context.
4. Always `await session.commit()` after writes. Never auto-commit.
5. Use `selectinload()` or `joinedload()` to avoid N+1 queries on relationships.
6. Every model change → Alembic migration. Never modify DB schema manually.

## Python / clean code rules

1. Functions do one thing. If a function needs more than ~20 lines, split it.
2. No bare `except:`. Always catch specific exceptions.
3. No mutable default arguments (`def f(items=[])`). Use `None` + guard.
4. Type hints on every function signature (parameters + return type).
5. Docstrings on all public service and repository methods.
6. No magic numbers or strings — use constants or enums.
7. Max 200 lines per file. Split into modules if exceeded.

## SOLID principles (applied to Python)

- **S** — Each class has one reason to change. ProductService handles product logic only.
- **O** — Extend behavior via new classes/functions, not by editing existing ones.
- **L** — Subclasses must be substitutable for their base class.
- **I** — Don't force classes to depend on methods they don't use (small interfaces).
- **D** — Depend on abstractions. Inject repositories into services, don't instantiate inside.

## Security rules

1. Never log passwords, tokens, or PII.
2. Always hash passwords with `bcrypt` or `argon2`. Never store plain text.
3. Auth via JWT — validate on every protected endpoint via `Depends(get_current_user)`.
4. Never trust client-provided IDs for ownership checks — verify against current user.
5. CORS: explicit origins only. Never `allow_origins=["*"]` in production.

## Environment rules

1. All config via `pydantic-settings` `BaseSettings` class in `app/config.py`.
2. Never hardcode URLs, credentials, or secrets in source code.
3. Use `.env` for local dev. Document all variables in DOCS.md.
