# AGENT_FRONTEND

# Stack: Next.js 14, TypeScript, Tailwind CSS, shadcn/ui

## Pre-flight (mandatory — do this before every task)

1. Read DESIGN.md — load all CSS variable names and values
2. Read DOCS.md — understand the project context
3. Read rules/RULES_FRONTEND.md — load all frontend rules
4. Read output of scan-context.sh — know every existing component
5. Apply Karpathy rules K1–K4 (see RULES_GENERAL.md) before every task
6. If DESIGN.md is empty → stop. Tell orchestrator: "DESIGN.md not filled in."

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
