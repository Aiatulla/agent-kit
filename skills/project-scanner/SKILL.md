---
name: project-scanner
description: >
  Scan a full software project and produce a structured "New Developer Briefing" — a product-manager-level
  overview covering what the project is, its goals, audience, tech stack, architecture, key conventions,
  current state, and where to start. Also writes or updates docs/DOCS.md with the findings.
  Use this skill whenever a user wants to understand a new codebase, onboard to a project, generate
  project documentation, update existing docs, create a landing page brief, or asks things like
  "what is this project", "explain this codebase", "scan my project", "give me an overview",
  "I'm new to this project", "document this project", or "update my DOCS.md".
  Works with any project type: web apps, mobile apps, desktop apps, APIs, libraries, CLIs, monorepos.
---

# Project Scanner — Codebase Intelligence Skill

You are acting as a senior engineer AND product manager who has just been handed an unfamiliar codebase.
Your job is to understand it as efficiently as possible and produce a briefing so clear that a brand-new
developer (or a non-technical stakeholder) can immediately grasp the whole picture.

Token efficiency is a first-class concern. Read strategically, not exhaustively.

---

## Step 0 — Ask One Blocking Question

Before scanning, ask the user this single question (combine all options in one message):

```
How deep should I go?

  🟢 Quick Scan    — High-level overview only. Reads ~5–8 key files.
                     Best for: "what is this project?" / fast orientation.
                     (~2–3 min)

  🔵 Standard      — Architecture, patterns, conventions. Reads ~15–20 files.
                     Best for: onboarding a new developer, updating docs.
                     (~5–8 min)

  🔴 Deep Dive     — Full audit: patterns, edge cases, inconsistencies, risks.
                     Reads ~30+ files. Best for: tech leads, major refactors.
                     (~10–15 min)
```

Also ask: **"Is there a specific angle you care most about?"**
Options to offer: `General overview` / `Technical architecture` / `Product & goals` / `Landing page brief` / `Docs update only`

---

## Step 1 — Auto-Detect Phase (do this before reading any source files)

Run these commands first. They cost almost nothing but reveal everything about project type, stack, and structure.

```bash
# 1. Top-level structure
ls -la

# 2. Project manifest (whichever exists)
cat package.json 2>/dev/null || cat pubspec.yaml 2>/dev/null || cat Cargo.toml 2>/dev/null \
  || cat pyproject.toml 2>/dev/null || cat requirements.txt 2>/dev/null \
  || cat go.mod 2>/dev/null || cat pom.xml 2>/dev/null || cat build.gradle 2>/dev/null \
  || cat composer.json 2>/dev/null || echo "No manifest found"

# 3. README (if exists)
cat README.md 2>/dev/null || cat README.rst 2>/dev/null || cat README.txt 2>/dev/null || echo "No README"

# 4. Check for existing DOCS.md
cat docs/DOCS.md 2>/dev/null || cat DOCS.md 2>/dev/null || echo "NO_EXISTING_DOCS"

# 5. Git log summary (last 10 commits = recent intent signal)
git log --oneline -10 2>/dev/null || echo "No git history"

# 6. Directory tree (2 levels, ignoring noise)
find . -maxdepth 2 -not -path '*/node_modules/*' -not -path '*/.git/*' \
  -not -path '*/dist/*' -not -path '*/__pycache__/*' -not -path '*/build/*' \
  -not -path '*/.next/*' -not -path '*/vendor/*' -not -path '*/target/*' \
  -not -path '*/.dart_tool/*' -not -path '*/Pods/*' | sort
```

From this output, determine:
- **Project type** (web app / mobile app / desktop app / API / library / CLI / monorepo)
- **Primary language** and **framework**
- **Whether DOCS.md already exists** (critical for Step 5)
- **Whether README is current** (compare git log dates vs README content)

Then read the relevant file priority list from `references/file-priorities.md` for the detected stack.

---

## Step 2 — Strategic File Reading

Read files in priority order based on the detected stack (see `references/file-priorities.md`).
**Stop reading a category early** if you already have enough signal.

### Universal priority order (all project types):
1. **Config / manifest** — already read in Step 1
2. **Entry point** — `main.*`, `index.*`, `app.*`, `server.*`, `App.tsx`, `main.dart`, etc.
3. **Routing / navigation** — tells you what the app *does* (screens, pages, endpoints)
4. **Core domain models** — `models/`, `types/`, `entities/`, `schemas/` — the data shapes
5. **One representative feature** — pick the most complete-looking feature folder and read it end-to-end
6. **Environment / config files** — `.env.example`, `config/`, `constants.*` — reveals integrations
7. **CI/CD & deployment** — `.github/workflows/`, `Dockerfile`, `render.yaml` — reveals target environment
8. **Tests (skim only)** — test names reveal intent better than implementation; read file names, not bodies

### Depth-based reading limits:
| Depth | Max files to read | Max lines per file |
|-------|------------------|--------------------|
| Quick | 8 | 100 |
| Standard | 20 | 150 |
| Deep Dive | 35 | 300 |

**Always skip**: `node_modules/`, `dist/`, `build/`, `.git/`, `__pycache__/`, `Pods/`, `target/`, `.dart_tool/`, `*.lock`, `*.log`, `*.map`, minified files.

---

## Step 3 — Produce the Briefing

Generate the report using this exact structure. Mark each data point with a confidence tag:
- `✅ confirmed` — explicitly stated in docs/config
- `🔍 inferred` — read from code structure/patterns
- `❓ unclear` — couldn't determine; flag for the team

---

### 📋 PROJECT BRIEFING

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PROJECT OVERVIEW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Name            : [project name]
Type            : [Web App / Mobile App / Desktop App / API / Library / CLI / Monorepo]
Stage           : [Prototype / Active Development / Production / Maintenance / Unknown]
One-liner       : [what this does in one sentence — no jargon]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PRODUCT PERSPECTIVE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

What it does    : [2–4 sentences. What problem does it solve? What does a user actually do with it?]
Target users    : [who uses this — developers, consumers, businesses, internal team, etc.]
Core goals      : [bullet list of 3–5 inferred product goals]
Key features    : [bullet list of main features/screens/capabilities discovered]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TECH STACK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Language        : 
Framework       : 
UI Layer        : [React / Flutter / SwiftUI / etc.]
State Mgmt      : [Redux / Riverpod / Zustand / MobX / Context / none detected]
Database        : [Postgres / SQLite / Firestore / Supabase / etc. or "not detected"]
Auth            : [JWT / OAuth / Firebase Auth / Supabase / clerk / none / not detected]
API Style       : [REST / GraphQL / tRPC / gRPC / none]
Key Libraries   : [top 5–8 most important dependencies with one-word purpose each]
Deployment      : [Vercel / Railway / Docker / App Store / Play Store / etc. or "not detected"]
External APIs   : [list any third-party services detected: Stripe, Sendgrid, Mapbox, etc.]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ARCHITECTURE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Pattern         : [MVC / MVVM / Clean Architecture / Feature-first / Monolith / etc.]
Folder Structure: [brief description of how the codebase is organized]
Key Modules     : [list the main folders/packages and what each does in one line]
Data Flow       : [how data moves through the app — UI → store → API → DB or similar]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CONVENTIONS & PATTERNS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Naming style    : [camelCase / snake_case / PascalCase — for files, functions, components]
Component style : [functional / class-based / widget-tree / etc.]
Styling approach: [CSS Modules / Tailwind / StyleSheet / Theme / styled-components]
Error handling  : [try/catch pattern / Result type / global handler / inconsistent]
Testing         : [framework detected + coverage level: none / partial / good]
Code quality    : [linter / formatter detected: ESLint, Prettier, dartfmt, etc.]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CURRENT STATE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Completeness    : [what's clearly done vs clearly unfinished]
Recent activity : [summary of last 10 commits — what's being worked on right now]
Known gaps      : [TODOs found, placeholder code, missing features inferred from routes/screens]
Tech debt flags : [any obvious issues: inconsistent patterns, outdated deps, missing error handling]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
FOR NEW DEVELOPERS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Start here      : [the single most important file to read first, with reason]
Then read       : [ordered list of 3–5 next files to understand the app]
Run the app     : [inferred setup steps: install → env → run command]
First task tip  : [advice for making a first small contribution without breaking things]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
OPEN QUESTIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[List anything that couldn't be determined confidently — ask the team or original dev]
```

---

## Step 4 — Offer Bonus Artifacts

After presenting the briefing, always offer these follow-up options:

```
What would you like next?

  A) 📄 Generate a CONTRIBUTING.md starter
  B) 🌐 Write a landing page copy brief (headline, subheadline, features, CTA)
  C) 🗺️  Draw an architecture diagram (Mermaid)
  D) 📋 List all TODO/FIXME comments found in the codebase
  E) 🔒 Security surface summary (auth, env vars, API exposure)
  F) Nothing, this is enough — thanks!
```

Only execute the chosen option, don't pre-generate all of them.

---

## Step 5 — Write or Update DOCS.md

This step always runs after the briefing, unless the user explicitly opts out.

### If `docs/DOCS.md` does NOT exist:
```bash
mkdir -p docs
```
Then create `docs/DOCS.md` with this structure:

```markdown
# [Project Name] — Project Documentation

> Last updated: [current date] | Generated by project-scanner skill

## Project Overview
[paste the PROJECT OVERVIEW + PRODUCT PERSPECTIVE sections from the briefing]

## Tech Stack
[paste TECH STACK section]

## Architecture
[paste ARCHITECTURE section]

## Conventions
[paste CONVENTIONS & PATTERNS section]

## Current State
[paste CURRENT STATE section]

## Getting Started
[paste FOR NEW DEVELOPERS section]

## Open Questions
[paste OPEN QUESTIONS section]

---
*This document was auto-generated by scanning the codebase. 
Sections marked 🔍 are inferred from code — verify with the team.*
```

### If `docs/DOCS.md` ALREADY EXISTS:
Read the existing file carefully. Then:

1. **Identify which sections already exist** in DOCS.md
2. **Do NOT delete or overwrite sections** that contain human-written content not covered by the scan (e.g. custom deployment guides, API reference tables, team decisions)
3. **Update sections that overlap** with the scan findings — replace stale tech stack info, outdated architecture notes, old setup instructions
4. **Add missing sections** that the scan found but DOCS.md doesn't have
5. **Prepend a changelog entry** at the very top of the file:

```markdown
> 📅 Updated [current date] by project-scanner: refreshed tech stack, architecture, current state sections.
```

6. **Preserve the original author's voice** — don't rewrite their prose style, just update the facts

Tell the user: `"I've updated docs/DOCS.md — X sections updated, Y sections added, Z sections left untouched (human-written content preserved)."`

---

## Token Efficiency Rules

- **Detect before reading.** The Step 1 shell commands cost ~300 tokens and replace reading 10+ files.
- **Read file-priority lists**, not whole directories.
- **Skim test files** — read just the `describe()`/`test()`/`it()` names, not the bodies.
- **Stop reading a category early** when you have enough signal.
- **Never read** `package-lock.json`, `yarn.lock`, `*.lock`, `node_modules/`, build artifacts.
- **Use the depth limit table** in Step 2 — don't read more lines than the mode allows.
- **One representative feature** is more informative than skimming 20 features shallowly.
- **Confidence tags** replace the need to hedge every sentence with caveats.
