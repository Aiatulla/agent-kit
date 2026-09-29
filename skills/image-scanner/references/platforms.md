# Platform Code Generation Reference

Read the relevant section(s) before generating code. Cross-reference if the user's stack spans multiple platforms (e.g. a React Native app with a shared web landing page).

---

## Table of Contents
1. [Web — HTML/CSS/JS](#web-html)
2. [Web — React/JSX](#web-react)
3. [Web — Vue](#web-vue)
4. [Web — Svelte](#web-svelte)
5. [Mobile — React Native](#react-native)
6. [Mobile — Flutter (Dart)](#flutter)
7. [Mobile — SwiftUI (iOS/macOS)](#swiftui)
8. [Mobile — Jetpack Compose (Android)](#compose)
9. [Desktop — Electron / Tauri](#desktop-electron)
10. [Desktop — WPF (.NET)](#wpf)
11. [Design Token Patterns](#tokens)

---

## 1. Web — HTML/CSS/JS {#web-html}

**Unit system**: `px` for fixed values, `rem` for typography, `%` / `vw` / `vh` for fluid layout.

**Color/token pattern** — always extract to CSS custom properties at the top:
```css
:root {
  --color-bg: #0f0f0f;
  --color-surface: #1a1a1a;
  --color-primary: #6366f1;
  --color-accent: #f59e0b;
  --color-text: #f1f5f9;
  --color-muted: #94a3b8;
  --color-border: #334155;
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 16px;
  --radius-pill: 9999px;
  --space-unit: 8px;
}
```

**Layout**: CSS Grid for page-level, Flexbox for component-level.

**Shadows**: Use multi-layer shadows for depth:
```css
box-shadow: 0 1px 3px rgba(0,0,0,.12), 0 4px 16px rgba(0,0,0,.08);
```

**Responsive**: Mobile-first `min-width` breakpoints — `480px`, `768px`, `1024px`, `1280px`. Only generate if user confirmed responsive needed.

**Fonts**: Use Google Fonts `@import` for web fonts. Detect personality from image and pick a matching typeface — never default to Inter/Arial/Roboto.

**Animations**: CSS `transition` for hover states, `@keyframes` for entrances. Prefer `transform` and `opacity` (GPU-composited) over layout-affecting properties.

---

## 2. Web — React/JSX {#web-react}

**Component structure**:
```jsx
// Functional component with named export
export function ComponentName({ prop1, prop2 = 'default' }) {
  const [state, setState] = useState(null);
  return ( /* JSX */ );
}
```

**Styling options** (ask if unclear):
- **CSS Modules** (default safe choice): `import styles from './Component.module.css'`
- **Tailwind**: only if user confirms it's in the project
- **styled-components** / **Emotion**: only if user confirms
- **Inline styles**: only for dynamic values tied to props/state

**CSS variables still apply** — define them in a global stylesheet or `:root` block.

**Props design**: For any variant visible in the image (e.g. a card in default + highlighted state), expose a prop:
```jsx
function Card({ variant = 'default', title, description }) { ... }
```

**Hooks**: `useState` for toggle/interactive states visible in image. `useRef` for measurements if needed.

**File split**: One file per distinct component. Group related sub-components in the same file only if small (<60 lines).

---

## 3. Web — Vue {#web-vue}

Use **Vue 3 Composition API** (`<script setup>` syntax):
```vue
<script setup>
import { ref, computed } from 'vue'
const isOpen = ref(false)
</script>

<template>
  <div :class="['card', { 'card--active': isOpen }]">...</div>
</template>

<style scoped>
.card { /* scoped CSS */ }
</style>
```

- Use `v-bind` shorthand (`:`) and `v-on` shorthand (`@`)
- CSS vars in `<style scoped>` work — prefer over inline styles
- For component libraries: mention Vuetify/PrimeVue/Naive if relevant

---

## 4. Web — Svelte {#web-svelte}

```svelte
<script>
  let count = 0;
  $: doubled = count * 2;
</script>

<div class="card">...</div>

<style>
  .card { /* automatically scoped */ }
</style>
```

- Svelte's `{#if}`, `{#each}`, `{#await}` blocks for conditional/list rendering
- Transitions: `import { fade, fly, slide } from 'svelte/transition'`
- Stores for cross-component state: `import { writable } from 'svelte/store'`

---

## 5. Mobile — React Native {#react-native}

**Critical differences from web**:
- No CSS — use `StyleSheet.create({})` only
- No `px` — all values are density-independent points (just numbers: `16` not `'16px'`)
- Layout is **Flexbox only** — `flexDirection` defaults to `'column'` (opposite of web)
- No `overflow: scroll` — use `<ScrollView>` or `<FlatList>`
- No `<div>` — use `<View>`, `<Text>`, `<Image>`, `<Pressable>`

**Template**:
```jsx
import { View, Text, StyleSheet, Pressable } from 'react-native';

export function Card({ title, onPress }) {
  return (
    <Pressable style={({ pressed }) => [styles.card, pressed && styles.pressed]} onPress={onPress}>
      <Text style={styles.title}>{title}</Text>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: '#1a1a2e',
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    // iOS shadow
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.15,
    shadowRadius: 8,
    // Android shadow
    elevation: 4,
  },
  pressed: { opacity: 0.85 },
  title: { fontSize: 16, fontWeight: '600', color: '#fff' },
});
```

**Dimensions**: Use `Dimensions.get('window')` or `useWindowDimensions()` for responsive sizing. Safe area: `import { SafeAreaView } from 'react-native-safe-area-context'`.

**Navigation hints**: If multiple screens detected, mention React Navigation stack/tab structure.

---

## 6. Mobile — Flutter (Dart) {#flutter}

**Structure**:
```dart
class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(title, style: theme.textTheme.titleMedium),
      ),
    );
  }
}
```

**Layout widgets**: `Column`, `Row`, `Stack`, `Wrap`, `GridView`, `ListView`.
**Spacing**: `SizedBox(height: 16)` or `Padding`. Never hardcode magic numbers — use `const` values.
**Colors**: Define in `ThemeData` or as `const Color(0xFF6366F1)`.
**State**: `StatefulWidget` + `setState` for simple state; mention `Provider`/`Riverpod` for complex state.
**Responsive**: `LayoutBuilder` + `MediaQuery` for adaptive layouts.

---

## 7. Mobile — SwiftUI (iOS / macOS) {#swiftui}

```swift
struct CardView: View {
    let title: String
    let subtitle: String
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            if isExpanded {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .transition(.opacity)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
        .onTapGesture { withAnimation { isExpanded.toggle() } }
    }
}
```

- Use `@State` for local, `@Binding` for passed-down, `@StateObject`/`@ObservedObject` for models
- Colors: `Color("BrandPrimary")` (Assets catalog) or `Color(hex: "#6366F1")` with extension
- `LazyVGrid` / `LazyHGrid` for grid layouts; `List` for table-style
- `NavigationStack` (iOS 16+) or `NavigationView` for nav structure
- Animations: `.animation(.spring(), value: state)` or `withAnimation { }`

---

## 8. Mobile — Jetpack Compose (Android) {#compose}

```kotlin
@Composable
fun CardItem(
    title: String,
    modifier: Modifier = Modifier
) {
    Card(
        modifier = modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp, vertical = 8.dp),
        shape = RoundedCornerShape(12.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface)
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(
                text = title,
                style = MaterialTheme.typography.titleMedium,
                color = MaterialTheme.colorScheme.onSurface
            )
        }
    }
}
```

- Use `Material3` components as foundation — extend, don't fight them
- `dp` for layout, `sp` for text
- `Modifier` chain for layout, padding, click, size
- State: `remember { mutableStateOf() }` locally; `ViewModel` + `StateFlow` for screen-level
- Animations: `AnimatedVisibility`, `animateFloatAsState`, `Crossfade`

---

## 9. Desktop — Electron / Tauri {#desktop-electron}

Treat the UI layer as **web** — use HTML/CSS/JS or a web framework (React, Vue, Svelte).

Key differences from pure web:
- Window chrome may be visible in the image — note title bar, traffic light buttons (macOS), or custom drag region
- Native menus: mention `Menu` API if a menu bar is visible
- Custom title bar: `<div style="-webkit-app-region: drag">` for draggable regions
- Desktop-appropriate sizing: default font size 14–15px (not 16px web default), tighter spacing
- No mobile breakpoints needed unless the window is resizable to very narrow widths

---

## 10. Desktop — WPF (.NET) {#wpf}

```xml
<UserControl x:Class="App.CardControl"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation">
    <Border Background="{StaticResource SurfaceBrush}"
            CornerRadius="8" Padding="16"
            Effect="{StaticResource CardShadow}">
        <StackPanel>
            <TextBlock Text="{Binding Title}"
                       Style="{StaticResource HeadlineStyle}"/>
        </StackPanel>
    </Border>
</UserControl>
```

- Define colors in `ResourceDictionary` as `SolidColorBrush`
- Use `Grid` for layout (rows/columns), `StackPanel` for linear stacks
- MVVM: `INotifyPropertyChanged`, commands via `ICommand` or `RelayCommand`
- Animations: `Storyboard` + `DoubleAnimation` / `ColorAnimation`

---

## 11. Design Token Patterns {#tokens}

When the user provides a token file, parse it into the format the target platform expects:

**CSS variables (Web)**:
```css
:root { --color-primary: #6366f1; --radius-md: 8px; }
```

**JS/TS token object (React Native / React)**:
```ts
export const tokens = { colors: { primary: '#6366f1' }, radius: { md: 8 } };
```

**Dart constants (Flutter)**:
```dart
class AppColors { static const primary = Color(0xFF6366F1); }
```

**Swift constants (SwiftUI)**:
```swift
extension Color { static let brandPrimary = Color(hex: "#6366F1") }
```

**Kotlin object (Compose)**:
```kotlin
object AppColors { val Primary = Color(0xFF6366F1) }
```
