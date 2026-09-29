# CODE RULES — Universal AI Agent Guidelines
> This file is read by all AI coding agents (Claude, Cursor, Gemini, GPT, etc.).
> Before writing ANY code, read and follow every rule in this file.
> These rules apply to the entire codebase: frontend (React/Next.js) and backend (FastAPI/Django).

---

## 0. AGENT BEHAVIOR — Read This First

Before writing any code, an agent MUST:

1. **Search before creating** — check if a component, utility, hook, service, or function already exists that does what you need. Reuse it. If it partially fits, extend it — don't duplicate.
2. **Flag over-engineering** — if you detect an unnecessary abstraction, extra layer, or pattern added "for the future", STOP. Explain why it's over-engineering and propose a simpler alternative. Do not build it without an explicit user override.
3. **Apply the 5 Smells check** before submitting any code:
   - [ ] Is a function doing more than one thing? → Split it
   - [ ] Is a file over ~200 lines? → Split it
   - [ ] Is the same logic copy-pasted in 2+ places? → Extract it
   - [ ] Is a component fetching AND rendering data? → Separate concerns
   - [ ] Is there a hardcoded value that could change? → Name it as a constant
4. **Cite the rule** when applying a principle (e.g., "Applying Rule 3.2: no business logic in components").

---

## 1. CORE PRINCIPLES

### 1.1 DRY — Don't Repeat Yourself
- Every piece of logic, data, or configuration must have a **single authoritative source**.
- If you write the same logic twice, extract it immediately into a shared util/hook/service.
- Applies to: functions, components, styles, config values, error messages, API calls.

### 1.2 KISS — Keep It Simple
- The simplest solution that correctly solves the problem is the right solution.
- Prefer readable over clever. A junior developer should be able to understand the code without a walkthrough.
- Avoid: nested ternaries, complex one-liners, unnecessary abstractions, "smart" code.

### 1.3 YAGNI — You Aren't Gonna Need It *(Hard Gate)*
- Do NOT build features, abstractions, layers, or flexibility "for the future".
- Every piece of code must solve a **real, current problem**.
- **YAGNI violations are grounds for refusal.** Propose the simpler path. Wait for explicit user override before proceeding.

### 1.4 Single Responsibility
- One function = one job. One file = one concern. One component = one purpose.
- Functions: if you need "and" to describe what it does, split it.
- Files: if the filename is vague (`utils.py`, `helpers.ts`), it's a smell — name by domain (`date_utils.py`, `formatters.ts`).

---

## 2. ARCHITECTURE — 3-Layer Rule

Apply layers **only when a feature has real complexity**. Simple CRUD or presentational features don't need all layers.

### Frontend (React / Next.js)
```
Page / Route
  └── Components (UI only, no data fetching logic)
        └── Hooks / Services (data, state, business logic)
              └── API layer / utils
```

### Backend (FastAPI / Django)
```
Route / View (request parsing, response shaping only)
  └── Service (business logic, orchestration)
        └── Repository / ORM (database access only)
```

**Rules:**
- Never skip layers for complex features; never force layers for simple ones.
- Controllers/routes must not contain business logic — delegate to services.
- Services must not contain raw SQL/ORM queries — delegate to repositories.
- Components must not fetch data directly — delegate to hooks or server components.

### When Classes Are Appropriate
Use classes for:
- Service layer objects with shared state or multiple related methods
- Data models / schemas (Pydantic, Django models, dataclasses)
- Complex domain entities with behavior
- When grouping 3+ related functions that share context

Do NOT use classes for:
- Simple stateless utility functions (use plain functions)
- Single-method wrappers (just use the function)
- Adding "structure" that provides no behavioral benefit

---

## 3. FRONTEND RULES (React / Next.js)

### 3.1 Components
- **Check first:** before creating a component, verify it doesn't already exist in the component library.
- Components are **UI-only** — they receive data via props and emit events via callbacks.
- No `fetch`, no `axios`, no database calls inside components (except Next.js Server Components — see 3.5).
- Max component length: ~150 lines. If longer, decompose.
- Use **composition** over inheritance — build complex UIs from small, focused components.
- Props must be typed (TypeScript interfaces or PropTypes). Never use `any`.
- Provide sensible default props where appropriate.

### 3.2 Custom Hooks
- Extract all stateful logic, side effects, and data fetching into custom hooks (`use*`).
- One hook = one concern. `useUserProfile` not `useEverything`.
- Hooks are reusable across components — design them that way from the start.
- Name hooks descriptively: `useProductList`, `useAuthRedirect`, `useFormValidation`.

### 3.3 State Management
- **Local state first** (`useState`, `useReducer`) — don't reach for global state prematurely.
- Global state only for genuinely shared, cross-component data (auth, theme, cart).
- Never store derived data in state — compute it from existing state/props.
- Avoid prop drilling beyond 2 levels — use context or state management.

### 3.4 Naming & Structure
- Components: `PascalCase` (`UserCard`, `ProductTable`)
- Hooks: `camelCase` prefixed with `use` (`useCart`, `useDebounce`)
- Files: match the component name (`UserCard.tsx`, `useCart.ts`)
- Folders: feature-based, not type-based (`/features/checkout/` not `/components/checkout-stuff/`)

### 3.5 Next.js Specific — Performance

**Server Components (RSC):**
- Default to Server Components. Only add `"use client"` when you need interactivity, browser APIs, or hooks.
- Never fetch data in Client Components if a Server Component can do it.
- Pass data down from Server → Client via props, not re-fetching.

**Data Fetching:**
- Use `fetch` with explicit caching strategy: `cache: 'force-cache'`, `revalidate: N`, or `cache: 'no-store'`.
- Never leave caching implicit — always declare intent.
- Prefer `async/await` in Server Components over `useEffect` + `useState` for initial data.

**Code Splitting & Loading:**
- Lazy-load heavy Client Components: `const Chart = dynamic(() => import('./Chart'), { ssr: false })`.
- Use `loading.tsx` and `Suspense` boundaries to progressively stream UI.
- Never import large libraries at the top level if only used in one route.

**Images & Assets:**
- Always use `next/image` — never raw `<img>` tags for content images.
- Set explicit `width` and `height` or use `fill` with a sized container.
- Use `next/font` for fonts — never load fonts via `<link>` in `<head>`.

**Bundle Size:**
- Avoid barrel exports (`index.ts` that re-exports everything) — they break tree-shaking.
- Import specifically: `import { format } from 'date-fns'` not `import * as dateFns from 'date-fns'`.
- Run `next build` and check bundle analyzer output periodically.

**Core Web Vitals:**
- LCP: ensure the largest above-fold element loads fast (preload hero images with `priority`).
- CLS: always reserve space for dynamic content (images, ads, async-loaded elements).
- INP: defer non-critical JS, avoid heavy work on the main thread.

**Caching & Revalidation:**
- Use Route Segment Config (`revalidate`) for page-level caching.
- Use `unstable_cache` or `React.cache` for function-level memoization in Server Components.
- Tag fetches with `tags: ['products']` and use `revalidateTag` for on-demand revalidation.

### 3.6 Accessibility (a11y)
- Use semantic HTML (`<button>`, `<nav>`, `<main>`, `<article>`) — not `<div onClick>`.
- All interactive elements must be keyboard-accessible and focusable.
- Images must have meaningful `alt` text (or `alt=""` for decorative images).
- Form inputs must have associated `<label>` elements.
- Don't rely on color alone to convey information.

---

## 4. BACKEND RULES (FastAPI / Django)

### 4.1 Functions & Services
- One function = one job. If the function name contains "and", split it.
- Max function length: ~30 lines. Long functions are a sign of mixed responsibilities.
- Service functions are the only place for business logic.
- Pure functions preferred — avoid hidden side effects.

### 4.2 Classes in Python
Use classes when:
- A service has 3+ methods that share instance state or configuration
- Implementing a Django Model, Pydantic schema, or dataclass
- Domain logic benefits from encapsulation

Keep classes focused:
```python
# Good — focused service class
class OrderService:
    def __init__(self, db: Session):
        self.db = db

    def create_order(self, data: OrderCreate) -> Order: ...
    def cancel_order(self, order_id: int) -> Order: ...
    def calculate_total(self, items: list[Item]) -> Decimal: ...

# Bad — God class
class AppService:
    def handle_users(self): ...
    def send_emails(self): ...
    def process_payments(self): ...
    def generate_reports(self): ...
```

### 4.3 API Layer (FastAPI)
- Routes handle: request parsing, calling services, shaping responses. Nothing else.
- All input validated with Pydantic schemas at the route level — never inside services.
- Always use typed route parameters and response models.
- HTTP status codes must be semantically correct (201 for create, 204 for delete, 422 for validation).

### 4.4 Consistent API Response Shape
All endpoints return a consistent envelope:
```json
{
  "data": { ... },      // null on error
  "error": null,        // string or object on error, null on success
  "meta": {             // optional: pagination, timestamps
    "page": 1,
    "total": 100
  }
}
```

### 4.5 Error Handling
- Never silently catch and swallow exceptions.
- Define typed custom exceptions: `class OrderNotFoundError(AppError): ...`
- Use a global exception handler (FastAPI middleware) for consistent error responses.
- Log errors with context (user id, request id, relevant data) — not just the message.
- Distinguish: validation errors (422), business rule violations (400/409), not found (404), server errors (500).

### 4.6 Database & ORM
- All DB access lives in the repository/model layer — never in routes or services.
- Avoid N+1 queries: use `select_related`/`prefetch_related` (Django) or `joinedload`/`selectinload` (SQLAlchemy).
- Never load entire tables to filter in Python — filter at the DB level.
- Use database indexes for any column used in `WHERE`, `JOIN`, or `ORDER BY`.
- Wrap multi-step operations in transactions.

### 4.7 Configuration
- All config via environment variables — never hardcode URLs, secrets, ports, or feature flags.
- Use a single config module (`config.py` / `settings.py`) that reads from env.
- Provide a `.env.example` with all required variables documented.
- Fail fast on startup if required config is missing — don't silently use defaults for critical values.

---

## 5. NAMING CONVENTIONS

| Context | Convention | Example |
|---|---|---|
| Python functions/vars | `snake_case` | `get_user_by_id` |
| Python classes | `PascalCase` | `UserService` |
| Python constants | `UPPER_SNAKE_CASE` | `MAX_RETRY_COUNT` |
| TS/JS functions/vars | `camelCase` | `getUserById` |
| TS/JS components | `PascalCase` | `UserProfile` |
| TS/JS constants | `UPPER_SNAKE_CASE` | `API_BASE_URL` |
| CSS classes | `kebab-case` | `user-profile-card` |
| Files (Python) | `snake_case` | `user_service.py` |
| Files (TS component) | `PascalCase` | `UserCard.tsx` |
| Files (TS hook/util) | `camelCase` | `useUserProfile.ts` |

**Naming rules:**
- Names must be self-documenting. No abbreviations unless universally known (`id`, `url`, `api`).
- Booleans: prefix with `is`, `has`, `can`, `should` (`isLoading`, `hasPermission`).
- Event handlers: prefix with `handle` or `on` (`handleSubmit`, `onClose`).
- Async functions: name describes what they return, not how (`getUser` not `fetchUserAsync`).

---

## 6. NO MAGIC VALUES

Every hardcoded value that has meaning must be named:

```python
# Bad
if status == 3:
    ...
time.sleep(30)

# Good
ORDER_STATUS_SHIPPED = 3
CACHE_TTL_SECONDS = 30

if status == ORDER_STATUS_SHIPPED:
    ...
time.sleep(CACHE_TTL_SECONDS)
```

```typescript
// Bad
if (role === 'admin') { ... }
const items = products.slice(0, 10)

// Good
const ADMIN_ROLE = 'admin'
const DEFAULT_PAGE_SIZE = 10

if (role === ADMIN_ROLE) { ... }
const items = products.slice(0, DEFAULT_PAGE_SIZE)
```

---

## 7. GUARD CLAUSES — Avoid Deep Nesting

Invert conditions and return early. Max nesting depth: 2–3 levels.

```python
# Bad
def process_order(order):
    if order:
        if order.status == 'pending':
            if order.items:
                # actual logic here, 3 levels deep
                ...

# Good
def process_order(order):
    if not order:
        raise OrderNotFoundError()
    if order.status != 'pending':
        raise InvalidOrderStatusError()
    if not order.items:
        raise EmptyOrderError()

    # actual logic here, at the top level
    ...
```

---

## 8. TESTING STANDARDS

### Philosophy
- Write code that is **testable by design**: pure functions, injectable dependencies, no hidden global state.
- Tests document behavior — test names should read like specifications.

### What to Test
| Layer | Test Type | What |
|---|---|---|
| Utility functions | Unit | All edge cases, error paths |
| Service layer | Unit | Business logic, error conditions |
| API endpoints | Integration | Request/response contract, auth, status codes |
| React components | Unit | Renders correctly, user interactions |
| Critical user flows | E2E (optional) | Core paths only |

### Rules
- Test names: `test_should_<behavior>_when_<condition>` (Python) / `should <behavior> when <condition>` (JS).
- One assertion concept per test — don't test 5 things in one test.
- Never test implementation details — test behavior and outputs.
- Mock external dependencies (DB, APIs, email) — never hit real services in unit tests.
- Every bug fix must include a regression test.
- Aim for high coverage on business logic; don't chase 100% coverage on boilerplate.

---

## 9. GIT CONVENTIONS

### Commit Messages — Conventional Commits
Format: `<type>(<scope>): <short description>`

| Type | Use for |
|---|---|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Code change with no behavior change |
| `perf` | Performance improvement |
| `test` | Adding or fixing tests |
| `chore` | Build, deps, config |
| `docs` | Documentation only |

Examples:
```
feat(auth): add JWT refresh token endpoint
fix(cart): correct total calculation when discount applied
refactor(user-service): extract email validation to util
perf(product-list): add DB index on category_id
```

### Pull Requests
- PRs must be **small and focused** — one feature or fix per PR.
- PR title follows the same Conventional Commits format.
- Every PR must include: what changed, why, and how to test it.
- No PR merges without passing CI (lint + tests).
- Self-review before requesting review — check your own diff first.

### Branches
- `main` / `master` — production-ready only
- `dev` / `develop` — integration branch
- Feature branches: `feat/<short-name>` (`feat/user-auth`)
- Fix branches: `fix/<short-name>` (`fix/cart-total`)

---

## 10. PERFORMANCE CHECKLIST

### Backend
- [ ] No N+1 queries — use `select_related` / `prefetch_related` / eager loading
- [ ] Heavy operations (email, image processing, reports) → background tasks (Celery, FastAPI BackgroundTasks)
- [ ] Paginate all list endpoints — never return unbounded lists
- [ ] Cache expensive, repeated reads (Redis, Django cache framework)
- [ ] DB indexes on all filter/join/order columns
- [ ] Use async endpoints in FastAPI for I/O-bound operations

### Frontend / Next.js
- [ ] Default to Server Components; `"use client"` only when needed
- [ ] Lazy-load heavy components with `dynamic()`
- [ ] Use `next/image` for all content images with explicit dimensions
- [ ] Use `next/font` for all fonts
- [ ] Explicit cache strategy on every `fetch` call
- [ ] No barrel exports — import specifically
- [ ] `Suspense` boundaries for async UI sections
- [ ] Preload LCP image with `priority` prop
- [ ] Reserve space for dynamic content to prevent CLS

---

## 11. FILE SIZE LIMITS — Auto-Flag

| Context | Soft Limit | Hard Limit |
|---|---|---|
| Any function | 25 lines | 40 lines |
| React component | 100 lines | 150 lines |
| Python service class | 150 lines | 200 lines |
| Any file | 200 lines | 300 lines |

When a file or function approaches the soft limit → leave a comment flagging it.
When it hits the hard limit → stop, refactor before continuing.

---

## 12. DOCUMENTATION STANDARDS

- **Self-documenting code first** — names and structure should explain intent without comments.
- Comments explain **why**, not **what**. If the what needs explaining, rename it.
- Add docstrings/JSDoc for: public API functions, complex algorithms, non-obvious business rules.
- Keep a `README.md` at project root with: setup instructions, env vars required, how to run tests.
- Maintain an `API.md` or OpenAPI spec for all public endpoints.

```python
# Bad comment
# increment i by 1
i += 1

# Good comment
# Retry limit reached — fail fast instead of cascading timeouts
if attempt >= MAX_RETRIES:
    raise ServiceUnavailableError()
```
