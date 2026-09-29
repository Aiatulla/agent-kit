# Full DNA Scanner — Output Example
# Source: hypothetical SaaS landing page (stripe-like dark theme)
# COLOR MODE: Site's original colors preserved exactly — no brand replacement

---

# ═══════════════════════════════════════════════════
# AcmeSaaS.com — Full Design DNA (Color-Faithful Clone)
# Extracted by: Full DNA Scanner
# Source: https://acmesaas.com (user-pasted HTML)
# Color mode: Site's original colors preserved exactly
# Framework detected: Tailwind v3 + custom CSS layer
# AI-ready: paste this doc as context into Claude, GPT, or Gemini
# ═══════════════════════════════════════════════════

## Overview
AcmeSaaS runs a near-black dark canvas with a vibrant indigo-to-cyan gradient as its hero
signature. The color system is disciplined: one primary brand color (#6366f1 indigo), one
accent (#06b6d4 cyan), and a carefully stepped grayscale surface stack from #0f0f0f to
#242424. Headlines use Inter at maximum weight (700) with tight negative tracking; body
drops to Light (300) — the weight gap is the editorial voice. Shape language is "pill-soft":
CTA buttons are fully rounded (9999px), cards are softly rounded (8px), and inputs sit in
between. Motion is generous but purposeful: hero elements cascade in on load using a snappy
expo ease, cards lift on hover, and scroll reveals use AOS fade-up.

---

## Color System

css_custom_properties:
  --color-primary: "#6366f1"
  --color-primary-hover: "#4f46e5"
  --color-primary-light: "#e0e7ff"
  --color-primary-subtle: "rgba(99, 102, 241, 0.12)"
  --color-accent: "#06b6d4"
  --color-accent-hover: "#0891b2"
  --color-canvas: "#0f0f0f"
  --color-surface: "#1a1a1a"
  --color-surface-elevated: "#242424"
  --color-surface-soft: "#111111"
  --color-text: "#ffffff"
  --color-text-body: "#a1a1aa"
  --color-text-muted: "#71717a"
  --color-border: "#27272a"
  --color-border-strong: "#3f3f46"
  --color-success: "#22c55e"
  --color-error: "#ef4444"
  --color-warning: "#f59e0b"

color_palette:
  brand:
    primary: "#6366f1"
    primary-hover: "#4f46e5"
    primary-light: "#e0e7ff"
    primary-subtle: "rgba(99, 102, 241, 0.12)"
    accent: "#06b6d4"
    accent-hover: "#0891b2"

  surfaces:
    canvas: "#0f0f0f"
    card: "#1a1a1a"
    elevated: "#242424"
    soft: "#111111"

  text:
    primary: "#ffffff"
    body: "#a1a1aa"
    muted: "#71717a"

  borders:
    default: "#27272a"
    strong: "#3f3f46"

  semantic:
    success: "#22c55e"
    error: "#ef4444"
    warning: "#f59e0b"
    info: "#3b82f6"

gradients:
  - name: "hero-gradient"
    value: "linear-gradient(135deg, #6366f1 0%, #06b6d4 100%)"
    usage: "hero section background glow (radial, not full fill)"
  - name: "card-shimmer"
    value: "linear-gradient(180deg, rgba(255,255,255,0.06) 0%, rgba(255,255,255,0) 100%)"
    usage: ".feature-card::before — subtle top highlight"
  - name: "primary-glow"
    value: "radial-gradient(ellipse at top, rgba(99,102,241,0.15) 0%, transparent 60%)"
    usage: "hero background ambient glow"

color_mode:
  default: "dark"
  supports_light: false
  note: "Dark-only site — no prefers-color-scheme override found"

svg_colors:
  - value: "#ffffff"
    element: "nav icons, button icons"
    property: "currentColor"
    note: "Icons inherit parent text color"
  - value: "#6366f1"
    element: "logo mark"
    property: "fill"
  - value: "#06b6d4"
    element: "logo accent dot"
    property: "fill"

---

## Typography

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

scale:
  display-xl:
    fontFamily: "Inter, sans-serif"
    fontSize: 72px
    fontWeight: 700
    lineHeight: 1.0
    letterSpacing: "-2px"
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
    usage: "card titles"

  body-md:
    fontFamily: "Inter, sans-serif"
    fontSize: 16px
    fontWeight: 300
    lineHeight: 1.6
    usage: "default body copy"

  body-sm:
    fontFamily: "Inter, sans-serif"
    fontSize: 14px
    fontWeight: 400
    lineHeight: 1.5
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
    letterSpacing: "0.3px"
    usage: "all button labels"

  code:
    fontFamily: "JetBrains Mono, monospace"
    fontSize: 14px
    fontWeight: 400
    lineHeight: 1.6
    usage: "code blocks"

patterns:
  - "Heavy display (700) vs Light body (300) — weight contrast is the editorial signature"
  - "Negative letter-spacing on display (-2px at 72px, -1px at 48px) — tight modern feel"
  - "Button labels slightly letterspaced (+0.3px) — intentional, not framework default"

---

## Spacing

base-unit: 4px
scale:
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

## Border Radius

shape-language: "pill-soft — fully rounded CTAs, gently rounded cards, sharp tables"
scale:
  none: 0px
  xs: 4px
  sm: 8px       # dominant for cards and inputs
  md: 12px      # feature highlight cards
  lg: 16px      # modal dialogs
  full: 9999px  # primary buttons, badges, avatar circles

---

## Components

top-nav:
  backgroundColor: "rgba(15,15,15,0.85)"
  backdropFilter: "blur(12px)"
  textColor: "#ffffff"
  height: 64px
  position: "sticky top-0 z-1000"
  borderBottom: "1px solid #27272a"
  typography: "Inter 14px/400"
  note: "Glassmorphism — gains blur + border on scroll via JS"

hero:
  backgroundColor: "#0f0f0f"
  backgroundEffect: "radial-gradient(ellipse at top, rgba(99,102,241,0.15), transparent)"
  textColor: "#ffffff"
  padding: "128px 0"
  maxWidth: "800px centered"
  layout: "single column center-aligned"
  eyebrow-color: "#6366f1"

button-primary:
  backgroundColor: "#6366f1"
  textColor: "#ffffff"
  rounded: "9999px"
  padding: "12px 28px"
  height: 48px
  hover:
    backgroundColor: "#4f46e5"
    transform: "scale(1.02)"

button-secondary:
  backgroundColor: "transparent"
  border: "1px solid #27272a"
  textColor: "#ffffff"
  rounded: "9999px"
  padding: "12px 28px"
  height: 48px
  hover:
    borderColor: "#6366f1"

feature-card:
  backgroundColor: "#1a1a1a"
  border: "1px solid #27272a"
  textColor: "#ffffff"
  rounded: "8px"
  padding: 24px
  pseudoBefore: "linear-gradient top highlight rgba(255,255,255,0.06)"
  hover:
    borderColor: "#6366f1"
    transform: "translateY(-4px)"
    transition: "0.25s ease-out"

pricing-card:
  backgroundColor: "#242424"
  border: "1px solid #27272a"
  rounded: "12px"
  padding: 32px
  featured-variant:
    border: "1px solid #6366f1"
    backgroundGlow: "radial-gradient from rgba(99,102,241,0.08) at top"

stat-cell:
  backgroundColor: "transparent"
  value:
    fontSize: 36px
    fontWeight: 700
    color: "#ffffff"
  label:
    fontSize: 12px
    fontWeight: 600
    letterSpacing: "1px"
    textTransform: "uppercase"
    color: "#a1a1aa"

text-input:
  backgroundColor: "#1a1a1a"
  border: "1px solid #27272a"
  textColor: "#ffffff"
  placeholderColor: "#71717a"
  rounded: "8px"
  padding: "10px 14px"
  height: 44px
  focus:
    borderColor: "#6366f1"
    ring: "rgba(99,102,241,0.2) 3px"

badge:
  backgroundColor: "rgba(99,102,241,0.12)"
  textColor: "#818cf8"
  rounded: "9999px"
  padding: "4px 12px"
  fontSize: 12px
  fontWeight: 600

footer:
  backgroundColor: "#0f0f0f"
  borderTop: "1px solid #27272a"
  textColor: "#71717a"
  fontSize: 14px
  padding: "64px 0"
  layout: "4-col at desktop → 2-col tablet → 1-col mobile"

---

## Animations

hero-cascade:
  type: "CSS keyframe + JS stagger"
  trigger: "page load"
  sequence: "badge → h1 → subtitle → buttons (100ms apart)"
  from: "opacity:0, translateY(20px)"
  to: "opacity:1, translateY(0)"
  duration: "0.6s per element"
  easing: "cubic-bezier(0.16, 1, 0.3, 1)"
  library: null

card-hover-lift:
  type: "CSS transition"
  trigger: "hover"
  duration: "0.25s"
  easing: "ease-out"
  properties: ["translateY(-4px)", "border-color → #6366f1", "box-shadow appear"]

scroll-fade-up:
  type: "JS"
  trigger: "scroll into viewport"
  library: "AOS"
  config: "duration:600, once:true, offset:80"
  pattern: "fade-up on enter"
  cdn_css: "https://unpkg.com/aos@2.3.1/dist/aos.css"
  cdn_js: "https://unpkg.com/aos@2.3.1/dist/aos.js"

nav-glass-on-scroll:
  type: "JS scroll listener"
  trigger: "window.scrollY > 50"
  effect: "nav gains backdrop-blur(12px) + border-bottom"
  library: null

gradient-drift:
  type: "CSS animation"
  trigger: "ambient / continuous"
  duration: "8s ease-in-out infinite alternate"
  effect: "hero background-position shifts slowly — gives gradient a living feel"

---

## Breakpoints

mobile:
  at: 640px
  changes:
    - "nav → full-screen hamburger overlay (bg #0f0f0f)"
    - "hero h1: 72px → 40px, letter-spacing: -2px → -1px"
    - "3-col feature grid → 1-col stack"
    - "pricing cards → vertical stack"
    - "footer 4-col → 1-col"
    - "hero padding: 128px → 80px"

tablet:
  at: 768px
  changes:
    - "2-col feature grid"
    - "pricing: 2-up (featured center)"
    - "hero max-width: 800px → full width"

desktop:
  at: 1024px
  changes:
    - "3-col feature grid"
    - "3-col pricing"
    - "full horizontal nav visible"

wide:
  at: 1280px
  changes:
    - "max content width: 1200px centered"
    - "hero gains decorative floating UI elements left/right"

---

## Assets

logo:
  src: "/assets/logo-white.svg"
  replace: true
  note: "SVG. Fill: #6366f1 (logomark) + #ffffff (wordmark). Provide your own."

hero-glow-texture:
  src: "/assets/hero-noise.png"
  replace: false
  note: "Subtle noise texture overlay on hero. Optional — can omit."

feature-icons:
  src: "/assets/icons/*.svg"
  replace: true
  note: "24×24 SVGs using currentColor. Replace with Lucide or your own."

og-image:
  src: "/assets/og-image.png"
  replace: true
  note: "1200×630. Replace with yours."

---

## Do Not Copy

- "Google Analytics (gtag.js)"
- "Intercom chat widget (app.intercom.io)"
- "Hotjar (static.hotjar.com)"
- "vendor.bundle.js — minified React + dependencies"
- "runtime.chunk.js — webpack runtime"

---

## Notes

framework: "Tailwind v3 (utility classes detected) + custom CSS layer (★ overrides)"
minified: false
color_mode: "dark-only"
near_duplicate_colors: []
framework_default_colors:
  - value: "#3b82f6"
    note: "Tailwind blue-500 — appears only in info/semantic context. Kept as info color."

intentional_overrides_marked_with_star:
  - "★ Hero gradient glow — custom, not Tailwind default"
  - "★ Nav glassmorphism backdrop-filter — custom CSS"
  - "★ Card ::before shimmer — custom pseudo-element gradient"
  - "★ Negative letter-spacing on display headings — custom"
