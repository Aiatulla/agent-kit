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
