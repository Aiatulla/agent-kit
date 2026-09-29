# Framework Detection Signatures
# DNA Scanner reference — used in Phase 1 Tier 3 detection

## How to Use
Scan the HTML source for these patterns BEFORE reading any CSS file.
If a match is found, note the framework and do NOT read the framework's source files.
Focus extraction on custom overrides only (marked ★ in output).

---

## Tailwind CSS

**Detection signals (any 3+ = confirmed):**
- Class patterns: `flex`, `grid`, `gap-{n}`, `p-{n}`, `m-{n}`, `text-{size}`, `font-{weight}`
- Color classes: `bg-gray-900`, `text-white`, `border-zinc-700`, `text-purple-500`
- Responsive prefixes: `md:`, `lg:`, `sm:`, `xl:` before class names
- `tailwind.config.js` or `tailwind.css` in linked files
- `<link href="...tailwind...">` in head
- CDN: `cdn.tailwindcss.com` or `unpkg.com/tailwindcss`

**Version detection:**
- v3: `@layer base`, `@layer components`, `@apply` in CSS
- v2: similar but without JIT-specific utilities like `arbitrary values [#hex]`
- v4: `@import "tailwindcss"` (new syntax)

**What to extract:** Only values that OVERRIDE Tailwind defaults:
- Custom colors in `tailwind.config.js` `theme.extend.colors`
- Custom fonts in `theme.extend.fontFamily`
- Custom spacing in `theme.extend.spacing`
- CSS variables defined in `@layer base { :root { --custom-var } }`
- Arbitrary values in square brackets: `bg-[#1a1a2e]` → extract `#1a1a2e`

**Tailwind default spacing scale (do NOT treat as custom tokens):**
0, 1(4px), 2(8px), 3(12px), 4(16px), 5(20px), 6(24px), 8(32px), 10(40px), 12(48px),
16(64px), 20(80px), 24(96px), 32(128px)

**Tailwind default color palette (mark as `intentional: false` unless used as brand):**
slate, gray, zinc, neutral, stone, red, orange, amber, yellow, lime, green, emerald,
teal, cyan, sky, blue, indigo, violet, purple, fuchsia, pink, rose

---

## Bootstrap

**Detection signals:**
- `bootstrap.css` or `bootstrap.min.css` in `<link>` tags
- Class patterns: `.container`, `.row`, `.col-md-{n}`, `.col-lg-{n}`
- Component classes: `.btn`, `.btn-primary`, `.navbar`, `.card`, `.modal`, `.form-control`
- JS: `bootstrap.bundle.js` or `bootstrap.min.js`
- CDN: `cdn.jsdelivr.net/npm/bootstrap`

**Version detection:**
- v5: `data-bs-*` attributes (e.g., `data-bs-toggle="modal"`)
- v4: `data-toggle`, `data-target` attributes

**Bootstrap default colors (mark `intentional: false`):**
- Primary: `#0d6efd`
- Secondary: `#6c757d`
- Success: `#198754`
- Danger: `#dc3545`
- Warning: `#ffc107`
- Dark: `#212529`

**What to extract:** Only `_custom.scss` overrides or CSS variables in `:root` that
override Bootstrap's defaults. These are the brand layer.

---

## Material UI (MUI) / React

**Detection signals:**
- Class prefixes: `MuiButton-root`, `MuiTypography-`, `MuiCard-`, `MuiGrid-`
- `@mui/material` in script sources or import patterns
- CSS variables: `--mui-palette-primary-main`
- `emotion` or `styled-components` class patterns: `css-{hash}`

**What to extract:**
- Theme overrides in `createTheme()` — look for `palette.primary.main`, `typography.fontFamily`
- These are usually in a `theme.js` or `theme.ts` file

---

## Chakra UI

**Detection signals:**
- Class prefixes: `chakra-button`, `chakra-text`, `chakra-stack`
- CSS variables: `--chakra-colors-brand-500`, `--chakra-fonts-heading`
- `@chakra-ui` in script sources

**What to extract:** `extendTheme()` config — `colors.brand`, `fonts.heading`, `fonts.body`

---

## Ant Design

**Detection signals:**
- Class prefixes: `ant-btn`, `ant-card`, `ant-layout`, `ant-table`
- `antd.css` or `antd.min.css` in links
- `@ant-design/icons` patterns

**What to extract:** `ConfigProvider` theme tokens — `colorPrimary`, `borderRadius`, `fontFamily`

---

## Framer (framer.com sites)

**Detection signals:**
- `framer.com` in script sources
- Class patterns: `framer-*`
- `__framer_*` global variables
- `motion` package imports

**Note:** Framer sites are heavily obfuscated. Extract colors from inline styles only.
Animation patterns: assume Framer Motion with spring physics — note this in output.

---

## Webflow

**Detection signals:**
- `webflow.js` in scripts
- `w-` class prefixes: `w-nav`, `w-container`, `w-section`, `w-button`
- `cdn.prod.website-files.com` in asset URLs
- `data-wf-*` attributes

**What to extract:**
- CSS variables in `:root` (Webflow Designer exports these cleanly)
- Custom class styles in `webflow.css`
- Ignore `normalize.webflow.css` — that's Webflow's reset

---

## WordPress (Theme-based)

**Detection signals:**
- `/wp-content/themes/{theme-name}/` in CSS/JS paths
- `wp-includes` in script sources
- `?ver={version}` query parameters on assets
- Generator meta tag: `<meta name="generator" content="WordPress">`

**What to extract:**
- Theme's `style.css` (usually at `/wp-content/themes/{name}/style.css`)
- CSS variables in `:root` — modern themes use these heavily
- Block editor styles if Gutenberg is used

---

## Vue / Nuxt (SPA)

**Detection signals:**
- `__nuxt`, `__vue_app__`, `_nuxt/` in scripts
- `data-v-{hash}` scoped style attributes
- `nuxt.config` referenced anywhere

**What to extract:**
- Scoped styles on key components (look for `data-v-` attributes on nav, hero, cards)
- CSS variables in global `assets/css/main.css`

---

## Next.js / React (SPA)

**Detection signals:**
- `_next/static/` in script/style paths
- `__NEXT_DATA__` JSON in page source
- `data-nextjs-*` attributes

**What to extract:**
- Global CSS in `_next/static/css/*.css` — these are worth fetching
- CSS modules: class names like `Hero_hero__xK2mP` → extract the styles, ignore the hash

---

## No Framework Detected

If none of the above patterns are found:
- All CSS is intentional design → extract everything
- Class names will be semantic (`.hero`, `.nav`, `.card`) not utility-based
- This is the easiest case — full extraction, no filtering needed
- Note in output: "Framework: None detected — custom CSS, full extraction applied"
