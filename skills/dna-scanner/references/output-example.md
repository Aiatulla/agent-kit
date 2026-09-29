# DNA Scanner — Output Example
# Source: hypothetical SaaS landing page (stripe-like)
# For reference only — shows what a complete scan output looks like

---

# ═══════════════════════════════════════════════════
# AcmeSaaS.com — Design DNA
# Extracted by: DNA Scanner
# Source: https://acmesaas.com (user-pasted HTML)
# Framework detected: Tailwind v3 + custom CSS layer
# Brand applied: User brand doc ("NovaBrand") merged
# AI-ready: paste this doc as context into Claude, GPT, or Gemini
# ═══════════════════════════════════════════════════

## Overview
AcmeSaaS runs a dark-canvas SaaS aesthetic with a vibrant purple-to-blue gradient as its
brand signature. Headlines use a variable-weight sans-serif at maximum weight with tight
tracking; body text drops to a light cut for contrast. The shape language is "soft-modern"
— 8px on cards and inputs, pill-shaped CTAs — signaling approachability over precision.
Motion is generous: hero elements cascade in on load, cards lift on hover, and a scroll-
progress bar tracks reading depth. The grid is a strict 12-column at desktop, collapsing
to single-column on mobile with generous section breathing room.

---

colors:
  # ★ = user's NovaBrand values applied; (source) = kept from extracted site

  # Brand
  primary: "#7C3AED"              # ★ NovaBrand purple (replaced source #6366f1)
  primary-light: "#A78BFA"        # ★ NovaBrand purple-light
  accent: "#06B6D4"               # ★ NovaBrand cyan (replaced source #22d3ee)
  gradient-hero: "linear-gradient(135deg, #7C3AED 0%, #06B6D4 100%)"  # ★ applied

  # Surface (source structure kept)
  canvas: "#0F0F0F"               # ★ NovaBrand near-black
  surface-card: "#1A1A1A"         # (source) card background
  surface-elevated: "#242424"     # (source) modal / dropdown background
  surface-soft: "#111111"         # (source) subtle section alternator

  # Text
  on-dark: "#FFFFFF"              # (source)
  body: "#A1A1AA"                 # (source) zinc-400-equivalent
  muted: "#71717A"                # (source) zinc-500-equivalent

  # Semantic
  success: "#22C55E"              # (source)
  warning: "#F59E0B"              # (source)
  error: "#EF4444"                # (source)

  # Hairlines
  hairline: "#2A2A2A"             # (source)

---

typography:
  families:
    - name: "Inter"
      source: "Google Fonts"
      url: "https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
      weights: [300, 400, 600, 700]
    - name: "JetBrains Mono"
      source: "Google Fonts"
      url: "https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400&display=swap"
      weights: [400]
      usage: "code blocks only"

  display-xl:
    fontFamily: "Inter, sans-serif"
    fontSize: 72px
    fontWeight: 700
    lineHeight: 1.0
    letterSpacing: "-2px"
    textTransform: none
    usage: "hero h1"

  display-lg:
    fontFamily: "Inter, sans-serif"
    fontSize: 48px
    fontWeight: 700
    lineHeight: 1.1
    letterSpacing: "-1px"
    usage: "section headings"

  display-md:
    fontFamily: "Inter, sans-serif"
    fontSize: 36px
    fontWeight: 600
    lineHeight: 1.2
    letterSpacing: "-0.5px"
    usage: "sub-section headings, feature titles"

  title-lg:
    fontFamily: "Inter, sans-serif"
    fontSize: 24px
    fontWeight: 600
    lineHeight: 1.3
    letterSpacing: 0
    usage: "card titles"

  body-md:
    fontFamily: "Inter, sans-serif"
    fontSize: 16px
    fontWeight: 300
    lineHeight: 1.6
    letterSpacing: 0
    usage: "default body copy"

  body-sm:
    fontFamily: "Inter, sans-serif"
    fontSize: 14px
    fontWeight: 400
    lineHeight: 1.5
    letterSpacing: 0
    usage: "footer, captions, fine print"

  label:
    fontFamily: "Inter, sans-serif"
    fontSize: 12px
    fontWeight: 600
    lineHeight: 1.3
    letterSpacing: "1px"
    textTransform: "uppercase"
    usage: "category badges, section labels"

  button:
    fontFamily: "Inter, sans-serif"
    fontSize: 15px
    fontWeight: 600
    lineHeight: 1.0
    letterSpacing: "0.3px"
    usage: "all button labels"

  code:
    fontFamily: "JetBrains Mono, monospace"
    fontSize: 14px
    fontWeight: 400
    lineHeight: 1.6
    usage: "code blocks"

---

spacing:
  base-unit: 4px
  xxs: 4px
  xs: 8px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 40px
  xxl: 64px
  section: 96px
  hero: 128px

---

rounded:
  shape-language: "soft-modern"
  none: 0px
  xs: 4px
  sm: 8px       # dominant — cards, inputs, dropdowns
  md: 12px      # feature highlight cards
  lg: 16px      # modal dialogs
  full: 9999px  # pill buttons, badges, avatar circles

---

components:
  top-nav:
    backgroundColor: "rgba(15,15,15,0.85)"
    backdropFilter: "blur(12px)"
    textColor: "{colors.on-dark}"
    height: 64px
    position: "sticky top-0"
    borderBottom: "1px solid {colors.hairline}"
    typography: "{typography.body-sm}"
    note: "Glassmorphism nav — dark bg with blur, not solid"

  hero:
    backgroundColor: "{colors.canvas}"
    backgroundGradient: "radial-gradient from {colors.primary} at top-center, fading to canvas"
    textColor: "{colors.on-dark}"
    padding: "128px 0"
    layout: "centered single column, max-width 800px"
    typography: "{typography.display-xl}"
    note: "Gradient glow behind hero text, not full background fill"

  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "#FFFFFF"
    typography: "{typography.button}"
    rounded: "{rounded.full}"
    padding: "12px 28px"
    height: 48px
    hover: "brightness(1.1), scale(1.02)"

  button-secondary:
    backgroundColor: "transparent"
    border: "1px solid {colors.hairline}"
    textColor: "{colors.on-dark}"
    typography: "{typography.button}"
    rounded: "{rounded.full}"
    padding: "12px 28px"
    height: 48px
    hover: "border-color: {colors.primary}"

  feature-card:
    backgroundColor: "{colors.surface-card}"
    border: "1px solid {colors.hairline}"
    textColor: "{colors.on-dark}"
    rounded: "{rounded.sm}"
    padding: 24px
    hover: "border-color: {colors.primary}, translateY(-4px)"
    layout: "icon top-left → title → body"

  pricing-card:
    backgroundColor: "{colors.surface-elevated}"
    border: "1px solid {colors.hairline}"
    rounded: "{rounded.md}"
    padding: 32px
    featured-variant:
      border: "1px solid {colors.primary}"
      gradient-top: "subtle {colors.primary} glow at top edge"

  stat-cell:
    backgroundColor: "transparent"
    textColor: "{colors.on-dark}"
    value-typography: "{typography.display-md}"
    label-typography: "{typography.label}"
    layout: "value large → label small below"

  text-input:
    backgroundColor: "{colors.surface-card}"
    border: "1px solid {colors.hairline}"
    textColor: "{colors.on-dark}"
    rounded: "{rounded.sm}"
    padding: "10px 14px"
    height: 44px
    focus: "border-color: {colors.primary}, ring: {colors.primary} 20% opacity"

  footer:
    backgroundColor: "{colors.canvas}"
    borderTop: "1px solid {colors.hairline}"
    textColor: "{colors.muted}"
    typography: "{typography.body-sm}"
    padding: "64px 0"
    layout: "4-col links at desktop, 2-col at tablet, 1-col at mobile"

---

animations:
  hero-cascade:
    type: "CSS keyframe + stagger"
    trigger: "page load"
    elements: ["eyebrow label → h1 → subtitle → CTA buttons"]
    pattern: "each element fades in from opacity:0 translateY(20px), staggered 100ms"
    duration: "0.6s per element"
    easing: "cubic-bezier(0.16, 1, 0.3, 1)"
    library: null

  card-hover-lift:
    type: "CSS transition"
    trigger: "hover"
    duration: "0.25s"
    easing: "ease-out"
    properties: ["transform: translateY(-4px)", "border-color change", "box-shadow appear"]
    library: null

  scroll-fade-up:
    type: "JS / IntersectionObserver"
    trigger: "scroll into viewport"
    library: "AOS"
    pattern: "fade-up, 0.5s ease, 80px threshold, once:true"
    cdn: "https://unpkg.com/aos@2.3.1/dist/aos.js"
    css: "https://unpkg.com/aos@2.3.1/dist/aos.css"

  nav-scroll-glass:
    type: "JS scroll listener"
    trigger: "scroll > 50px"
    pattern: "nav gains backdrop-blur and border-bottom on scroll"
    library: null

  gradient-pulse:
    type: "CSS animation"
    trigger: "continuous / ambient"
    duration: "8s"
    easing: "ease-in-out"
    properties: ["background-position shift on hero gradient"]
    pattern: "slow drift creates living gradient feel"

---

breakpoints:
  mobile:
    at: 640px
    changes:
      - "nav → hamburger sheet (full-screen dark overlay)"
      - "hero h1: 72px → 40px"
      - "3-col feature grid → 1-col stack"
      - "pricing cards stack vertically"
      - "footer 4-col → 1-col"

  tablet:
    at: 768px
    changes:
      - "2-col feature grid"
      - "pricing cards: 2-up"
      - "hero text max-width relaxes"

  desktop:
    at: 1024px
    changes:
      - "3-col feature grid"
      - "pricing: 3-up"
      - "full horizontal nav"

  wide:
    at: 1280px
    changes:
      - "max content width: 1200px centered"
      - "hero gains side decorative elements"

---

assets_to_replace:
  - role: "site logo (light)"
    src: "/assets/logo-white.svg"
    replace: true
    note: "SVG, white version for dark backgrounds. Provide your own."

  - role: "hero background glow"
    src: "/assets/hero-glow.png"
    replace: true
    note: "Radial gradient PNG overlay. Can recreate in CSS with your brand color."

  - role: "feature icons"
    src: "/assets/icons/*.svg"
    replace: true
    note: "24×24 custom SVG icons. Replace with your own or use Lucide/Heroicons."

  - role: "og-image / social card"
    src: "/assets/og-image.png"
    replace: true
    note: "1200×630 social preview. Replace with your own."

---

do_not_copy:
  - "Google Analytics (gtag.js) — tracking script"
  - "Intercom chat widget (app.intercom.io) — third-party service"
  - "Hotjar tracking pixel — analytics noise"
  - "vendor.bundle.js — minified framework bundle, not design signal"
  - "runtime.chunk.js — webpack runtime, no design content"

---

notes:
  framework: "Tailwind v3 (detected via utility class patterns). Custom CSS layer on top."
  minified: false
  intentional_overrides:
    - "★ Hero gradient — custom, not a Tailwind default"
    - "★ Nav glassmorphism — custom backdrop-filter, not Tailwind out-of-box"
    - "★ Card hover glow — custom box-shadow using brand color"
  css_quirks:
    - "Hero uses CSS custom property animation for gradient drift — needs --hue-rotate trick"
    - "Pricing featured card uses CSS clip-path for top accent badge"
    - "Nav z-index: 1000 — watch for stacking issues with modals (z-index: 2000)"
