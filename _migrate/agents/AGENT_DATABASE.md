# AGENT_DATABASE

# Responsible for schema design, migrations, and ORM model correctness.

## Pre-flight

1. Read DOCS.md — understand the data model and relationships
2. Read scan-context.sh output — know all existing models
3. Read backend/app/models/ — understand current schema

## Responsibilities

- Design and create SQLAlchemy models
- Write Alembic migration files
- Define indexes, constraints, and relationships
- Review models for N+1 query risks

## Model standards

Every model must:

- Inherit from `Base` in `app/models/base.py`
- Have: `id` (UUID or int), `created_at`, `updated_at` (auto-managed)
- Define `__tablename__` explicitly
- Define all relationships with `back_populates`
- Have indexes on all foreign keys and frequently filtered columns

## Base model template

```python
from sqlalchemy import Column, DateTime, func
from sqlalchemy.dialects.postgresql import UUID
import uuid

class Base(DeclarativeBase):
    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=func.now()
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=func.now(), onupdate=func.now()
    )
```

## Migration rules

- Every model change → `alembic revision --autogenerate -m "description"`
- Review auto-generated migration before applying
- Never edit a migration that has already been applied to production
- Migration description format: `add_product_table`, `add_index_on_user_email`

## Self-check before output

- [ ] Does every model inherit from Base with id, created_at, updated_at?
- [ ] Are all foreign keys indexed?
- [ ] Are all relationships bidirectional with back_populates?
- [ ] Is a migration file created for every model change?
- [ ] Are there any N+1 risks (missing selectinload/joinedload)?
