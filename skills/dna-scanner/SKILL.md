---
name: dna-scanner
description: >
  Reverse-engineer any website's design DNA from its HTML source code. Use this skill whenever
  the user provides raw HTML source, a URL, or a page source snippet and wants to extract design
  structure, layout, spacing, typography, animations, or components — and then rebuild it using
  their own brand colors and content. Trigger when the user says: "scan this site", "extract styles
  from this page", "clone this layout", "reverse engineer this design", "copy the structure of this
  site", "analyze this HTML", or pastes raw HTML/CSS. Also trigger when the user provides a brand
  doc (YAML, PDF, text) alongside site source and wants a merged output. Trigger even for partial
  sources — a nav snippet, a single component, a CSS file alone. This skill is AI-universal:
  outputs work with Claude, GPT, Gemini, or any assistant. Never skip this skill when HTML/CSS is
  pasted — always use it.
---

# DNA Scanner

Reverse-engineer a website's complete design system from its source code — then rebuild it
with the user's own brand, colors, and content.

**The core problem this solves:** Naively reading an entire site wastes tokens on noise
(analytics scripts, vendor bundles, tracking pixels, minified frameworks). This skill scans
*selectively* — only the assets and code patterns that carry real design decisions, in a
prioritized order, stopping as soon as each design question is answered.

---

## Phase 0 — Gather Inputs Before Scanning

Collect these before doing any analysis:

1. **Site source** — Raw HTML pasted by user, or a URL to fetch
2. **Brand input** — One of:
   - A brand doc (YAML / PDF / plain text) with their colors, fonts, spacing
   - Inline instructions: "my primary color is #FF5500, I use Inter"
   - Nothing yet → proceed with scan, ask for brand input at the very end
3. **Scope** — Full page, or a specific component? Default: full page.

If only HTML is pasted with no brand info, start the scan immediately. Ask for brand
input after Phase 3, before generating output in Phase 4.

---

## Phase 1 — Triage the Source (Do This Before Reading Anything)

Not all source code carries design signal. Before fetching or reading any file, classify
every resource in the HTML `<head>` and `<body>` by priority:

### Priority Tiers

**TIER 1 — Read First (always)**
- Inline `<style>` blocks inside the HTML
- CSS custom properties / variables (`--color-*`, `--spacing-*`, `--font-*`)
- `<link rel="stylesheet">` pointing to the site's own domain (not CDN frameworks)
- Inline `style=""` attributes on key structural elements (nav, hero, section, footer)
- `@import` declarations inside CSS files

**TIER 2 — Read If Tier 1 is incomplete**
- External CSS on the same domain: `/styles/main.css`, `/assets/css/*.css`, `design-tokens.css`
- CSS modules or component CSS files referenced in HTML
- `<link rel="preload">` font declarations
- Google Fonts `@import` URLs → extract family name + weights only, do NOT read the full font CSS

**TIER 3 — Scan selectively (extract patterns only, do not read fully)**
- JS files that contain animation logic: look for keywords `gsap`, `anime`, `framer`,
  `aos`, `lottie`, `scrollTrigger`, `IntersectionObserver`, `transition`, `keyframes`
- If found: extract only the animation/transition blocks, ignore the rest
- Framework detection: check for `tailwind`, `bootstrap`, `chakra`, `material` imports →
  note which framework, do NOT read framework source

**TIER 4 — Skip entirely (never read)**
- Google Analytics, GTM, Meta Pixel, Hotjar, Segment, Mixpanel scripts
- `<script>` tags pointing to `cdn.`, `analytics.`, `tracking.`, `ads.`
- Service worker registrations
- Any file > 500KB (note its existence, skip content)
- Sourcemap files (`.map`)
- Vendor bundles (`vendor.js`, `chunk-*.js`, `runtime.js`)

Log skipped files briefly:
> "Skipped: google-analytics.js (tracking), vendor.bundle.js (framework noise)"

---

## Phase 2 — Structured Extraction

Work through each tier in order. For each file/block read, extract into these 9 categories:

### 2A — Color System
- All hex, rgb, hsl, oklch values found
- CSS custom property names for colors (`--color-primary`, `--brand-blue`)
- Usage context: which element/component uses which color
- Classify each: background / text / border / accent / brand / semantic
- Flag: intentional design color vs. framework default (e.g., Bootstrap's `#0d6efd`)

```yaml
colors_extracted:
  - token: "--color-primary"
    value: "#1a1a2e"
    usage: "nav background, hero background"
    classification: "surface/brand"
    intentional: true
  - token: "unnamed"
    value: "#f5f5f5"
    usage: "card background (inline style on .card)"
    classification: "surface/soft"
    intentional: true
```

### 2B — Typography System
- Font families: name, source (Google Fonts / self-hosted / system)
- Weights used: list all `font-weight` values per family
- Size scale: all `font-size` values, sorted ascending, note which element uses which
- Line heights, letter spacing values
- Text transform patterns (uppercase / capitalize)
- Detect weight-pairing pattern (e.g., heavy headline + light body)

```yaml
typography_extracted:
  families:
    - name: "Sora"
      source: "Google Fonts"
      weights: [400, 600, 700]
  scale:
    - size: 64px, weight: 700, usage: "h1 hero"
    - size: 18px, weight: 400, usage: "body paragraphs"
  patterns:
    - "Headlines uppercase + letterspaced 2px"
    - "Heavy/Light weight contrast: 700 display vs 300 body"
```

### 2C — Spacing & Layout System
- All `padding`, `margin`, `gap` values — find repeating values (these are the spacing scale)
- Grid systems: `display: grid`, `grid-template-columns`, column counts at each breakpoint
- Flexbox patterns on key containers
- Max-width / container width values
- Section padding rhythm (vertical spacing between major page sections)
- Detect base unit (4px / 8px / 10px grid)

### 2D — Component Inventory
Walk the HTML structure and identify every distinct UI component. For each:
- Name it (navbar, hero-band, feature-card, spec-table, cta-section, footer)
- Note its HTML structure (wrapper → children pattern)
- Extract its key styles: background, text color, padding, border-radius, border
- Note any hover/focus/active state styles

Minimum components to always look for:
`top-nav` · `hero` · `section-heading` · `card` · `button-primary` · `button-secondary`
`text-link` · `divider` · `input` · `footer` · `modal/overlay` (if present)

### 2E — Border Radius & Shape Language
- All `border-radius` values used across components
- Classify the shape language:
  - **Sharp** (0px dominant) → precision / industrial
  - **Soft** (8–16px dominant) → friendly / modern SaaS
  - **Pill** (9999px dominant) → playful / consumer
  - **Mixed** → note which components use which radius and why
- The shape language is one of the strongest design-voice signals — call it out explicitly

### 2F — Animation & Motion Catalog
For each animation found in CSS or JS:

```yaml
animations_extracted:
  - name: "hero-fade-in"
    type: "CSS keyframe"
    trigger: "page load"
    duration: "0.6s"
    easing: "ease-out"
    properties: ["opacity", "translateY(-20px) → translateY(0)"]
    library: null

  - name: "card-hover-lift"
    type: "CSS transition"
    trigger: "hover"
    duration: "0.3s"
    easing: "cubic-bezier(0.4, 0, 0.2, 1)"
    properties: ["transform: translateY(-4px)", "box-shadow"]
    library: null

  - name: "scroll-reveal"
    type: "JS"
    trigger: "IntersectionObserver / scroll into view"
    library: "AOS"
    pattern: "fade-up 0.5s ease on viewport entry"
```

If a JS animation library is detected (GSAP, Framer Motion, AOS, Anime.js, Lottie):
- Name the library and version if visible
- Describe the animation pattern in plain English
- Do NOT attempt to read the full library source — just note the usage pattern

### 2G — Responsive Breakpoints
- Extract all `@media` queries, list breakpoint values
- For each breakpoint, note what changes: column counts, font sizes, nav behavior, component reflow
- Document the collapsing strategy for nav, grids, hero text

```yaml
breakpoints:
  - at: 768px
    label: "tablet"
    changes:
      - "nav collapses to hamburger"
      - "3-col card grid → 1-col stack"
      - "hero h1: 64px → 36px"
  - at: 1024px
    label: "desktop"
    changes:
      - "2-col grid → 3-col"
      - "hero gets side-by-side text+image layout"
```

### 2H — Asset Map
- List all images / SVGs / icons referenced in HTML or CSS
- Classify each: logo / hero-bg / card-image / icon / decorative / pattern / texture
- Note dimensions if specified (width/height attributes or CSS background-size)
- Flag which assets the user MUST replace with their own

```yaml
assets:
  - role: "site logo"
    src: "/images/logo.svg"
    replace: true
    note: "SVG — provide your own logo"
  - role: "hero background"
    src: "/images/hero-bg.jpg"
    replace: true
    note: "16:9 full-bleed photo. Replace with your own."
  - role: "decorative divider"
    src: "/images/wave.svg"
    replace: false
    note: "Generic SVG — can keep or replace"
```

### 2I — Framework & Dependency Detection
Before reading any CSS in detail, detect if a CSS framework is in use:
- **Tailwind**: utility class patterns (`flex`, `gap-4`, `text-xl`, `rounded-lg`, `bg-gray-900`)
- **Bootstrap**: `.container`, `.row`, `.col-`, `.btn`, `.navbar`
- **Chakra / MUI / Ant Design**: component class prefixes (`chakra-`, `MuiButton-`, `ant-`)
- **Custom only**: no framework class patterns → everything is intentional design

If a framework is detected:
- Note it clearly at the top of the output
- When extracting, focus on *overrides and custom tokens*, not framework defaults
- Mark custom values with ★ to distinguish them from framework defaults
- Example note: "This site uses Tailwind — base spacing is Tailwind's 4px scale. Custom brand
  overrides are marked ★"

---

## Phase 3 — Conflict Resolution & Signal vs. Noise

After extraction, review for these three issues before writing output:

### CSS Override Chains
- If a property is set multiple times on the same element, keep only the final computed value
- Flag `!important` uses: note them as "forced override — likely a patch, not a design decision"

### Framework Defaults vs. Intentional Design
- If a color matches a known framework default exactly (Bootstrap `#0d6efd`, Tailwind `#3b82f6`),
  mark `intentional: false` unless it's used consistently as the brand color
- If spacing values match Tailwind's exact scale (4, 8, 12, 16, 20, 24px...), note:
  "likely Tailwind spacing, not a custom token — confirm with user before adopting"

### Minified / Obfuscated Code
- If CSS/JS is minified, extract by pattern and frequency, not by variable names
- Repeated numeric values → spacing scale candidates
- Repeated hex codes → color system candidates
- Repeated class shapes (`.a { display:flex; gap:16px }`) → component patterns
- Always note: "Source was minified — values inferred from frequency analysis"

---

## Phase 4 — Brand Merge

Now apply the user's brand inputs over the extracted structure.

### Rule: Structure belongs to the source. Brand belongs to the user.

| Extracted from source → KEEP | User brand input → REPLACE |
|---|---|
| Spacing scale | Colors |
| Component HTML structure | Font families |
| Grid layout patterns | Font weights (if specified) |
| Animation timings & easing | Logo & images |
| Breakpoint values | Content & copy |
| Border radius language | Brand-specific tokens |
| Component hierarchy | |

### If user provided a brand doc (YAML / PDF / text):
- Map their brand colors → replace every extracted color with the nearest brand token
- Map their fonts → replace extracted font families
- Keep their border-radius preference if specified, otherwise keep extracted
- Note every token replaced: "→ replaced with user's `{colors.primary}`"

### If user provided inline instructions:
- Apply the same mapping
- Where they haven't specified something (e.g., border-radius), keep extracted value
  and add note: "Kept from source — override if needed"

### If no brand input yet:
- Output extracted YAML with clear placeholders:
  ```yaml
  colors:
    primary: "← YOUR PRIMARY COLOR (e.g. #FF5500)"
    canvas: "← YOUR BACKGROUND COLOR"
    on-dark: "← YOUR PRIMARY TEXT COLOR"
  ```
- Add a "Brand Input Needed" section listing every unfilled token

---

## Phase 5 — Final Output

Always produce exactly two documents, clearly separated:

---

### DOCUMENT 1: Design Token YAML

Header block first:
```yaml
# ═══════════════════════════════════════════════════
# [Site Name] — Design DNA
# Extracted by: DNA Scanner
# Source: [URL or "user-pasted HTML"]
# Framework detected: [Tailwind v3 / Bootstrap 5 / None]
# Brand applied: [user's brand name / "Placeholders — brand input needed"]
# AI-ready: paste this doc as context into Claude, GPT, or Gemini
# ═══════════════════════════════════════════════════

## Overview
[3–5 sentence plain-English description of the site's design language:
 shape language, color mood, typography voice, animation style, overall feel.
 This is what a designer would say at a glance.]

colors:
  [all color tokens, user's values applied]

typography:
  [full scale with all tokens]

spacing:
  base-unit: [4px / 8px / etc]
  [all spacing tokens]

rounded:
  [all radius tokens + shape language label]

components:
  [each component with its full token set]

animations:
  [full motion catalog]

breakpoints:
  [all breakpoints with change descriptions]

assets_to_replace:
  [full asset map, replace:true items only]

do_not_copy:
  [list of Tier 4 items found — tracking scripts, vendor bundles]

notes:
  framework: [detected framework or null]
  minified: [true/false]
  intentional_overrides: [list of ★ custom values if framework was detected]
```

---

### DOCUMENT 2: Implementation Guide

Plain-language rebuild instructions:

**1. Install these fonts**
[exact Google Fonts URLs or npm package names]

**2. Include these animation libraries**
[CDN links for any detected JS animation libs, or "none needed"]

**3. Build in this order**
[component build sequence: tokens → base styles → nav → hero → content sections → footer]

**4. Framework recommendation**
[if source used Tailwind → "Use Tailwind for rebuild, config file below"
 if custom CSS → "Pure CSS or your preferred framework"]

**5. Gotchas & quirks found**
[anything tricky: z-index stacking, sticky positioning, CSS Grid subgrid, clip-path shapes,
 backdrop-filter, custom scroll behavior, etc.]

**6. Replace these assets**
[checklist of images/icons to swap out]

**7. Animations to implement**
[step-by-step for each animation: what library/approach, when it triggers, what it does]

---

## Efficiency Rules (Non-Negotiable)

- **Stop reading a file the moment the design question is answered.** Don't scan 500 lines for 3 color values.
- **Deduplicate aggressively.** `padding: 24px` appearing 40 times = one spacing token.
- **Estimate before fetching.** `analytics.min.js` → skip without opening.
- **Never read framework source.** Bootstrap linked → note it, read nothing from it.
- **Batch all questions.** If you need user input, ask everything in one message.
- **Large source warning.** If HTML is 100KB+, tell user: "Large source detected. Scanning Tier 1
  inline styles first. Say 'go deeper' to fetch external CSS files."
- **Token budget discipline.** Prioritize breadth (all components identified) over depth
  (every CSS property of one component). The YAML can have `[to extract]` placeholders.

---

## AI-Universal Design

This skill's output is deliberately portable. The Design Token YAML + Implementation Guide
can be pasted as context into **any AI assistant** — Claude, GPT-4o, Gemini, Mistral —
and used immediately to generate accurate, on-brand UI code without re-scanning.

The output is:
- Human-readable (no special tooling needed)
- Self-contained (no external references required to use it)
- Structured (AI assistants parse YAML context reliably)
- Branded (user's values are already merged in)

---

## Reference Files

Read these when needed — do not preload all of them:

- `references/output-example.md` — Complete example of a finished DNA Scanner output
- `references/framework-signatures.md` — Class/import patterns for detecting CSS frameworks
- `references/animation-libraries.md` — Known animation library signatures, CDN links, usage patterns
