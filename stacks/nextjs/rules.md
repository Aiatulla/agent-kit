## Next.js stack rules

Written for Next.js 16, React 19, TypeScript, Tailwind CSS; shadcn/ui rules apply when the project uses it.
Mechanical rules (file length, parent-relative imports, `fetch` outside the API client, hex colors) are enforced by `lint/eslint.config.mjs`.

### Components

- One component per file; the file name is the component name in PascalCase.
- The default export is the component; named exports are its types and helpers.
- Every component has a props interface directly above it: `interface <Name>Props { ... }`.
  Export it only when it is used in more than one place.
- shadcn/ui components live in `components/ui/`: never recreate, copy, or edit them.
  Compose them through props and `className`; add new ones with `npx shadcn@latest add <name>`.
- Feature components go in `components/<feature>/`; components shared across features go in `components/shared/`.

### TypeScript

- Use `unknown` plus narrowing, or the real type, where a type is not obvious.
- `type` for unions and intersections, `interface` for object shapes.
- API response types mirror the backend's response schemas exactly.

### Styling

- Colors, font sizes, and spacing come from the project's design tokens (CSS variables); never raw values or arbitrary Tailwind values for them.
- No `style={{}}` for static values; inline styles are only for values computed at runtime.
- Mobile-first: base styles first, then `md:` and `lg:` prefixes.
- Dark mode through the `dark:` prefix, only if the design system defines it.

### App Router

- Server components by default; add `'use client'` only for interactivity, state, or browser APIs.
- Fetch data in server components; never fetch in `useEffect` when a server component can do it.
- `params`, `searchParams`, `cookies()`, and `headers()` are async: always `await` them.
- Every route segment with data has `loading.tsx` (or a `<Suspense>` boundary) and `error.tsx`.
- Every page exports `metadata` or `generateMetadata`.
- Request interception lives in `proxy.ts` (Next.js 16 renamed `middleware.ts`).

### Data and API

- All HTTP calls go through the API client module (`lib/api.ts` or `lib/api/`); components never call `fetch` or axios directly.
- Client-side fetching uses the project's query library (React Query or SWR), never raw effect fetches.
- Every data view handles loading, error, and empty states.
- The API base URL comes from `NEXT_PUBLIC_API_URL`.

### Imports and performance

- Import order: React, third-party, `@/lib`, `@/components`, types.
- Import single functions from large libraries; no barrel imports of them.
- `next/image` for images and `next/link` for internal navigation, never `<img>` or `<a>`.
- Use `next/dynamic` for heavy components not needed on first render.
