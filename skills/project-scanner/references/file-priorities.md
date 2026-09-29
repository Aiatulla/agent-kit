# File Reading Priorities by Stack

Read the relevant section for the detected project type.
Stop reading a category once you have clear signal — don't read all files listed.

---

## Table of Contents
1. [React / Next.js (Web)](#react-next)
2. [Vue / Nuxt (Web)](#vue-nuxt)
3. [Svelte / SvelteKit (Web)](#svelte)
4. [Angular (Web)](#angular)
5. [React Native (Mobile)](#react-native)
6. [Flutter (Mobile)](#flutter)
7. [Swift / SwiftUI (iOS)](#swiftui)
8. [Kotlin / Jetpack Compose (Android)](#android)
9. [Node.js / Express / Fastify (API)](#nodejs-api)
10. [Python / FastAPI / Django / Flask (API)](#python-api)
11. [Laravel / PHP (API)](#laravel)
12. [Go (API / CLI)](#go)
13. [Rust (Systems / CLI)](#rust)
14. [Electron / Tauri (Desktop)](#desktop)
15. [Monorepo (any stack)](#monorepo)
16. [Library / Package](#library)

---

## 1. React / Next.js {#react-next}

```
Priority 1 — Manifest & config
  package.json              → scripts, dependencies, project name
  next.config.js / .ts      → routing mode, env, redirects (Next.js)
  tailwind.config.js        → design system tokens (if Tailwind)
  tsconfig.json             → path aliases (reveals folder structure intent)

Priority 2 — Entry & routing
  src/app/layout.tsx        → root layout, global providers (Next.js App Router)
  src/app/page.tsx          → homepage / entry screen
  src/pages/_app.tsx        → global providers (Next.js Pages Router)
  src/router.tsx / routes.tsx → client-side routes (React Router)

Priority 3 — Core structure
  src/components/           → list filenames only, read 1–2 representative ones
  src/hooks/                → list filenames — custom hooks reveal domain logic
  src/store/ or src/context/ → state management setup
  src/lib/ or src/utils/    → shared utilities

Priority 4 — Data & API
  src/api/ or src/services/  → API call patterns
  src/types/ or src/models/  → TypeScript interfaces = domain model
  prisma/schema.prisma       → database schema (if Prisma)
  src/app/api/               → API routes (Next.js)

Priority 5 — Config & env
  .env.example              → external services used
  src/config/ or constants.ts → app constants

Priority 6 — CI/deployment
  .github/workflows/        → read one workflow file
  vercel.json / netlify.toml / render.yaml
  Dockerfile (if present)
```

---

## 2. Vue / Nuxt {#vue-nuxt}

```
Priority 1 — Manifest
  package.json
  nuxt.config.ts / vue.config.js
  tailwind.config.js (if present)

Priority 2 — Entry & routing
  app.vue                   → root component (Nuxt)
  pages/                    → list all page files (Nuxt file-based routing)
  src/router/index.ts       → routes (Vue Router)
  layouts/default.vue       → global layout

Priority 3 — Core structure
  composables/              → list filenames (Vue 3 composition = domain logic)
  components/               → list filenames, read 1–2
  stores/ or src/store/     → Pinia / Vuex stores

Priority 4 — Data
  server/api/               → Nuxt server routes
  src/services/ or api/     → API layer
  types/ or models/         → TypeScript interfaces

Priority 5 — Config
  .env.example
  nuxt.config.ts (modules, runtimeConfig)
```

---

## 3. Svelte / SvelteKit {#svelte}

```
Priority 1 — Manifest
  package.json
  svelte.config.js
  vite.config.js

Priority 2 — Entry & routing
  src/routes/               → list all +page.svelte files (file-based routing)
  src/routes/+layout.svelte → root layout
  src/routes/+page.svelte   → homepage

Priority 3 — Core structure
  src/lib/                  → shared utilities and components
  src/lib/stores/           → reactive stores = state management
  src/lib/components/       → list filenames

Priority 4 — Data
  src/routes/*/+page.server.ts → server-side data loading
  src/lib/server/           → server-only utilities, DB access
  .env.example
```

---

## 4. Angular {#angular}

```
Priority 1 — Manifest
  package.json
  angular.json              → project structure, build config
  tsconfig.json

Priority 2 — Entry & routing
  src/app/app.module.ts     → module imports = feature map
  src/app/app-routing.module.ts → routes
  src/app/app.component.ts  → root component

Priority 3 — Core features
  src/app/features/         → list feature modules
  src/app/core/             → services, guards, interceptors
  src/app/shared/           → shared components, pipes, directives

Priority 4 — Data
  src/app/services/         → list and read 1–2 key services
  src/environments/         → environment configs = API URLs, flags
  src/app/models/ or interfaces/
```

---

## 5. React Native {#react-native}

```
Priority 1 — Manifest
  package.json
  app.json / app.config.js / app.config.ts  → Expo config, bundle IDs, permissions
  babel.config.js

Priority 2 — Entry & navigation
  App.tsx or src/App.tsx    → root component + navigation setup
  src/navigation/           → navigator setup reveals ALL screens
  src/screens/              → list all screen files

Priority 3 — Core structure
  src/components/           → list filenames, read 1–2
  src/hooks/                → custom hooks
  src/store/ or src/context/ → state management

Priority 4 — Data & services
  src/api/ or src/services/  → API layer, base URL, interceptors
  src/types/ or src/models/  → data shapes
  .env.example or eas.json  → build profiles, environment

Priority 5 — Native config
  ios/Info.plist            → iOS permissions (skim key entries only)
  android/app/src/main/AndroidManifest.xml → Android permissions
```

---

## 6. Flutter {#flutter}

```
Priority 1 — Manifest
  pubspec.yaml              → ALL dependencies, assets, app name
  analysis_options.yaml     → linting rules

Priority 2 — Entry & routing
  lib/main.dart             → app entry, theme setup, initial route
  lib/app/router.dart or lib/routes.dart → route definitions
  lib/app/app.dart          → MaterialApp / CupertinoApp setup

Priority 3 — Core structure
  lib/features/ or lib/screens/ → list subdirectories = feature map
  lib/features/[one feature]/ → read one complete feature end-to-end
  lib/shared/ or lib/common/ → shared widgets, utilities

Priority 4 — State management
  lib/*/providers/ or lib/*/bloc/ or lib/*/cubit/ → state pattern
  lib/*/notifiers/ (Riverpod) → read one provider file

Priority 5 — Data
  lib/*/repositories/       → data access pattern
  lib/*/models/ or lib/*/entities/ → data models
  lib/core/api/ or lib/services/ → API client setup
  .env or lib/core/constants/ → environment constants
```

---

## 7. SwiftUI / iOS {#swiftui}

```
Priority 1 — Manifest
  [ProjectName].xcodeproj/project.pbxproj → skim for targets, deployment target
  Package.swift (if SPM)    → dependencies
  Info.plist                → permissions, bundle ID

Priority 2 — Entry & navigation
  [App].swift (@main)       → entry point
  ContentView.swift         → root view
  [Any]NavigationView or NavigationStack → routing pattern

Priority 3 — Core structure
  Views/ or Screens/        → list all view files
  ViewModels/               → MVVM pattern confirmation
  Models/ or Entities/      → data shapes

Priority 4 — Data
  Services/ or Network/     → API layer
  [Store].swift or [Manager].swift → data managers
  CoreData/*.xcdatamodeld   → local database (if CoreData)
```

---

## 8. Kotlin / Jetpack Compose (Android) {#android}

```
Priority 1 — Manifest
  build.gradle or build.gradle.kts (app/) → dependencies, SDK versions
  AndroidManifest.xml       → permissions, activities

Priority 2 — Entry & navigation
  MainActivity.kt           → entry point
  Navigation*.kt            → NavGraph = screen map

Priority 3 — Core structure
  ui/ or presentation/      → list packages = feature map
  ui/[one feature]/         → read one screen + ViewModel
  domain/                   → use cases (Clean Architecture)
  data/                     → repositories, data sources

Priority 4 — Data
  data/remote/              → API client, Retrofit interfaces
  data/local/               → Room database, DAOs
  di/ or injection/         → DI setup (Hilt/Koin) = dependency map
```

---

## 9. Node.js / Express / Fastify {#nodejs-api}

```
Priority 1 — Manifest
  package.json
  tsconfig.json (if TS)

Priority 2 — Entry & routing
  src/index.ts or src/server.ts or src/app.ts → server setup, middleware
  src/routes/ or src/api/   → list all route files = endpoint map
  src/routes/[one router].ts → read one complete router

Priority 3 — Core structure
  src/controllers/          → list filenames
  src/services/             → business logic layer
  src/middleware/           → auth, validation, error handling

Priority 4 — Data
  src/models/ or src/entities/ → data models
  src/database/ or src/db/  → DB connection setup
  prisma/schema.prisma      → if Prisma
  src/config/               → environment config

Priority 5 — Ops
  .env.example
  Dockerfile
  docker-compose.yml
```

---

## 10. Python / FastAPI / Django / Flask {#python-api}

```
Priority 1 — Manifest
  pyproject.toml or requirements.txt or Pipfile
  setup.py (if library)

Priority 2 — Entry & routing (framework-specific)
  FastAPI:  main.py or app/main.py → app setup, included routers
            app/routers/ or app/api/ → route files
  Django:   [project]/settings.py → installed apps, DB, middleware
            [project]/urls.py → root URL conf
            [app]/views.py or [app]/urls.py → feature routes
  Flask:    app/__init__.py → factory function, blueprints
            app/routes/ or blueprints/ → route files

Priority 3 — Core structure
  app/models/ or models.py  → SQLAlchemy / Django models = DB schema
  app/schemas/ (FastAPI)    → Pydantic models = API contract
  app/services/ or app/logic/ → business logic

Priority 4 — Data & config
  .env.example or config.py → environment vars
  alembic/ or migrations/   → DB migration state
  Dockerfile + docker-compose.yml
```

---

## 11. Laravel / PHP {#laravel}

```
Priority 1 — Manifest
  composer.json
  .env.example

Priority 2 — Entry & routing
  routes/web.php            → web routes
  routes/api.php            → API routes

Priority 3 — Core structure
  app/Http/Controllers/     → list controller files
  app/Models/               → Eloquent models = domain
  app/Services/ (if exists) → business logic layer

Priority 4 — Data
  database/migrations/      → list migration files (= DB history)
  config/                   → list and read 2–3 key configs
  app/Http/Middleware/       → auth and middleware stack
```

---

## 12. Go {#go}

```
Priority 1 — Manifest
  go.mod                    → module name, dependencies
  go.sum (skip reading — too large)

Priority 2 — Entry
  main.go or cmd/*/main.go  → entry point, wiring
  internal/ or pkg/         → list top-level packages

Priority 3 — Core structure
  internal/handler/ or internal/api/ → HTTP handlers
  internal/service/ or internal/usecase/ → business logic
  internal/repository/ or internal/store/ → data access
  internal/model/ or internal/domain/ → types

Priority 4 — Config & ops
  config/ or internal/config/ → config structs
  .env.example or config.yaml
  Dockerfile + docker-compose.yml
  Makefile                  → build/run commands
```

---

## 13. Rust {#rust}

```
Priority 1 — Manifest
  Cargo.toml                → workspace members, dependencies
  Cargo.lock (skip)

Priority 2 — Entry
  src/main.rs               → entry point (binary)
  src/lib.rs                → library root, public API (library)

Priority 3 — Core structure
  src/                      → list all .rs files (modules = architecture)
  Read 2–3 most central modules based on names

Priority 4 — Config & ops
  .env.example
  Dockerfile (if present)
  Makefile or justfile
```

---

## 14. Electron / Tauri (Desktop) {#desktop}

```
Treat UI layer as React/Vue/Svelte (see above for that stack).

Additionally read:

Electron:
  main.js or src/main/index.ts → main process entry
  src/preload.ts            → IPC bridge (= what native features are exposed)
  electron-builder.json     → packaging config

Tauri:
  src-tauri/tauri.conf.json → app config, permissions, window setup
  src-tauri/src/main.rs or src/lib.rs → Rust backend commands
  src-tauri/Cargo.toml      → Rust dependencies
```

---

## 15. Monorepo {#monorepo}

```
Priority 1 — Workspace config
  package.json (root)       → workspaces list
  pnpm-workspace.yaml or lerna.json or turbo.json or nx.json
  List packages/ or apps/ or services/

Priority 2 — Map the packages
  For each package/app: read its package.json only
  Build a map: name → type (app/lib/service) → framework

Priority 3 — Read the most important app
  Apply the relevant stack priority list above to the primary app

Priority 4 — Shared packages
  packages/ui/ or libs/shared/ → shared component library
  packages/types/ or libs/common/ → shared types
  packages/config/ → shared configs (ESLint, TS, Tailwind)
```

---

## 16. Library / Package {#library}

```
Priority 1 — Manifest
  package.json / Cargo.toml / pubspec.yaml / pyproject.toml
  Note: main/exports field = public API entry

Priority 2 — Entry & public API
  src/index.ts or src/lib.rs or lib/ → main export file
  types/ or *.d.ts          → TypeScript types = API contract

Priority 3 — Core
  src/                      → list and read 2–3 core implementation files
  examples/ or demo/        → read one example to see intended usage

Priority 4 — Quality
  README.md                 → installation and usage docs
  CHANGELOG.md              → release history = project maturity
  .github/workflows/        → CI, release automation
  tests/ or __tests__/      → read test names only
```
