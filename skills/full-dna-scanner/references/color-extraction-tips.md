# Color Extraction Tips — Advanced Cases
# Full DNA Scanner reference — used in Phase 2A when standard extraction is insufficient

## When to Read This File
Read this file when you encounter any of these situations:
- CSS is minified and color variables are unreadable
- Site uses CSS-in-JS (styled-components, Emotion, Stitches)
- Site uses Tailwind with no custom config visible
- Colors appear in SVG fills/strokes
- Colors are defined in JS theme objects, not CSS
- Site uses oklch / hsl / color-mix() modern color functions
- Multiple themes (light + dark) are present

---

## Case 1: Minified CSS

When the CSS is minified, readable variable names are gone. Extract colors by:

**Method A — Hex frequency scan**
Scan the entire minified CSS string for hex patterns: `#[0-9a-fA-F]{3,6}`
List every unique hex value found. Sort by frequency (most used = most important).
The top 5–10 by frequency are almost always the core color palette.

**Method B — RGB/HSL pattern scan**
Also scan for: `rgb\(\d+,\s*\d+,\s*\d+\)` and `hsl\(\d+,\s*\d+%,\s*\d+%\)`
Convert to hex for the palette.

**Method C — Context clues**
Even minified CSS preserves property names. Look for:
- `background:` or `background-color:` → surface colors
- `color:` → text colors
- `border-color:` or `border:` → border colors
- `fill:` or `stroke:` → SVG/icon colors

**Output note:** Mark as `source: "minified — inferred from frequency analysis"`

---

## Case 2: CSS-in-JS (styled-components, Emotion, Stitches, vanilla-extract)

**Detection:** Class names like `sc-abc123`, `css-xK2mP`, or `_1a2b3c`

**Extraction strategy:**
1. Look for a theme object in JS files — often exported as `theme.js` or `tokens.js`
   Search for: `const theme = {`, `export const colors = {`, `tokens = {`
2. If found, extract the color object — this is the design token layer
3. If not found, inspect inline styles on rendered elements (look for `style=""` attributes
   with color values injected by CSS-in-JS at runtime)
4. Check for a `<style>` tag injected in `<head>` by CSS-in-JS — often contains all
   generated class styles and is readable even when source is obfuscated

**Note in output:** "Site uses CSS-in-JS — colors extracted from theme object / generated
style tag. Some dynamic colors may not be captured."

---

## Case 3: Tailwind with No Visible Config

When Tailwind is detected but no `tailwind.config.js` is visible in the source:

**Step 1 — Scan for arbitrary values**
Tailwind arbitrary value syntax: `bg-[#1a1a2e]`, `text-[#ff5500]`, `border-[#2a2a2a]`
Extract every hex inside square brackets — these are always custom/intentional colors.

**Step 2 — Map utility classes to palette**
Common Tailwind color classes → known hex values:
- `bg-white` → #ffffff
- `bg-black` → #000000
- `bg-gray-900` → #111827
- `bg-gray-800` → #1f2937
- `bg-zinc-900` → #18181b
- `bg-zinc-800` → #27272a
- `text-gray-400` → #9ca3af
- `text-zinc-400` → #a1a1aa
- `bg-blue-600` → #2563eb
- `bg-indigo-500` → #6366f1
- `bg-purple-600` → #9333ea

Full Tailwind color reference: https://tailwindcss.com/docs/customizing-colors

**Step 3 — Flag which are custom vs. Tailwind defaults**
- Arbitrary values `[#hex]` → always `intentional: true`
- Named Tailwind classes → `framework_default: true` but still include in palette

---

## Case 4: SVG Colors

SVG fills and strokes are often brand colors but live outside CSS.

**Where to look:**
- Inline SVGs in HTML: `<svg>` tags with `fill="#hex"` or `stroke="#hex"` attributes
- CSS `fill:` and `stroke:` properties on SVG elements
- `currentColor` keyword → means the SVG inherits its parent's `color` property
  (document this: "icon uses currentColor — inherits from parent text color")

**What to extract:**
```yaml
svg_colors:
  - value: "#6366f1"
    element: "logo SVG path"
    property: "fill"
    note: "Brand logo fill — same as primary"

  - value: "currentColor"
    element: "nav icons, button icons"
    note: "Inherits parent text color — renders as white on dark background"

  - value: "#e22718"
    element: "alert icon"
    property: "fill"
    note: "Error/danger color in icon form"
```

---

## Case 5: JavaScript Theme Objects

Some sites define their entire color system in JS (common with React + Chakra, MUI, or
custom theme providers).

**Where to look:**
- Files named: `theme.js`, `theme.ts`, `tokens.js`, `colors.js`, `design-tokens.js`
- Search in JS for: `colors:`, `palette:`, `theme = {`, `colorScheme`
- MUI: `createTheme({ palette: { primary: { main: '#hex' } } })`
- Chakra: `extendTheme({ colors: { brand: { 500: '#hex' } } })`

**Extract the entire color object** — this is the most complete color documentation possible.

```yaml
js_theme_colors:
  source: "theme.js createTheme() call"
  palette:
    primary:
      main: "#6366f1"
      light: "#818cf8"
      dark: "#4f46e5"
      contrastText: "#ffffff"
    secondary:
      main: "#06b6d4"
    background:
      default: "#0f0f0f"
      paper: "#1a1a1a"
    text:
      primary: "#ffffff"
      secondary: "#a1a1aa"
      disabled: "#52525b"
```

---

## Case 6: Modern Color Functions (oklch, hsl, color-mix)

Modern CSS uses perceptual color functions. Extract and convert:

**oklch** → used by Tailwind v4 and modern design systems
- Example: `oklch(0.5 0.2 270)` → a medium purple
- Note the values in the output as-is; also convert to hex for compatibility
- Conversion tool: https://oklch.com/

**hsl** → common in custom properties
- Example: `hsl(239, 84%, 67%)` → #6366f1
- Convert to hex for the palette; keep original hsl noted
```yaml
- value_original: "hsl(239, 84%, 67%)"
  value_hex: "#6366f1"
  usage: "primary brand color"
```

**color-mix()** → CSS blending (newer browsers)
- Example: `color-mix(in srgb, #6366f1 50%, transparent)` → 50% opacity indigo
- Document as: `"50% opacity variant of primary (#6366f1)"`

---

## Case 7: Light + Dark Mode

When a site supports both modes, extract both color sets completely.

**Pattern 1 — CSS custom properties with media query override:**
```css
:root { --color-bg: #ffffff; --color-text: #0f0f0f; }
@media (prefers-color-scheme: dark) {
  :root { --color-bg: #0f0f0f; --color-text: #ffffff; }
}
```

**Pattern 2 — Data attribute toggle:**
```css
:root[data-theme="light"] { --color-bg: #ffffff; }
:root[data-theme="dark"] { --color-bg: #0f0f0f; }
```

**Pattern 3 — Separate CSS files:**
- `theme-light.css` and `theme-dark.css` loaded conditionally

**Output format:**
```yaml
color_mode:
  default: "dark"  # what loads first / without preference
  supports_light: true

  dark_mode:
    canvas: "#0f0f0f"
    surface-card: "#1a1a1a"
    text-primary: "#ffffff"
    text-body: "#a1a1aa"
    border: "#27272a"
    primary: "#6366f1"

  light_mode:
    canvas: "#ffffff"
    surface-card: "#f4f4f5"
    text-primary: "#0f0f0f"
    text-body: "#52525b"
    border: "#e4e4e7"
    primary: "#4f46e5"  # often slightly darker in light mode for contrast
```

---

## Color Naming Convention for Output

When naming extracted colors that have no CSS variable name, use this convention:

**By role:**
- `canvas` — page/body background
- `surface-card` — card/panel background
- `surface-elevated` — modal/popover/dropdown
- `surface-soft` — subtle section divider, hover state background
- `text-primary` — headlines and primary text
- `text-body` — body paragraph text
- `text-muted` — captions, placeholders, footer links
- `text-inverse` — text on light surface (if site has light sections)
- `border-default` — standard divider/border
- `border-strong` — emphasized border
- `primary` — main brand/action color
- `primary-hover` — primary on hover (usually slightly darker or lighter)
- `primary-subtle` — low-opacity variant of primary (backgrounds, highlights)
- `accent` — secondary brand color (if present)
- `success` — positive semantic
- `error` — negative semantic / danger
- `warning` — caution semantic
- `info` — informational semantic

**Naming priority:**
1. Use the site's own CSS variable name if it has one (`--color-primary` → `primary`)
2. Use the role-based name above if no variable exists
3. If neither applies, use a descriptive name: `motorsport-red`, `carbon-gray`
