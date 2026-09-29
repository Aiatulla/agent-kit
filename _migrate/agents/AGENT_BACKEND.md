# AGENT_BACKEND

# Stack: FastAPI, Python 3.11, SQLAlchemy 2.0, Pydantic v2, PostgreSQL

## Pre-flight (mandatory — do this before every task)

1. Read DOCS.md — understand the project and data model
2. Read rules/RULES_BACKEND.md — load all backend rules
3. Read output of scan-context.sh — know every existing model, schema, service
4. Apply Karpathy rules K1–K4 (see RULES_GENERAL.md) before every task
5. Never recreate a model, schema, service, or utility that already exists

## Architecture — strict layering (NEVER violate this)
```

Request → Router → Service → Repository → Database
↕
Schemas (Pydantic)

```

- **Router** (`app/routers/`): HTTP only. Validate input, call service, return response.
  No business logic. No direct DB access. No raw SQL.
- **Service** (`app/services/`): Business logic only. Calls repository. No HTTP context.
  No FastAPI Request/Response objects.
- **Repository** (`app/repositories/`): Database access only. SQLAlchemy queries.
  Returns ORM objects or primitives. No business logic.
- **Models** (`app/models/`): SQLAlchemy ORM models. Table definitions only.
- **Schemas** (`app/schemas/`): Pydantic v2 models. One file per domain.
  Separate Create / Read / Update / List schemas per resource.

## SQLAlchemy rules
- Always use SQLAlchemy 2.0 style (`select()`, `session.execute()`, async sessions)
- Define relationships explicitly with `relationship()` and `back_populates`
- Every model inherits from a `Base` with `id`, `created_at`, `updated_at`
- Never use `session.query()` — it is SQLAlchemy 1.x style
- Always create an Alembic migration after changing a model

## Pydantic v2 rules
- Use `model_config = ConfigDict(from_attributes=True)` on all Read schemas
- Never expose internal fields (hashed passwords, internal flags) in Read schemas
- Use `Field(...)` with descriptions for all fields — auto-generates OpenAPI docs
- Validate at the boundary: every endpoint has explicit request + response schemas

## FastAPI rules
- Every endpoint has: response_model, status_code, summary, tags
- Use dependency injection for DB session, current user, permissions
- Never put auth logic inside a route — use `Depends()`
- Error handling: raise `HTTPException` with specific status codes and detail messages
- All endpoints are async

## File structure
```

backend/app/
main.py ← FastAPI app init, router includes
database.py ← SQLAlchemy engine, session factory
models/
base.py ← Base class with id, created_at, updated_at
[resource].py ← one file per domain model
schemas/
[resource].py ← Create, Read, Update, List schemas per resource
routers/
[resource].py ← HTTP endpoints only
services/
[resource].py ← business logic
repositories/
[resource].py ← DB queries
dependencies/
auth.py ← get_current_user, require_role, etc.
db.py ← get_db session dependency

```

## Self-check before output
- [ ] Checked scan-context.sh for existing models/schemas/services?
- [ ] No business logic in router?
- [ ] No HTTP context in service?
- [ ] No direct DB calls in router?
- [ ] Pydantic schemas for every endpoint (request + response)?
- [ ] SQLAlchemy 2.0 style (`select()` not `query()`)?
- [ ] Alembic migration created if model changed?
- [ ] Every endpoint has response_model, status_code, summary, tags?
- [ ] SOLID principles followed?
