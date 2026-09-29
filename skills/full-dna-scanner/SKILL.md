---
name: full-dna-scanner
description: >
  Reverse-engineer any website's complete design DNA — including its exact original color system —
  from its HTML source code, and produce a faithful clone scaffold using the site's own colors,
  not the user's brand. Use this skill when the user wants to copy a site's look exactly, study
  its design system, or build a near-identical clone. Trigger when the user says: "clone this
  site exactly", "copy this design as-is", "scan and replicate this", "extract the full design
  including colors", "I want the same colors they use", "reverse engineer this site completely",
  or pastes HTML and does NOT mention their own brand colors. This is the full-fidelity variant
  of dna-scanner — it preserves the source site's color palette exactly instead of replacing
  with user brand. AI-universal: outputs work with Claude, GPT, Gemini, or any assistant.
---

# Full DNA Scanner

A full-fidelity variant of dna-scanner. Extracts the complete design system of any website
from its source code — and preserves the **site's own colors exactly** in the output.

**Key difference from dna-scanner:**
- `dna-scanner` → extracts structure, replaces colors with the user's brand
- `full-dna-scanner` → extracts everything AND keeps the site's original colors faithfully

**When to use this vs. dna-scanner:**

| Use `full-dna-scanner` when... | Use `dna-scanner` when... |
|---|---|
| User wants to clone a site's look exactly | User wants the layout but their own brand |
| Studying/auditing a competitor's design system | Building something inspired by a site |
| No brand doc provided, colors should stay as-is | User provides brand colors/doc |
| User says "same colors they use" | User says "my colors are..." |

---

## Phase 0 — Gather Inputs Before Scanning

Collect before starting:

1. **Site source** — Raw HTML pasted, or a URL to fetch
2. **Scope** — Full page, or a specific component? Default: full page
3. **Color fidelity mode** — Already set: **PRESERVE SOURCE COLORS** (no brand merge)
4. **Content** — User may provide their own text/copy to slot into the cloned structure.
   If not provided, output uses placeholder text (`[YOUR HEADLINE]`, `[YOUR BODY COPY]`).

> **Do NOT ask for brand colors.** This skill preserves the source site's colors.
> If the user volunteers brand colors mid-scan, note them separately at the bottom of
> the output under `optional_brand_override` but do not apply them to the main output.

---

## Phase 1 — Triage the Source (Do This Before Reading Anything)

Classify every resource by priority before fetching anything:

### Priority Tiers

**TIER 1 — Read First (always)**
- Inline `<style>` blocks inside the HTML
- CSS custom properties / variables (`--color-*`, `--spacing-*`, `--font-*`)
- `<link rel="stylesheet">` on the site's own domain
- Inline `style=""` attributes on structural elements (nav, hero, section, footer)
- `@import` declarations inside CSS files
- `<meta name="theme-color">` — often reveals brand primary color

**TIER 2 — Read If Tier 1 is incomplete**
- External CSS on same domain: `/styles/main.css`, `/assets/css/*.css`, `design-tokens.css`
- CSS modules or component CSS files
- `<link rel="preload">` font declarations
- Google Fonts URLs → extract family name + weights only

**TIER 3 — Scan selectively**
- JS animation files: look for `gsap`, `anime`, `framer`, `aos`, `lottie`,
  `scrollTrigger`, `IntersectionObserver`, `transition`, `keyframes`
- Extract animation blocks only, skip everything else
- Framework detection: `tailwind`, `bootstrap`, `chakra`, `material` → note, don't read source

**TIER 4 — Skip entirely**
- Google Analytics, GTM, Meta Pixel, Hotjar, Segment, Mixpanel
- Scripts on `cdn.`, `analytics.`, `tracking.`, `ads.` domains
- Service workers
- Files > 500KB
- Sourcemaps (`.map`)
- Vendor bundles (`vendor.js`, `chunk-*.js`, `runtime.js`)

Log skips briefly:
> "Skipped: gtag.js (tracking), vendor.bundle.js (framework noise)"

---

## Phase 2 — Structured Extraction

### 2A — Color System (FULL FIDELITY — Preserve Everything)

This is the most important phase difference from dna-scanner.

Extract ALL color values with maximum detail:

**Step 1 — CSS Custom Properties (highest priority)**
Scan for `:root { }` and any `[data-theme]` blocks. These are the site's intentional
design token layer — extract every single one.

```yaml
css_custom_properties:
  --color-primary: "#6366f1"
  --color-primary-hover: "#4f46e5"
  --color-primary-light: "#e0e7ff"
  --color-background: "#0f0f0f"
  --color-surface: "#1a1a1a"
  --color-text: "#ffffff"
  --color-text-muted: "#a1a1aa"
  --color-border: "#27272a"
  --color-success: "#22c55e"
  --color-error: "#ef4444"
  --color-warning: "#f59e0b"
```

**Step 2 — Named color values in CSS rules**
For every color value found outside of custom properties:
- Record the exact hex/rgb/hsl value
- Record the CSS selector it appears on
- Record the property (background, color, border-color, fill, stroke, etc.)
- Deduplicate: if the same hex appears 20 times, list it once with all its usages

```yaml
named_colors:
  - value: "#6366f1"
    usages: ["button.primary background", ".badge background", "a:hover color"]
    role: "primary/brand"
    intentional: true

  - value: "#0f0f0f"
    usages: ["body background", "nav background", ".hero background"]
    role: "canvas/base"
    intentional: true

  - value: "#ffffff"
    usages: ["h1 color", "h2 color", "nav links color", "button.primary text"]
    role: "on-dark text"
    intentional: true

  - value: "#a1a1aa"
    usages: ["p color", ".caption color", "footer text"]
    role: "body/muted text"
    intentional: true
```

**Step 3 — Gradient extraction**
Extract every gradient found (background-image, background):
```yaml
gradients:
  - name: "hero-bg"
    value: "linear-gradient(135deg, #6366f1 0%, #06b6d4 100%)"
    usage: ".hero background"

  - name: "card-border"
    value: "linear-gradient(180deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 100%)"
    usage: ".card::before border effect"
```

**Step 4 — Color palette summary**
After extracting all values, produce a clean deduplicated palette grouped by role:

```yaml
color_palette:
  # Primary brand colors (most frequently used / in CSS variables as primary)
  brand:
    primary: "#6366f1"
    primary-hover: "#4f46e5"
    primary-light: "#e0e7ff"
    accent: "#06b6d4"

  # Backgrounds / surfaces
  surfaces:
    canvas: "#0f0f0f"       # page background
    card: "#1a1a1a"         # card/panel background
    elevated: "#242424"     # modal/dropdown
    soft: "#111111"         # subtle section divider

  # Text
  text:
    primary: "#ffffff"      # headlines, primary text
    body: "#a1a1aa"         # body paragraphs
    muted: "#71717a"        # captions, footer links
    inverse: "#0f0f0f"      # text on light surfaces (if any)

  # Borders / lines
  borders:
    default: "#27272a"
    strong: "#3f3f46"

  # Semantic
  semantic:
    success: "#22c55e"
    error: "#ef4444"
    warning: "#f59e0b"
    info: "#3b82f6"

  # Gradients
  gradients:
    hero: "linear-gradient(135deg, #6366f1 0%, #06b6d4 100%)"
```

**Step 5 — Color mode detection**
- Is the site dark-mode only, light-mode only, or does it support both?
- Look for `prefers-color-scheme` media queries or `[data-theme="dark"]` / `[data-theme="light"]`
- If both modes exist, extract BOTH color sets

```yaml
color_mode:
  default: "dark"
  supports_light_mode: true
  light_mode_colors:
    canvas: "#ffffff"
    text-primary: "#0f0f0f"
    surface-card: "#f4f4f5"
    # ... etc
```

**Step 6 — Framework color filter**
After full extraction, flag any color that exactly matches a known framework default:
- Bootstrap primary `#0d6efd` → flag as `framework_default: true`
- Tailwind blue-500 `#3b82f6` → flag as `framework_default: true`
- Only flag if it appears ONLY in framework-generated contexts, not in custom CSS

> **Rule for full-dna-scanner:** Even `framework_default: true` colors are kept in the
> output if they are visually present on the site. The user is cloning what they SEE,
> not just what was custom-designed.

### 2B — Typography System
(Same as dna-scanner — see Phase 2B in references/dna-scanner-phases.md)

- Font families + sources + weights
- Full size scale with element usage
- Line heights, letter spacing
- Weight pairing pattern (heavy display vs light body)
- Text transform patterns

### 2C — Spacing & Layout System
(Same as dna-scanner)

- Repeating padding/margin/gap values → spacing scale
- Grid column patterns at each breakpoint
- Max-width values
- Section vertical rhythm
- Base unit detection

### 2D — Component Inventory
(Same as dna-scanner, but use SITE'S colors for all component tokens)

For each component, use the extracted site colors verbatim:
```yaml
button-primary:
  backgroundColor: "#6366f1"       # ← site's actual color, not a placeholder
  textColor: "#ffffff"
  hoverBackground: "#4f46e5"
  rounded: "9999px"
  padding: "12px 28px"
  height: 48px
```

### 2E — Border Radius & Shape Language
(Same as dna-scanner)

### 2F — Animation & Motion Catalog
(Same as dna-scanner)

### 2G — Responsive Breakpoints
(Same as dna-scanner)

### 2H — Asset Map
For full-dna-scanner, also note:
- Background image colors / dominant tones (these contribute to the color palette)
- SVG fill colors used in icons (extract them as color tokens if they're brand colors)
- Any CSS `background-color` used behind images (often the skeleton/loading color)

### 2I — Framework & Dependency Detection
(Same as dna-scanner)

---

## Phase 3 — Conflict Resolution & Signal vs. Noise

### CSS Override Chains
Same as dna-scanner: keep final computed value, flag `!important` as patches.

### Framework vs. Intentional — FULL-DNA-SCANNER RULE
Unlike dna-scanner, do NOT filter out framework default colors.
If a color is visually present on the page, it goes in the palette regardless of origin.
Only flag it with `framework_default: true` as an annotation — do not remove it.

### Minified / Obfuscated Code
Same as dna-scanner: extract by pattern and frequency.
For colors specifically: hex values are readable even in minified CSS — extract all of them.

### Color Deduplication Pass
After all extraction, do one final deduplication:
- Same hex value, multiple names → consolidate to one entry with all usages listed
- Near-duplicates (e.g., `#1a1a1a` and `#1b1b1b`) → list both, note "nearly identical —
  likely same intent, possible inconsistency in source"
- Opacity variants (`rgba(99,102,241,0.1)`) → link back to base color token

---

## Phase 4 — NO Brand Merge (Color Preservation Mode)

**Skip the brand merge entirely.** The site's colors ARE the output.

However, do the following:

### Content Placeholder Pass
Replace all text content from the source with user's content if provided, or placeholders:
- Headlines → `[YOUR HEADLINE]`
- Body paragraphs → `[YOUR BODY COPY]`
- Button labels → `[CTA TEXT]`
- Navigation items → `[NAV ITEM]`
- Image src values → keep original URL noted, but mark `[REPLACE WITH YOUR IMAGE]`

### Optional Brand Overlay Section
If user mentioned their own brand colors at any point, append at the very end:

```yaml
optional_brand_override:
  note: "User mentioned these brand colors. Apply manually if desired."
  user_primary: "#FF5500"
  suggested_replacements:
    - site_color: "#6366f1"  # site's primary
      replace_with: "#FF5500"  # user's brand
      affects: ["button-primary", "badge", "links"]
```

This keeps the main output clean while giving users a migration path.

---

## Phase 5 — Final Output

Produce exactly two documents:

---

### DOCUMENT 1: Full Design Token YAML

```yaml
# ═══════════════════════════════════════════════════
# [Site Name] — Full Design DNA (Color-Faithful Clone)
# Extracted by: Full DNA Scanner
# Source: [URL or "user-pasted HTML"]
# Color mode: [site's original colors preserved exactly]
# Framework detected: [Tailwind v3 / Bootstrap 5 / None]
# AI-ready: paste this doc as context into Claude, GPT, or Gemini
# ═══════════════════════════════════════════════════

## Overview
[3–5 sentence description: color mood (warm/cool/neutral, light/dark), typography voice,
 shape language, animation character. Written so a developer can instantly "feel" the site
 without seeing it.]

## Color System
[Full color_palette block — all roles filled with real site values]
[css_custom_properties block — all :root variables]
[gradients block]
[color_mode block]

## Typography
[Full type scale]

## Spacing
[Full spacing scale + base unit]

## Border Radius
[All radius values + shape language classification]

## Components
[Every component with site's actual color values — no placeholders in color fields]

## Animations
[Full motion catalog]

## Breakpoints
[All responsive breakpoints]

## Assets
[Full asset map — images, icons, SVGs]

## Do Not Copy
[Tier 4 items: tracking scripts, vendor bundles]

## Notes
  framework: [detected or null]
  minified: [true/false]
  color_mode: [dark-only / light-only / both]
  near_duplicate_colors: [list any flagged near-duplicates]
  framework_default_colors: [list any framework colors that were kept because visually present]

## Optional Brand Override
[If user mentioned brand colors — suggested replacement mapping]
```

---

### DOCUMENT 2: Clone Implementation Guide

**1. Install these fonts**
[Exact Google Fonts URLs or npm packages]

**2. Set up your color tokens**
[CSS custom properties block — ready to paste into `:root {}`]
```css
:root {
  --color-primary: #6366f1;
  --color-primary-hover: #4f46e5;
  --color-canvas: #0f0f0f;
  --color-surface-card: #1a1a1a;
  --color-text: #ffffff;
  --color-text-muted: #a1a1aa;
  /* ... all tokens ... */
}
```

**3. Include animation libraries**
[CDN links for detected JS animation libs]

**4. Build in this order**
CSS tokens → Reset/base → Typography → Nav → Hero → Content sections → Footer

**5. Framework recommendation**
[Match what the source used for easiest replication]

**6. Color gotchas**
- Any `rgba()` opacity variants that need the base color token
- Gradient reproduction notes
- Dark/light mode switching if applicable
- Any near-duplicate colors to resolve

**7. General gotchas**
[z-index stacks, sticky elements, clip-paths, backdrop-filter, scroll behaviors]

**8. Content to replace**
[Checklist of placeholder text and image swaps]

**9. Animations to implement**
[Step-by-step for each animation found]

---

## Efficiency Rules (Non-Negotiable)

- **Stop reading a file the moment the design question is answered.**
- **Deduplicate aggressively** — same hex 40 times = one token entry.
- **Estimate before fetching** — `analytics.min.js` → skip without opening.
- **Never read framework source** — detect it, note it, move on.
- **Batch all questions** — never interrupt mid-scan.
- **Large source warning** — HTML > 100KB: "Large source. Scanning Tier 1 first. Say 'go deeper' for external CSS."
- **Color extraction is non-negotiable** — even if everything else is incomplete, the color palette must be fully extracted. It's the #1 deliverable of this skill.

---

## AI-Universal Design

Output is portable — paste the YAML into Claude, GPT, Gemini, or Mistral as design context.
The color token block is especially useful: paste the CSS `:root {}` block directly into
any frontend project and have working color tokens immediately.

---

## Reference Files

Read when needed:

- `references/output-example.md` — Full worked example of a complete scan output
- `references/framework-signatures.md` — Framework detection patterns
- `references/animation-libraries.md` — Animation library signatures + CDN links
- `references/color-extraction-tips.md` — Advanced color extraction for tricky cases
  (minified CSS, CSS-in-JS, Tailwind arbitrary values, SVG fills)
