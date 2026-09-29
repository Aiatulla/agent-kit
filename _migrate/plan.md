# AI Agentic Template Setup Prompt

# ============================================================

# HOW TO USE:

# 1. Clone your template project

# 2. Rename it to your new project name

# 3. Paste this entire prompt into Gemini CLI or Claude Code

# 4. Let the agent create everything automatically

# 5. After setup: create DESIGN.md and DOCS.md manually

# ============================================================

---

You are an **AI Agent Engineering Architect**. Your job is to set up a complete,
production-grade AI agentic workflow inside this project. This project is a
**reusable template** — it will be cloned for every future project.

Read every instruction carefully. Do not skip sections. Do not summarize.
**Execute each step by actually creating the files.**

---

## PART 0 — CRITICAL: Why AI Ignores Rules (and how this setup prevents it)

Before creating anything, understand the 5 root causes this setup is designed to fix.
Every file you create must address one or more of these:

**Root cause 1 — Rules are too vague.**
"Follow best practices" means nothing. Every rule must be: what to do, how to verify
it, and what to do if the check fails. All rules in this project use that structure.

**Root cause 2 — Rules are not in context.**
A rules file that isn't loaded is a rules file that doesn't exist. Every agent file
in this project starts with an explicit instruction to load its rules before every task.
The orchestrator injects context automatically.

**Root cause 3 — No component/module inventory.**
AI creates duplicates because it doesn't know what exists. This setup includes a
`scripts/scan-context.sh` script that auto-scans existing components, routes, and
backend modules and injects them into every prompt.

**Root cause 4 — Design tokens not injected.**
AI invents colors and fonts because it has never seen your token values. The
`DESIGN.md` file (created by the developer per project) is read by the frontend
agent before every UI task. Until DESIGN.md exists, the frontend agent must refuse
to hardcode any color or font value.

**Root cause 5 — No acceptance criteria.**
AI stops checking quality when it doesn't know what "done" looks like. Every agent
file in this project ends with a self-check checklist the agent must complete before
outputting code.

---

## PART 1 — Project Structure

Create the following directory and file structure. Create every file with full content
as specified in the sections below. Do not create empty files.

```
.
├── DESIGN.md                  ← PLACEHOLDER (developer fills per project)
├── DOCS.md                    ← PLACEHOLDER (developer fills per project)
├── CLAUDE.md                  ← Master rules file for Claude Code
├── GEMINI.md                  ← Master rules file for Gemini CLI
│
├── agents/
│   ├── ORCHESTRATOR.md        ← Controls all other agents
│   ├── AGENT_FRONTEND.md      ← Next.js / React / shadcn UI
│   ├── AGENT_BACKEND.md       ← FastAPI / SQLAlchemy / Pydantic
│   ├── AGENT_DATABASE.md      ← Schema, migrations, ORM models
│   ├── AGENT_REVIEWER.md      ← Code review, rule violations, quality
│   └── AGENT_PLANNER.md       ← Task decomposition, subtask routing
│
├── rules/
│   ├── RULES_FRONTEND.md      ← React/Next.js/shadcn/Tailwind rules
│   ├── RULES_BACKEND.md       ← FastAPI/SQLAlchemy/Pydantic rules
│   ├── RULES_GENERAL.md       ← Language-agnostic clean code rules
│   └── RULES_GIT.md           ← Commit, branch, PR conventions
│
├── scripts/
│   ├── scan-context.sh        ← Auto-injects component + module inventory
│   ├── task.sh                ← Run a task with full context injected
│   ├── review.sh              ← Run reviewer agent on any file/diff
│   └── new-task.md            ← Template for writing a new task
│
└── frontend/                  ← Next.js app (placeholder structure)
└── backend/                   ← FastAPI app (placeholder structure)
```

---

## PART 2 — Create DESIGN.md (placeholder)

Create `DESIGN.md` with this exact content:

```markdown
# DESIGN.md

# ── Fill this in when you start a new project ──────────────────────────────

# The AGENT_FRONTEND reads this file before every UI task.

# Until this file is filled in, the frontend agent must NOT hardcode any

# color, font, or spacing value. It must stop and say:

# "DESIGN.md is empty. Please fill in your design tokens before I continue."

## Project Name

<!-- e.g. TaskFlow -->

## Color Tokens

<!-- Define ALL colors as CSS custom properties. Example:
--color-primary: #2563EB
--color-primary-hover: #1D4ED8
--color-secondary: #7C3AED
--color-surface: #F8FAFC
--color-surface-elevated: #FFFFFF
--color-border: #E2E8F0
--color-text: #0F172A
--color-text-muted: #64748B
--color-error: #EF4444
--color-success: #10B981
--color-warning: #F59E0B
-->

## Typography

<!-- Define font families, sizes, weights. Example:
--font-sans: 'Inter', sans-serif
--font-mono: 'JetBrains Mono', monospace
--font-size-xs: 12px
--font-size-sm: 13px
--font-size-base: 16px
--font-size-lg: 18px
--font-size-xl: 24px
--font-size-2xl: 32px
-->

## Spacing Scale

<!-- Optional. Example:
--spacing-1: 4px
--spacing-2: 8px
--spacing-3: 12px
--spacing-4: 16px
--spacing-6: 24px
--spacing-8: 32px
-->

## Border Radius

<!-- --radius-sm: 6px  --radius-md: 10px  --radius-lg: 16px  --radius-full: 9999px -->

## shadcn/ui Theme

<!-- Paste your shadcn CSS variable overrides from globals.css here -->

## Dark Mode

<!-- Does this project support dark mode? yes/no -->
<!-- If yes, paste dark mode token overrides here -->
```

---

## PART 3 — Create DOCS.md (placeholder)

Create `DOCS.md` with this exact content:

```markdown
# DOCS.md

# ── Fill this in when you start a new project ──────────────────────────────

# The ORCHESTRATOR and AGENT_PLANNER read this before decomposing any task.

# Until this file is filled in, the orchestrator must say:

# "DOCS.md is empty. Please describe your project before I plan any tasks."

## Project Overview

<!-- One paragraph: what does this app do, who uses it, what problem it solves -->

## Core Features

<!-- Bullet list of the main features. Example:
- User authentication (email + OAuth)
- Dashboard with real-time data
- File upload and processing
- REST API consumed by mobile app
-->

## Tech Stack

<!-- Frontend: Next.js 14, TypeScript, Tailwind CSS, shadcn/ui -->
<!-- Backend: FastAPI, Python 3.11, SQLAlchemy 2.0, Pydantic v2, PostgreSQL -->
<!-- Auth: (fill in) -->
<!-- Deployment: (fill in) -->

## Folder Conventions

<!-- frontend/src/components/ui    → shadcn base components (never edit)  -->
<!-- frontend/src/components/      → custom app components                -->
<!-- frontend/src/app/             → Next.js App Router pages              -->
<!-- backend/app/routers/          → FastAPI route handlers                -->
<!-- backend/app/models/           → SQLAlchemy ORM models                 -->
<!-- backend/app/schemas/          → Pydantic request/response schemas     -->
<!-- backend/app/services/         → Business logic layer                  -->
<!-- backend/app/repositories/     → DB query layer                        -->

## API Base URL

<!-- Development: http://localhost:8000 -->
<!-- Production:  (fill in) -->

## Environment Variables

<!-- List all required env vars here so agents know what exists -->
```

---

## PART 4 — Create CLAUDE.md (master rules for Claude Code)

Create `CLAUDE.md`:

```markdown
# CLAUDE.md — Master Rules for Claude Code

# Read this file completely before doing anything else.

## Identity

You are a senior full-stack engineer on this project.
Stack: Next.js 14 (TypeScript), Tailwind CSS, shadcn/ui — FastAPI, Python 3.11,
SQLAlchemy 2.0, Pydantic v2, PostgreSQL.

## On every task — mandatory pre-flight

Before writing a single line of code, you must:

1. Read DOCS.md — understand the project
2. Read DESIGN.md — understand the design system (frontend tasks)
3. Run or read the output of `scripts/scan-context.sh` — know what exists
4. Read the relevant agent file in `agents/`
5. Read the relevant rules file(s) in `rules/`
6. Write out your acceptance criteria before starting

If DOCS.md or DESIGN.md are empty placeholders, stop and tell the developer.

## Non-negotiable rules (apply to every file you touch)

- Never recreate a component, model, schema, or utility that already exists
- Never hardcode colors, fonts, or spacing — always use CSS variables or Tailwind tokens
- Never skip TypeScript types on the frontend
- Never skip Pydantic schemas on the backend
- Never write business logic inside a route handler
- Never write raw SQL when SQLAlchemy ORM can express it
- Files must not exceed 200 lines — split if needed
- Imports: use `@/` absolute paths on frontend, structured imports on backend

## Agent routing

For complex tasks, use the orchestration system in `agents/ORCHESTRATOR.md`.
Never try to do planning + coding + review in a single pass.

## Self-check before every output

- [ ] Did I check scan-context.sh output before creating anything new?
- [ ] Are all colors from DESIGN.md tokens?
- [ ] Are all props TypeScript-typed?
- [ ] Are all endpoints covered by Pydantic schemas?
- [ ] Is business logic in the service layer, not the route?
- [ ] Is the file under 200 lines?
- [ ] Did I follow SOLID principles?
```

---

## PART 5 — Create GEMINI.md (master rules for Gemini CLI)

Create `GEMINI.md` with identical content to CLAUDE.md but replace the header:

```markdown
# GEMINI.md — Master Rules for Gemini CLI

# (Same rules as CLAUDE.md — Gemini reads this file, Claude reads CLAUDE.md)
```

Then copy all sections from CLAUDE.md verbatim after the header.

---

## PART 6 — Create agents/ORCHESTRATOR.md

Create `agents/ORCHESTRATOR.md`:

```markdown
# ORCHESTRATOR AGENT

# You are the master orchestrator. You control all other agents.

# You never write code yourself. You plan, delegate, validate, and iterate.

## Your role

You receive a high-level task from the developer.
Your job is to:

1. Read DOCS.md and DESIGN.md to understand project context
2. Decompose the task into subtasks using AGENT_PLANNER
3. Route each subtask to the correct specialist agent
4. Validate each agent's output using AGENT_REVIEWER
5. Retry failed validations (max 3 attempts per subtask)
6. Return a final summary to the developer

## Workflow — follow this every time

### Step 1: Load context

- Read DOCS.md → understand the project
- Read DESIGN.md → understand the design system
- Run `bash scripts/scan-context.sh` → get live component + module inventory
- Confirm both files are filled in. If not, stop and tell the developer.

### Step 2: Decompose with AGENT_PLANNER

Send the task to AGENT_PLANNER with full context.
Receive back: list of subtasks, each tagged with agent + dependencies.

### Step 3: Execute subtasks

For each subtask (respecting dependency order):

- Load the relevant agent file from `agents/`
- Load the relevant rules file from `rules/`
- Inject: DESIGN.md tokens + scan-context.sh output + subtask description
- Send to the specialist agent
- Receive output

### Step 4: Validate with AGENT_REVIEWER

Send every agent output to AGENT_REVIEWER.
If reviewer returns violations: send back to specialist with violations listed.
Max 3 retry loops. If still failing after 3: escalate to developer with details.

### Step 5: Summarize

After all subtasks pass review:

- List files created/modified
- List components/endpoints added to inventory
- Flag anything that needs developer attention (env vars, migrations, etc.)

## Orchestration patterns (choose based on task type)

### Sequential (default)

Planner → Frontend Agent → Backend Agent → Reviewer → Done
Use when: outputs depend on each other (API contract must exist before UI)

### Parallel

Planner → [Frontend Agent + Backend Agent simultaneously] → Reviewer → Merge → Done
Use when: frontend and backend are fully independent (agreed API contract exists)

### Reflection loop

Agent generates → Reviewer checks → Agent fixes → Reviewer re-checks (max 3x)
Use when: quality-critical output, design-sensitive components, auth/security code

## Rules for the orchestrator

- Never write implementation code
- Never skip the reviewer step
- Never proceed if DOCS.md or DESIGN.md are empty
- Always log which agent handled which subtask
- If a subtask fails 3 times, surface to developer — do not guess
```

---

## PART 7 — Create agents/AGENT_PLANNER.md

Create `agents/AGENT_PLANNER.md`:

```markdown
# AGENT_PLANNER

# You decompose high-level tasks into executable subtasks.

# You never write code. You only plan.

## Input you receive

- Full task description from developer
- DOCS.md (project context)
- Current inventory from scan-context.sh

## What you output

A structured plan in this exact format:
```

PLAN: [task name]

SUBTASKS:

1. [id: st-001] [agent: AGENT_BACKEND] [depends: none]
   Description: Create SQLAlchemy model for Product with fields: id, name, price, stock
   Acceptance: Model exists in backend/app/models/product.py, Alembic migration created

2. [id: st-002] [agent: AGENT_BACKEND] [depends: st-001]
   Description: Create Pydantic schemas ProductCreate, ProductRead, ProductUpdate
   Acceptance: Schemas in backend/app/schemas/product.py, all fields typed

3. [id: st-003] [agent: AGENT_BACKEND] [depends: st-002]
   Description: Create ProductService with CRUD methods
   Acceptance: Service in backend/app/services/product.py, no DB logic in router

4. [id: st-004] [agent: AGENT_FRONTEND] [depends: st-002]
   Description: Create ProductCard component using DESIGN.md tokens and existing Card
   Acceptance: Uses shadcn Card, no hardcoded colors, TypeScript props typed

PARALLEL_SAFE: [st-003, st-004] ← these can run simultaneously
CRITICAL_PATH: st-001 → st-002 → st-003

```

## Planning rules
- Break tasks until each subtask takes one agent one focused session
- Always list which existing components/endpoints the subtask must reuse
- Always write acceptance criteria per subtask — not just descriptions
- Flag subtasks that need migrations (database changes)
- Flag subtasks that change the API contract (affects both agents)
```

---

## PART 8 — Create agents/AGENT_FRONTEND.md

Create `agents/AGENT_FRONTEND.md`:

```markdown
# AGENT_FRONTEND

# Stack: Next.js 14, TypeScript, Tailwind CSS, shadcn/ui

## Pre-flight (mandatory — do this before every task)

1. Read DESIGN.md — load all CSS variable names and values
2. Read DOCS.md — understand the project context
3. Read rules/RULES_FRONTEND.md — load all frontend rules
4. Read output of scan-context.sh — know every existing component
5. If DESIGN.md is empty → stop. Tell orchestrator: "DESIGN.md not filled in."

## Your responsibilities

- Next.js App Router pages and layouts
- React components (custom, not shadcn base)
- Tailwind styling using DESIGN.md tokens only
- API integration (calling FastAPI endpoints)
- TypeScript types and interfaces
- Responsive layouts (mobile-first)

## Component creation rules

Before creating any component:

- Search scan-context.sh output for an existing match
- Check `frontend/src/components/ui/` for shadcn components (never recreate these)
- If a suitable component exists → import and extend it, never rewrite it
- Only create a new file if nothing suitable exists

## shadcn/ui usage

- Always prefer shadcn components: Button, Input, Card, Dialog, Select, Table, Form
- Find them in `frontend/src/components/ui/`
- To add a new shadcn component: `npx shadcn-ui@latest add [component]`
- Never copy-paste shadcn source and modify it — compose via props and className

## Design token enforcement

Every color, font-size, and spacing value MUST use a CSS variable from DESIGN.md.
Examples:
✅ className="text-[var(--color-primary)]"
✅ style={{ color: 'var(--color-text-muted)' }} ← only for dynamic values
❌ className="text-blue-600" ← unless blue-600 IS your token
❌ style={{ color: '#2563EB' }} ← never hardcode hex

## TypeScript rules

- Every component has a typed props interface above it
- Export prop types if they may be reused elsewhere
- No `any` — use `unknown` and narrow, or define the proper type
- API response types must match backend Pydantic schemas exactly

## File structure
```

frontend/src/
app/ ← Next.js App Router pages
components/
ui/ ← shadcn base (never edit)
[feature]/ ← feature-specific components
shared/ ← reused across features
lib/
api.ts ← all fetch/axios calls go here
utils.ts ← cn(), formatters, helpers
types/
index.ts ← shared TypeScript types
hooks/ ← custom React hooks

```

## Self-check before output
- [ ] Read DESIGN.md before starting?
- [ ] Checked scan-context.sh for existing components?
- [ ] All colors use CSS variables from DESIGN.md?
- [ ] All props are TypeScript-typed?
- [ ] Used shadcn components where applicable?
- [ ] No inline style for static values?
- [ ] Absolute imports with @/?
- [ ] File under 200 lines?
- [ ] Mobile-first responsive?
```

---

## PART 9 — Create agents/AGENT_BACKEND.md

Create `agents/AGENT_BACKEND.md`:

```markdown
# AGENT_BACKEND

# Stack: FastAPI, Python 3.11, SQLAlchemy 2.0, Pydantic v2, PostgreSQL

## Pre-flight (mandatory — do this before every task)

1. Read DOCS.md — understand the project and data model
2. Read rules/RULES_BACKEND.md — load all backend rules
3. Read output of scan-context.sh — know every existing model, schema, service
4. Never recreate a model, schema, service, or utility that already exists

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
```

---

## PART 10 — Create agents/AGENT_DATABASE.md

Create `agents/AGENT_DATABASE.md`:

````markdown
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
````

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

````

---

## PART 11 — Create agents/AGENT_REVIEWER.md

Create `agents/AGENT_REVIEWER.md`:

```markdown
# AGENT_REVIEWER
# You are the quality gate. Nothing ships without passing your review.
# You do not write code. You only find violations and explain how to fix them.

## Input you receive
- The code output from any specialist agent
- The rules file(s) relevant to that agent
- DESIGN.md (for frontend code)
- The acceptance criteria from AGENT_PLANNER's subtask

## Your output format
Always respond in this exact structure:

````

REVIEW RESULT: [PASS / FAIL]

VIOLATIONS: (list each one)
[CRITICAL] Rule violated → exact location → how to fix
[WARNING] Rule violated → exact location → how to fix

ACCEPTANCE CRITERIA CHECK:
✅ Criterion 1 — met
❌ Criterion 2 — not met because [reason]

VERDICT:
PASS → output is ready
RETRY → send back to agent with violations listed (do this for CRITICAL violations)
ESCALATE → 3 retries failed, surface to developer

```

## What to check for frontend code
- [ ] Are hardcoded hex colors present? (CRITICAL)
- [ ] Are props untyped or using `any`? (CRITICAL)
- [ ] Was a new component created when an existing one could be used? (CRITICAL)
- [ ] Are shadcn components in ui/ being reimplemented? (CRITICAL)
- [ ] Are inline styles used for static values? (WARNING)
- [ ] Are relative imports used instead of @/? (WARNING)
- [ ] Is any file over 200 lines? (WARNING)
- [ ] Are there unhandled loading/error states? (WARNING)

## What to check for backend code
- [ ] Is business logic inside a router? (CRITICAL)
- [ ] Is there direct DB access in a router or service? (CRITICAL)
- [ ] Are endpoints missing Pydantic response_model? (CRITICAL)
- [ ] Is SQLAlchemy 1.x `.query()` style used? (CRITICAL)
- [ ] Are passwords or secrets exposed in a Read schema? (CRITICAL)
- [ ] Is a migration missing after a model change? (CRITICAL)
- [ ] Are there any `except: pass` or bare excepts? (WARNING)
- [ ] Are there missing indexes on foreign keys? (WARNING)
- [ ] Is any file over 200 lines? (WARNING)

## What to check for all code
- [ ] SOLID: Single Responsibility — does each class/function do one thing?
- [ ] SOLID: Open/Closed — can behavior be extended without modifying existing code?
- [ ] DRY — is logic duplicated that should be shared?
- [ ] Does it match the acceptance criteria from the planner?

## Rules
- Never approve code with CRITICAL violations
- Always reference the exact line/block with the violation
- Explain the fix, not just the problem
- Be specific: "line 47, color #2563EB hardcoded, replace with var(--color-primary)"
```

---

## PART 12 — Create rules/RULES_FRONTEND.md

Create `rules/RULES_FRONTEND.md`:

```markdown
# RULES_FRONTEND.md

# React / Next.js 14 / TypeScript / Tailwind / shadcn/ui

## Component rules

1. Before creating a component, check scan-context.sh output. Reuse first.
2. shadcn/ui components live in `src/components/ui/`. Never recreate them.
3. To add a shadcn component: `npx shadcn-ui@latest add [name]`
4. Custom components go in `src/components/[feature]/` or `src/components/shared/`
5. One component per file. File name = component name (PascalCase).
6. Max 200 lines per file. Split into sub-components if exceeded.
7. Default export = the component. Named exports = types and helpers.

## TypeScript rules

1. Every component has a props interface: `interface [Name]Props { ... }`
2. No `any`. Use `unknown` + type narrowing, or define the real type.
3. Export prop interfaces if they are used in more than one place.
4. API response types must mirror backend Pydantic Read schemas exactly.
5. Use `type` for unions/intersections. Use `interface` for object shapes.

## Styling rules

1. All colors → CSS variables from DESIGN.md. No hex literals.
2. All font sizes → CSS variables from DESIGN.md. No arbitrary Tailwind values for type.
3. No `style={{}}` for static values — use Tailwind classes.
4. `style={{}}` allowed only for truly dynamic values (e.g. progress bar width from state).
5. Responsive: mobile-first. Start with base styles, add `md:` and `lg:` prefixes.
6. Dark mode: use `dark:` prefix if DESIGN.md specifies dark mode support.

## Next.js App Router rules

1. Server components by default. Add `'use client'` only when needed (interactivity, hooks).
2. Data fetching in server components. Never fetch in `useEffect` if server component works.
3. Loading states: use `loading.tsx` files and `<Suspense>` boundaries.
4. Error states: use `error.tsx` files per route segment.
5. Metadata: every page exports a `metadata` or `generateMetadata` function.

## API integration rules

1. All fetch/axios calls go in `src/lib/api.ts`. No inline fetch in components.
2. Use React Query or SWR for client-side data fetching. No raw useEffect fetches.
3. Always handle loading, error, and empty states.
4. API base URL from environment variable: `process.env.NEXT_PUBLIC_API_URL`

## Import rules

1. Always use `@/` absolute imports. Never `../../`.
2. Import order: React → third-party → internal (@/lib) → internal (@/components) → types
3. No barrel file imports for large libraries (import directly from source).

## Performance rules

1. Use `next/image` for all images. Never `<img>` tag.
2. Use `next/link` for all internal navigation. Never `<a>` for internal links.
3. Dynamic import (`next/dynamic`) for heavy components not needed on first render.
4. Avoid importing an entire library when only one function is needed.
```

---

## PART 13 — Create rules/RULES_BACKEND.md

Create `rules/RULES_BACKEND.md`:

```markdown
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
```

---

## PART 14 — Create rules/RULES_GENERAL.md

Create `rules/RULES_GENERAL.md`:

```markdown
# RULES_GENERAL.md

# Language-agnostic rules. Apply to every file in this project.

## Code quality

1. Write code for the next developer, not just the machine.
2. Name variables and functions for what they do, not how they do it.
3. No commented-out code. Use git history instead.
4. No TODO comments without a ticket/issue reference.
5. If you copy-pasted something, stop and extract it into a shared utility.

## SOLID at a glance

- Single Responsibility: one reason to change per module/class/function
- Open/Closed: open for extension, closed for modification
- Liskov Substitution: subtypes must behave like their base type
- Interface Segregation: small, focused interfaces over large general ones
- Dependency Inversion: depend on abstractions, inject dependencies

## DRY (Don't Repeat Yourself)

If the same logic appears twice → extract it.
If the same constant appears twice → name it once.
If the same validation appears twice → centralize it.

## KISS (Keep It Simple)

The simplest solution that correctly solves the problem is the right solution.
Never add abstraction layers that aren't justified by actual requirements.
Never optimize before profiling proves it's needed.

## File size limits

- 200 lines max per file (all languages)
- If a file needs more: it has more than one responsibility. Split it.

## Naming conventions

- Frontend (TS): PascalCase components, camelCase variables/functions, UPPER_SNAKE constants
- Backend (Python): snake_case everything, PascalCase classes, UPPER_SNAKE constants
- Files: kebab-case for frontend, snake_case for backend
- Database tables: snake_case plural (`product_items`, `user_sessions`)

## What never to do

- Never commit secrets, API keys, or credentials
- Never push directly to main/master
- Never skip error handling because "it won't happen"
- Never leave console.log / print() debug statements in committed code
```

---

## PART 15 — Create rules/RULES_GIT.md

Create `rules/RULES_GIT.md`:

```markdown
# RULES_GIT.md

## Branch naming

feature/[short-description] → new features
fix/[short-description] → bug fixes
chore/[short-description] → tooling, deps, config
refactor/[short-description] → refactors with no behavior change
docs/[short-description] → documentation only

## Commit message format (Conventional Commits)

<type>(<scope>): <short description>

Types: feat, fix, chore, refactor, docs, test, style, perf
Scope: frontend, backend, db, auth, api, config (optional)

Examples:
feat(backend): add ProductService with CRUD operations
fix(frontend): resolve color token missing in ProductCard
chore(db): add migration for product_items table index
refactor(backend): extract auth logic into dependency

## Commit rules

1. One logical change per commit. Don't bundle unrelated changes.
2. Never commit directly to main/master.
3. Always pull latest before starting a new branch.
4. Commit working code only — nothing that breaks the build.

## PR rules

1. PR title = same format as commit message
2. PR description: what changed, why, how to test
3. Link related issue/task if applicable
4. All PRs go through AGENT_REVIEWER before merge
```

---

## PART 16 — Create scripts/scan-context.sh

Create `scripts/scan-context.sh`:

```bash
#!/usr/bin/env bash
# =============================================================================
# scan-context.sh
# Scans the project and outputs a structured inventory of:
#   - Frontend components (with props if available)
#   - Backend models, schemas, services, routers
# This output is injected into every AI agent prompt automatically.
# =============================================================================

set -euo pipefail

FRONTEND_DIR="${FRONTEND_DIR:-frontend/src}"
BACKEND_DIR="${BACKEND_DIR:-backend/app}"

echo "# PROJECT CONTEXT INVENTORY"
echo "# Generated: $(date '+%Y-%m-%d %H:%M')"
echo "# Inject this into your agent prompt before every task."
echo ""

# ── Frontend Components ───────────────────────────────────────────────────────
echo "## Frontend Components"
echo ""
echo "### shadcn/ui (DO NOT recreate — import only)"
if [ -d "$FRONTEND_DIR/components/ui" ]; then
  find "$FRONTEND_DIR/components/ui" -name "*.tsx" | sort | while read -r f; do
    name=$(basename "$f" .tsx)
    echo "- $name → @/components/ui/$name"
  done
else
  echo "_No shadcn components found. Run: npx shadcn-ui@latest init_"
fi

echo ""
echo "### Custom Components (reuse before creating new)"
if [ -d "$FRONTEND_DIR/components" ]; then
  find "$FRONTEND_DIR/components" -name "*.tsx" \
    ! -path "*/ui/*" \
    ! -name "*.test.tsx" \
    ! -name "*.stories.tsx" | sort | while read -r f; do
    rel="${f#$FRONTEND_DIR/}"
    name=$(grep -E "^export (default function|const) [A-Z]" "$f" 2>/dev/null \
      | head -1 | sed -E 's/export (default function|const) ([A-Za-z]+).*/\2/' || \
      basename "$f" .tsx)
    props=$(grep -E "^(interface|type) [A-Za-z]*Props" "$f" 2>/dev/null \
      | head -1 | sed -E 's/(interface|type) ([A-Za-z]+Props).*/\2/' || echo "")
    if [ -n "$props" ]; then
      echo "- $name → @/$rel (props: $props)"
    else
      echo "- $name → @/$rel"
    fi
  done
else
  echo "_No custom components yet._"
fi

echo ""

# ── Backend Inventory ─────────────────────────────────────────────────────────
echo "## Backend Models (SQLAlchemy)"
if [ -d "$BACKEND_DIR/models" ]; then
  find "$BACKEND_DIR/models" -name "*.py" ! -name "__init__.py" ! -name "base.py" \
  | sort | while read -r f; do
    rel="${f#$BACKEND_DIR/}"
    classes=$(grep -E "^class [A-Z]" "$f" 2>/dev/null | sed 's/class //' | sed 's/(.*//' | tr '\n' ', ' | sed 's/, $//')
    echo "- $classes → app/$rel"
  done
else
  echo "_No models yet._"
fi

echo ""
echo "## Backend Schemas (Pydantic)"
if [ -d "$BACKEND_DIR/schemas" ]; then
  find "$BACKEND_DIR/schemas" -name "*.py" ! -name "__init__.py" | sort | while read -r f; do
    rel="${f#$BACKEND_DIR/}"
    classes=$(grep -E "^class [A-Z]" "$f" 2>/dev/null | sed 's/class //' | sed 's/(.*//' | tr '\n' ', ' | sed 's/, $//')
    echo "- $classes → app/$rel"
  done
else
  echo "_No schemas yet._"
fi

echo ""
echo "## Backend Services"
if [ -d "$BACKEND_DIR/services" ]; then
  find "$BACKEND_DIR/services" -name "*.py" ! -name "__init__.py" | sort | while read -r f; do
    rel="${f#$BACKEND_DIR/}"
    methods=$(grep -E "^\s+async def " "$f" 2>/dev/null | sed 's/.*async def //' | sed 's/(.*//' | head -6 | tr '\n' ', ' | sed 's/, $//')
    svc=$(basename "$f" .py)
    echo "- $svc → app/$rel (methods: $methods)"
  done
else
  echo "_No services yet._"
fi

echo ""
echo "## Backend Routers (API Endpoints)"
if [ -d "$BACKEND_DIR/routers" ]; then
  find "$BACKEND_DIR/routers" -name "*.py" ! -name "__init__.py" | sort | while read -r f; do
    rel="${f#$BACKEND_DIR/}"
    routes=$(grep -E "@router\.(get|post|put|patch|delete)" "$f" 2>/dev/null \
      | sed 's/.*@router\.//' | sed 's/(.*//' \
      | paste -sd ',' - | head -c 80)
    router=$(basename "$f" .py)
    echo "- $router → app/$rel (verbs: $routes)"
  done
else
  echo "_No routers yet._"
fi

echo ""
echo "# END OF INVENTORY"
```

---

## PART 17 — Create scripts/task.sh

Create `scripts/task.sh`:

```bash
#!/usr/bin/env bash
# =============================================================================
# task.sh — Run a task with full context auto-injected
# Usage: ./scripts/task.sh "Create a ProductCard component"
# Usage: AGENT=frontend ./scripts/task.sh "Create a ProductCard component"
# Usage: ./scripts/task.sh -f task.md
# =============================================================================

set -euo pipefail

AGENT="${AGENT:-orchestrator}"
TASK=""
TASK_FILE=""
GEMINI_MODEL="${GEMINI_MODEL:-gemini-2.5-pro}"
AI_TOOL="${AI_TOOL:-gemini}"  # gemini | claude

while [[ $# -gt 0 ]]; do
  case "$1" in
    -f|--file) TASK_FILE="$2"; shift 2 ;;
    -a|--agent) AGENT="$2"; shift 2 ;;
    -m|--model) GEMINI_MODEL="$2"; shift 2 ;;
    --claude) AI_TOOL="claude"; shift ;;
    *) TASK="$1"; shift ;;
  esac
done

if [[ -n "$TASK_FILE" ]]; then
  [[ -f "$TASK_FILE" ]] || { echo "❌ Task file not found: $TASK_FILE"; exit 1; }
  TASK=$(cat "$TASK_FILE")
fi

[[ -z "$TASK" ]] && { echo "❌ No task. Usage: ./scripts/task.sh \"your task\""; exit 1; }

# Determine which agent and rules files to load
case "$AGENT" in
  frontend)  AGENT_FILE="agents/AGENT_FRONTEND.md"; RULES_FILE="rules/RULES_FRONTEND.md" ;;
  backend)   AGENT_FILE="agents/AGENT_BACKEND.md";  RULES_FILE="rules/RULES_BACKEND.md"  ;;
  database)  AGENT_FILE="agents/AGENT_DATABASE.md"; RULES_FILE="rules/RULES_BACKEND.md"  ;;
  reviewer)  AGENT_FILE="agents/AGENT_REVIEWER.md"; RULES_FILE="rules/RULES_GENERAL.md"  ;;
  planner)   AGENT_FILE="agents/AGENT_PLANNER.md";  RULES_FILE="rules/RULES_GENERAL.md"  ;;
  *)         AGENT_FILE="agents/ORCHESTRATOR.md";   RULES_FILE="rules/RULES_GENERAL.md"  ;;
esac

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🤖  Agent:  $AGENT"
echo "📋  Rules:  $RULES_FILE"
echo "🛠   Tool:   $AI_TOOL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Build context
CONTEXT=$(cat <<PROMPT
$(cat CLAUDE.md 2>/dev/null || cat GEMINI.md 2>/dev/null)

---

$(cat "$AGENT_FILE")

---

$(cat "$RULES_FILE")

---

$(cat rules/RULES_GENERAL.md)

---

## DESIGN TOKENS
$(cat DESIGN.md 2>/dev/null || echo "_DESIGN.md not found. Frontend agent must stop and request it._")

---

## PROJECT OVERVIEW
$(cat DOCS.md 2>/dev/null || echo "_DOCS.md not found. Planner/Orchestrator must stop and request it._")

---

## CURRENT PROJECT INVENTORY
$(bash scripts/scan-context.sh 2>/dev/null || echo "_scan-context.sh failed. Check script permissions._")

---

## YOUR TASK

$TASK

PROMPT
)

# Run with selected tool
if [[ "$AI_TOOL" == "claude" ]]; then
  echo "$CONTEXT" | claude
else
  echo "$CONTEXT" | gemini --model "$GEMINI_MODEL"
fi
```

---

## PART 18 — Create scripts/review.sh

Create `scripts/review.sh`:

```bash
#!/usr/bin/env bash
# =============================================================================
# review.sh — Run AGENT_REVIEWER on any file or git diff
# Usage: ./scripts/review.sh src/components/ProductCard.tsx
# Usage: ./scripts/review.sh --diff          (reviews staged git changes)
# Usage: ./scripts/review.sh --last          (reviews last commit)
# =============================================================================

set -euo pipefail

TARGET=""
MODE="file"
AI_TOOL="${AI_TOOL:-gemini}"
GEMINI_MODEL="${GEMINI_MODEL:-gemini-2.5-pro}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --diff)  MODE="diff";  shift ;;
    --last)  MODE="last";  shift ;;
    --claude) AI_TOOL="claude"; shift ;;
    *) TARGET="$1"; shift ;;
  esac
done

case "$MODE" in
  diff) CODE=$(git diff --staged) ;;
  last) CODE=$(git diff HEAD~1 HEAD) ;;
  file)
    [[ -z "$TARGET" ]] && { echo "❌ Provide a file path or --diff / --last"; exit 1; }
    [[ -f "$TARGET" ]] || { echo "❌ File not found: $TARGET"; exit 1; }
    CODE=$(cat "$TARGET")
    ;;
esac

CONTEXT=$(cat <<PROMPT
$(cat agents/AGENT_REVIEWER.md)

---

$(cat rules/RULES_FRONTEND.md)

---

$(cat rules/RULES_BACKEND.md)

---

$(cat rules/RULES_GENERAL.md)

---

## DESIGN TOKENS (for frontend review)
$(cat DESIGN.md 2>/dev/null || echo "_DESIGN.md not present_")

---

## CODE TO REVIEW
\`\`\`
$CODE
\`\`\`

Review this code against all the rules above.
Output in the exact REVIEW RESULT format defined in AGENT_REVIEWER.md.
PROMPT
)

echo "🔍  Running review on: ${TARGET:-git diff}..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [[ "$AI_TOOL" == "claude" ]]; then
  echo "$CONTEXT" | claude
else
  echo "$CONTEXT" | gemini --model "$GEMINI_MODEL"
fi
```

---

## PART 19 — Create scripts/new-task.md (task template)

Create `scripts/new-task.md`:

```markdown
# Task Template

# Copy this file, fill it in, run: ./scripts/task.sh -f my-task.md

# Or: AGENT=frontend ./scripts/task.sh -f my-task.md

## Goal

<!-- One sentence: what should exist when this task is done? -->

## Agent

<!-- orchestrator | frontend | backend | database | reviewer | planner -->

orchestrator

## Context / Background

<!-- What does the agent need to know that isn't in DOCS.md? -->

## Details

<!-- Exact requirements. Be as specific as possible. -->
<!-- For UI tasks: describe dimensions, spacing, which components to use -->
<!-- For API tasks: describe endpoints, request/response shapes, auth required -->

## Visual Reference

<!-- Attach screenshot or describe layout precisely if this is a UI task -->

## Reuse (check scan-context.sh first)

<!-- List existing components / models / services this task must use, not recreate -->

## Acceptance Criteria

<!-- The agent self-checks these before outputting anything -->

- [ ] (fill in)
- [ ] (fill in)
- [ ] (fill in)

## Do NOT

<!-- Explicit things the agent must not do -->

- Do not create new components if existing ones cover this
- Do not hardcode colors — use DESIGN.md tokens
- Do not add new dependencies without asking first
```

---

## PART 20 — Create frontend and backend placeholder structures

Create the following placeholder files so scan-context.sh works immediately:

**`frontend/src/components/ui/.gitkeep`** — empty file

**`frontend/src/components/shared/.gitkeep`** — empty file

**`frontend/src/lib/api.ts`**:

```typescript
// All API calls go here. Never fetch directly inside components.
const API_BASE = process.env.NEXT_PUBLIC_API_URL ?? "http://localhost:8000";

export async function apiFetch<T>(
  path: string,
  options?: RequestInit
): Promise<T> {
  const res = await fetch(`${API_BASE}${path}`, {
    headers: { "Content-Type": "application/json", ...options?.headers },
    ...options,
  });
  if (!res.ok) throw new Error(`API error ${res.status}: ${await res.text()}`);
  return res.json() as Promise<T>;
}
```

**`frontend/src/types/index.ts`**:

```typescript
// Shared TypeScript types. Mirror backend Pydantic Read schemas here.
// Example:
// export interface Product {
//   id: string
//   name: string
//   price: number
//   created_at: string
// }
```

**`backend/app/models/base.py`**:

```python
import uuid
from datetime import datetime
from sqlalchemy import DateTime, func
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column


class Base(DeclarativeBase):
    """All models inherit from this. Provides id, created_at, updated_at."""
    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=func.now(), nullable=False
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        onupdate=func.now(),
        nullable=False,
    )
```

**`backend/app/database.py`**:

```python
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine
from app.config import settings

engine = create_async_engine(settings.DATABASE_URL, echo=settings.DEBUG)
AsyncSessionLocal = async_sessionmaker(engine, expire_on_commit=False)


async def get_db() -> AsyncSession:
    async with AsyncSessionLocal() as session:
        try:
            yield session
            await session.commit()
        except Exception:
            await session.rollback()
            raise
```

**`backend/app/config.py`**:

```python
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

    DATABASE_URL: str = "postgresql+asyncpg://user:password@localhost/dbname"
    SECRET_KEY: str = "change-me-in-production"
    DEBUG: bool = False
    ALLOWED_ORIGINS: list[str] = ["http://localhost:3000"]


settings = Settings()
```

**`backend/app/main.py`**:

```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.config import settings

app = FastAPI(title="API", version="0.1.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.ALLOWED_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Add routers here:
# from app.routers import products
# app.include_router(products.router, prefix="/api/v1")
```

---

## PART 21 — Create .gitignore additions

Append to `.gitignore` (create if missing):

```
# AI agent context (auto-generated, do not commit)
.context-cache/
*.context.tmp

# Environment
.env
.env.local
.env.*.local

# Python
__pycache__/
*.pyc
.venv/
venv/

# Node
node_modules/
.next/
```

---

## PART 22 — Make scripts executable and verify

Run these commands:

```bash
chmod +x scripts/scan-context.sh
chmod +x scripts/task.sh
chmod +x scripts/review.sh
```

Then run `bash scripts/scan-context.sh` and confirm it outputs the inventory
without errors. Fix any path issues if the output is empty.

---

## PART 23 — Final summary

After creating all files, output this summary to the developer:

```
✅ AI AGENTIC TEMPLATE SETUP COMPLETE

Files created:
  CLAUDE.md / GEMINI.md          ← master rules (loaded by both tools)
  DESIGN.md                      ← FILL IN: your colors, fonts, tokens
  DOCS.md                        ← FILL IN: project overview, features

  agents/
    ORCHESTRATOR.md              ← controls all other agents
    AGENT_PLANNER.md             ← decomposes tasks into subtasks
    AGENT_FRONTEND.md            ← Next.js / shadcn / TypeScript
    AGENT_BACKEND.md             ← FastAPI / SQLAlchemy / Pydantic
    AGENT_DATABASE.md            ← schema design + migrations
    AGENT_REVIEWER.md            ← quality gate, rule enforcement

  rules/
    RULES_FRONTEND.md            ← 30+ frontend rules
    RULES_BACKEND.md             ← 30+ backend rules
    RULES_GENERAL.md             ← SOLID, DRY, KISS, naming
    RULES_GIT.md                 ← commit format, branch naming

  scripts/
    scan-context.sh              ← auto-scans component + module inventory
    task.sh                      ← run any task with full context injected
    review.sh                    ← review any file or git diff

HOW TO USE THIS TEMPLATE:

1. Clone this repo for a new project
2. Fill in DESIGN.md with your colors and typography
3. Fill in DOCS.md with your project overview
4. Run a task:
   ./scripts/task.sh "Create a user profile page"
   AGENT=backend ./scripts/task.sh "Add authentication endpoints"
   AGENT=frontend ./scripts/task.sh "Build the dashboard layout"
   ./scripts/review.sh --diff

5. For complex tasks, let the orchestrator plan and route:
   ./scripts/task.sh "Build a full product management feature with CRUD"
```
